module IR (CLK, AR, IRL, IRA, IOP, DATA, ADDR);
   input wire CLK;
   input wire AR;
   input wire IRL;
   input wire IRA;
   output wire IOP;
   input wire [15:0] DATA;
   output wire [7:0] ADDR;

   reg [15:0] ir;
   assign IOP = ir[15:8];
   assign ADDR = IRA ? ir[7:0] : 8'bzzzz zzzz;
   
   always @ (posedge CLK, posedge AR) begin
      if (AR) ir <= 16'b0000 0000 0000 0000;
      else if (IRL) ir <= DATA;
   end
endmodule // IR

	 
