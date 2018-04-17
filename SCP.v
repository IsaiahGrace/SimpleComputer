module SCP (CLK, AR, INPUT, OUTPUT, MEM_ADDR, MEM_DATA, MEM_EDIT);
   input wire CLK, AR;        // Clock and Reset
   input wire [7:0] INPUT;    // INPUT for IO module
   output wire [7:0] OUTPUT;  // OUTPUT for IO module
   input wire [7:0] MEM_ADDR; // Adress of memory to edit
   input wire [7:0] MEM_DATA; // Data to assign to memory
   input wire 	    MEM_EDIT; // Asyncronous memory set

   // Controll signals
   // Memory
   wire MSL; // M select/enable
   wire MOE; // M output on Data bus
   wire MWE; // M read from Data bus
      
   // Instruction Register
   wire IRL; // IR load from Data bus
   wire IRA; // IR output on Address bus
   wire [7:0] IOP; // IR OPCODE always connected to IDMS

   // Program Counter
   wire PCC; // PC count enable (PC <= PC + 2)
   wire POA; // PC output on Address bus
   wire PLA; // PC load from Address bus
   wire POD; // PC output on Data bus
   wire PLD; // PC load from Data bus

   // Stack Pointer
   wire SPI; // SP Increment
   wire SPD; // SP Decrement
   wire SPA; // SP output on Address bus
   
   // ALU
   wire AOE;       // ALU output on Data bus
   wire ALE;       // ALU enable/retain state
   wire [1:0] ALS; // ALU state control/function select

   // IO
   wire IOR; // IO read from INPUT to Data Bus
   wire IOW; // IO output to OUTPUT from Data Bus
   
   // Buses
   wire [15:0] DATA; // Data bus is a word (opcode and data/address)
   wire [8:0]  ADDR; // 8-bit address give 256 bytes of memory
   

   // Modules
   IDMS idms (CLK, AR, 
	      MSL, MOE, MWE,
	      IRL, IRA, IOP,
	      PCC, POA, PLA, POD, PLD, 
	      SPI, SPD, SPA, 
	      AOE, ALE, ALS, 
	      IOR, IOW);
   
   MEM mem (CLK, MSL, MOE, MWE, DATA, ADDR, MEM_ADDR, MEM_DATA, MEM_EDIT);
   IR  ir  (CLK, AR, IRL, IRA, IOP, DATA, ADDR);
   PC  pc  (CLK, AR, PCC, POA, PLA, POD, PLD, DATA, ADDR);
   SP  sp  (CLK, AR, SPI, SPD, SPA, ADDR);
   ALU alu (CLK, AR, AOE, ALE, ALS, DATA);
   IO  io  (CLK, AR, IOR, IOW, DATA, INPUT, OUTPUT);

endmodule // SCP
