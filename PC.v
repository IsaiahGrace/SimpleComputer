module PC (CLK, AR, PCC, POA, PLA, POD, PLD, DATA, ADDR);
   input wire CLK;
   input wire AR;
   input wire PCC;
   input wire PLA;
   input wire POD;
   input wire PLD;
   inout wire [15:0] DATA;
   inout wire [7:0]  ADDR;

   reg [7:0] pc;
   reg [7:0] next_pc;

   assign DATA = POD ? {8'bzzzzzzzz, pc} : 16'bzzzzzzzzzzzzzzzz;
   assign ADDR = POA ? pc :  8'bzzzzzzzz;
   
   always @ (CLK, AR) begin
      if (AR) pc <= 8'b00000000;
      else pc <= next_pc;
   end

   always @ (PCC, PLA, PLD, DATA, ADDR, pc) begin
      if (PCC) next_pc = pc + 1;
      else if (PLD) next_pc = DATA[7:0];
      else if (PLA) next_pc = ADDR;
      else next_pc = pc;
   end
endmodule // PC
