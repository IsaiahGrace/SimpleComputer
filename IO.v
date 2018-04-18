module IO (IOR, IOW, DATA, INPUT, OUTPUT);
   input wire IOR;
   input wire IOW;
   inout wire [15:0]  DATA;
   input wire [15:0]  INPUT;
   output wire [15:0] OUTPUT;

   assign DATA   = IOR ? INPUT : 16'bzzzz zzzz zzzz zzzz;
   assign OUTPUt = IOW ? DATA  : 16'bzzzz zzzz zzzz zzzz;
endmodule // IO