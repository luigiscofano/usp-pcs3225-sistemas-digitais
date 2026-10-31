module double_dabble #(parameter W=18,parameter DIGITS=(W*30103)/100000+1)(
 input wire clk,rst,start,input wire [W-1:0] binary,
 output wire done,output reg [4*DIGITS-1:0] bcd,output wire [1:0] state_debug);
 localparam INIT=0,CORRECT=1,SHIFT=2,WAIT=3;
 reg [1:0] state;reg [W-1:0] shift_binary;
 integer count;
 wire [4*DIGITS-1:0] corrected;
 genvar i;
 generate for(i=0;i<DIGITS;i=i+1)begin:corretores
  add3or0 u(bcd[4*i+:4],corrected[4*i+:4]);
 end endgenerate
 assign done=(state==WAIT);assign state_debug=state;
 always @(posedge clk)begin
  if(rst)begin state<=INIT;bcd<=0;shift_binary<=0;count<=0;end
  else case(state)
   INIT:if(start)begin bcd<=0;shift_binary<=binary;count<=0;state<=CORRECT;end
   CORRECT:begin bcd<=corrected;state<=SHIFT;end
   SHIFT:begin
    bcd<={bcd[4*DIGITS-2:0],shift_binary[W-1]};shift_binary<=shift_binary<<1;
    if(count==W-1)state<=WAIT;else begin count<=count+1;state<=CORRECT;end
   end
   WAIT:if(!start)state<=INIT;
   default:state<=INIT;
  endcase
 end
endmodule
