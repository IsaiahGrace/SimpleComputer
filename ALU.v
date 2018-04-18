module ALU (CLK, AR, AOE, ALE, ALS, CF, ZF, NF, VF, DATA);
   input wire CLK;
   input wire AR;
   input wire AOE;
   input wire ALE;
   input wire [1:0] ALS;
   inout wire [15:0] DATA;
   output reg CF, ZF, NF, VF;
   
   reg [7:0] AREG;

   assign DATA = AOE ? {8'b00000000, AREG} : 16'bzzzzzzzzzzzzzzzz;
   
   // Need to map out opcodes and instruction set before I can write most of the ALU


endmodule // ALU
