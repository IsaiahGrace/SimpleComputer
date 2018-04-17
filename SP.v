module SP (CLK, AR, SPI, SPD, SPA, ADDR);
   input wire CLK;
   input wire AR;
   input wire SPI;
   input wire SPD;
   input wire SPA;
   inout wire [7:0] ADDR;

   reg [7:0] sp;
   reg [7:0] next_sp;

   assign ADDR = SPA ? sp : 8'bzzzzzzzz;

   always @ (posedge CLK, posedge AR) begin
      if (AR) sp <= 8'b00000000;
      else sp <= next_sp;
   end

   always @ (SPI, SPD, sp) begin
      if (SPI) next_sp = sp + 1;
      else if (SPD) next_sp = sp - 1;
      else next_sp = sp;
   end
endmodule // sp

