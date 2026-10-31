`timescale 1ns/1ps
// Programa demonstrativo novo: r1=5; r2=7; r3=r1+r2; HALT.
module rom(input wire [4:0] address,output reg [15:0] instruction);
 always @* case(address)
  0:instruction=16'h1105;1:instruction=16'h1207;2:instruction=16'h2312;
  default:instruction=16'h0000;
 endcase
endmodule
