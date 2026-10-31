`timescale 1ns/1ps
module alu(input wire [31:0] a,b,input wire [3:0] op,output reg [31:0] y);
 always @* case(op)
  2:y=a+b;3:y=a-b;4:y=a&b;5:y=a|b;6:y=a^b;default:y=0;
 endcase
endmodule
