`timescale 1ns/1ps
module riscv_tb;
 reg clk=0;always #5 clk=~clk;reg rst=1;
 wire [31:0] pc,address,write_data,x10;wire trap,we;
 reg [31:0] code[0:31],memory[0:31];integer i;
 wire [31:0] instruction=pc<128?code[pc[6:2]]:32'hffffffff;
 wire [31:0] data=address<128?memory[address[6:2]]:0;
 rv32_core cpu(clk,rst,instruction,data,pc,trap,we,address,write_data,x10);
 always @(posedge clk)if(we)begin if(address>=128)$fatal(1,"Memoria fora dos limites");memory[address[6:2]]<=write_data;end
 function [31:0] addi(input [4:0] rd,rs,input integer value);addi={value[11:0],rs,3'b000,rd,7'h13};endfunction
 task reiniciar;begin rst=1;repeat(2)@(negedge clk);rst=0;end endtask
 initial begin
  for(i=0;i<32;i=i+1)begin code[i]=32'h00000013;memory[i]=0;end
  code[0]=addi(1,0,5);code[1]=addi(2,0,7);code[2]=32'h00208533; // add x10,x1,x2
  code[3]=32'h00a02023;code[4]=32'h00002183; // sw x10,0(x0); lw x3,0(x0)
  code[5]=32'h00350463;code[6]=addi(10,0,99); // beq x10,x3,+8
  code[7]=addi(0,0,100);code[8]=32'h40150533; // x0 imutável; sub x10,x10,x1
  code[9]=32'hffffffff;
  reiniciar();repeat(12)@(negedge clk);
  if(!trap||x10!=7||memory[0]!=12||cpu.regs[0]!=0)$fatal(1,"Programa RV32 falhou");
  code[0]=32'h00202083; // lw desalinhado
  reiniciar();@(negedge clk);if(!trap||we)$fatal(1,"Alinhamento não detectado");
  code[0]=32'h4000f033; // funct7 inválido em AND
  reiniciar();@(negedge clk);if(!trap)$fatal(1,"Instrução ilegal não detectada");
  code[0]=addi(1,0,-1);code[1]=32'h00001537; // lui x10,1
  code[2]=32'h00156533; // or x10,x10,x1 => -1
  code[3]=32'h00157533; // and => -1
  code[4]=32'h00154533; // xor => 0
  code[5]=32'h00000517; // auipc x10,0 => 20
  code[6]=32'h008002ef; // jal x5,+8, link28
  code[7]=addi(10,0,99);code[8]=addi(6,0,44);
  code[9]=32'h00030067; // jalr x0,0(x6) =>44
  code[10]=addi(10,0,99);code[11]=32'h00101463; // bne x0,x1,+8
  code[12]=addi(10,0,99);code[13]=32'hffffffff;
  reiniciar();repeat(16)@(negedge clk);
  if(!trap||x10!=20||cpu.regs[5]!=28||cpu.regs[1]!=32'hffffffff)$fatal(1,"Saltos/ULA/imediatos falharam");
  $display("PASS: RV32I subset, memoria, branches, saltos, x0, imediato negativo e traps");$finish;
 end
endmodule
