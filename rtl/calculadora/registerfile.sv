`timescale 1ns/1ps
module registerfile(input wire clk,rst,we,input wire [3:0] rd,ra,rb,
 input wire [31:0] wd,output wire [31:0] a,b,debug_r3);
 reg [31:0] regs[0:15];integer i;
 assign a=regs[ra];assign b=regs[rb];assign debug_r3=regs[3];
 always @(posedge clk)begin
  if(rst)for(i=0;i<16;i=i+1)regs[i]<=0;
  else if(we)regs[rd]<=wd;
 end
endmodule
