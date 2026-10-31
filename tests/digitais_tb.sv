`timescale 1ns/1ps
module digitais_tb;
 reg clk=0;always #5 clk=~clk;
 reg rst=1,start=0;reg [17:0] binary=0;wire done;wire [23:0] bcd;wire [1:0] state;
 double_dabble dd(clk,rst,start,binary,done,bcd,state);
 reg rst8=1,start8=0;reg [7:0] binary8=0;wire done8;wire [11:0] bcd8;
 double_dabble #(.W(8)) dd8(.clk(clk),.rst(rst8),.start(start8),.binary(binary8),.done(done8),.bcd(bcd8),.state_debug());
 wire calc_done,calc_fault;wire [4:0] calc_pc;wire [31:0] calc_result;
 calculadora calc(clk,rst,calc_done,calc_fault,calc_pc,calc_result);
 integer n,j,decimal_value,cycles;integer seed=13680334;
 task convert18(input integer number);
  begin
   @(negedge clk);start=1;binary=number;@(negedge clk);cycles=0;
   while(!done&&cycles<40)begin @(negedge clk);cycles=cycles+1;end
   if(!done)$fatal(1,"Timeout double-dabble");
   decimal_value=0;for(j=5;j>=0;j=j-1)begin if(bcd[4*j+:4]>9)$fatal(1,"BCD inválido");decimal_value=decimal_value*10+bcd[4*j+:4];end
   if(decimal_value!=number)$fatal(1,"Esperado %d obtido %d",number,decimal_value);
   @(negedge clk);if(!done)$fatal(1,"done não ficou estável");start=0;@(negedge clk);
  end
 endtask
 initial begin
  $dumpfile("build/double_dabble.vcd");$dumpvars(0,clk,rst,start,binary,done,bcd,state);
  repeat(2)@(negedge clk);rst=0;rst8=0;
  convert18(42);$dumpoff;
  convert18(0);convert18(1);convert18(262143);
  for(n=0;n<1000;n=n+1)convert18($unsigned($random(seed))%262144);
  for(n=0;n<256;n=n+1)begin
   @(negedge clk);binary8=n;start8=1;@(negedge clk);cycles=0;
   while(!done8&&cycles<20)begin @(negedge clk);cycles=cycles+1;end
   if(!done8||((bcd8[11:8]*100)+(bcd8[7:4]*10)+bcd8[3:0])!=n)$fatal(1,"Conversao W8 falhou");
   start8=0;@(negedge clk);
  end
  if(!calc_done||calc_fault||calc_result!=12)$fatal(1,"Calculadora falhou");
  // Reset durante operação deve abortar e liberar o próximo start.
  start=1;repeat(3)@(negedge clk);rst=1;@(negedge clk);if(done||bcd!=0)$fatal(1,"Reset falhou");rst=0;start=0;
  convert18(99999);
  $display("PASS: 1005 conversoes W18, 256 W8, reset, handshake e calculadora");$finish;
 end
endmodule
