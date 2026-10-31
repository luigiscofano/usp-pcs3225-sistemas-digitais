`timescale 1ns/1ps
// Subconjunto didático monociclo RV32I. Não implementa a ISA completa.
module rv32_core(input wire clk,rst,input wire [31:0] instruction,read_data,
 output reg [31:0] pc,output reg trap,output reg mem_write,
 output reg [31:0] address,write_data,output wire [31:0] debug_x10);
 reg [31:0] regs[0:31];integer i;
 wire [4:0] rs1=instruction[19:15],rs2=instruction[24:20],rd=instruction[11:7];
 wire [6:0] opcode=instruction[6:0],funct7=instruction[31:25];
 wire [2:0] funct3=instruction[14:12];wire [31:0] immediate;
 immediate_generator imm(instruction,immediate);
 wire [31:0] a=regs[rs1],b=regs[rs2];
 reg [31:0] next_pc,result;reg write_reg,illegal;
 assign debug_x10=regs[10];
 always @* begin
  next_pc=pc+4;result=0;write_reg=0;mem_write=0;address=0;write_data=b;illegal=0;
  case(opcode)
   7'h13:begin if(funct3!=0)illegal=1;else begin result=a+immediate;write_reg=1;end end
   7'h33:begin
    write_reg=1;
    case({funct7,funct3})
     10'b0000000000:result=a+b;
     10'b0100000000:result=a-b;
     10'b0000000111:result=a&b;
     10'b0000000110:result=a|b;
     10'b0000000100:result=a^b;
     default:illegal=1;
    endcase
   end
   7'h03:begin address=a+immediate;result=read_data;write_reg=1;if(funct3!=2||address[1:0]!=0)illegal=1;end
   7'h23:begin address=a+immediate;mem_write=1;if(funct3!=2||address[1:0]!=0)illegal=1;end
   7'h63:begin
    if(funct3==0)begin if(a==b)next_pc=pc+immediate;end
    else if(funct3==1)begin if(a!=b)next_pc=pc+immediate;end
    else illegal=1;
   end
   7'h37:begin result=immediate;write_reg=1;end
   7'h17:begin result=pc+immediate;write_reg=1;end
   7'h6f:begin result=pc+4;write_reg=1;next_pc=pc+immediate;end
   7'h67:begin result=pc+4;write_reg=1;next_pc=(a+immediate)&32'hfffffffe;if(funct3!=0)illegal=1;end
   default:illegal=1;
  endcase
  if(pc[1:0]!=0||next_pc[1:0]!=0)illegal=1;
  if(illegal||trap||rst)begin mem_write=0;write_reg=0;end
 end
 always @(posedge clk)begin
  if(rst)begin pc<=0;trap<=0;for(i=0;i<32;i=i+1)regs[i]<=0;end
  else if(!trap)begin
   if(illegal)trap<=1;
   else begin pc<=next_pc;if(write_reg&&rd!=0)regs[rd]<=result;end
  end
 end
endmodule
