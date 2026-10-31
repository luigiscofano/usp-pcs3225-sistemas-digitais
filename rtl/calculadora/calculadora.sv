`timescale 1ns/1ps
module calculadora(input wire clk,rst,output reg done,fault,output reg [4:0] pc,output wire [31:0] resultado);
 wire [15:0] instruction;rom programa(pc,instruction);
 wire [3:0] op=instruction[15:12],rd=instruction[11:8];
 wire [31:0] a,b,y;wire we=(!done&&!fault)&&((op>=1)&&(op<=6));
 wire [31:0] wd=op==1?{{24{instruction[7]}},instruction[7:0]}:y;
 registerfile banco(clk,rst,we,rd,instruction[7:4],instruction[3:0],wd,a,b,resultado);
 alu unidade(a,b,op,y);
 integer next_pc;
 always @* begin
  next_pc=pc+1;
 end
 // Opcodes fora do conjunto documentado causam fault.
 always @(posedge clk)begin
  if(rst)begin pc<=0;done<=0;fault<=0;end
  else if(!done&&!fault)begin
   if(op==0)done<=1;
   else if(op>6||next_pc>31||next_pc<0)fault<=1;
   else pc<=next_pc[4:0];
  end
 end
endmodule
