module MEM (CLK, MSL, MOE, MWE, DATA, ADDR, MEM_ADDR, MEM_DATA, MEM_EDIT);
   input wire CLK, MSL, MOE, MWE;
   inout wire [15:0] DATA;
   input wire [7:0]  ADDR;
   input wire [7:0]  MEM_ADDR;
   input wire [7:0]  MEM_DATA;
   input wire 	     MEM_EDIT;

   reg [7:0] mem[255:0]; // 256 8-bit memory locations
   reg [15:0] data;
   assign DATA = (MSL & MOE) ? data : 8'bzzzzzzzz;
   
   always @ (posedge CLK) begin
      data <= {mem[ADDR] , mem[ADDR + 1]};
      if (MWE & MSL) mem[ADDR] <= DATA[7:0];
   end

   always @ (posedge MEM_EDIT) begin
      mem[MEM_ADDR] <= MEM_DATA;
   end
   
endmodule // MEM

	 
