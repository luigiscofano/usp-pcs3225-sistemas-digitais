`timescale 1ns/1ps
module immediate_generator(input wire [31:0] instruction,output reg [31:0] immediate);
 always @* case(instruction[6:0])
  7'h13,7'h03,7'h67:immediate={{20{instruction[31]}},instruction[31:20]};
  7'h23:immediate={{20{instruction[31]}},instruction[31:25],instruction[11:7]};
  7'h63:immediate={{19{instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0};
  7'h37,7'h17:immediate={instruction[31:12],12'b0};
  7'h6f:immediate={{11{instruction[31]}},instruction[31],instruction[19:12],instruction[20],instruction[30:21],1'b0};
  default:immediate=0;
 endcase
endmodule
