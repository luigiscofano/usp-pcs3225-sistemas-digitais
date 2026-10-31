module add3or0(input wire [3:0] digit,output wire [3:0] corrected);
 assign corrected=(digit>=5)?digit+4'd3:digit;
endmodule
