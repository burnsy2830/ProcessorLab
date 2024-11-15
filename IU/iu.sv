module iu (
    input wire clk,                   
    input wire reset,
    output wire [4:0]pcOut, // for the report, it is required to display PC out.                
    output wire [12:0] ir_out          
);

// This module represents the F stage in the F-D-X-M-W pipeline cycle.

    wire [4:0] pc_address;             // Program counter address
   
    wire [12:0] fetched_instruction;   // Instruction fetched from instMem

    // Instantiate PC module
    pc PC (
        .clk(clk),
        .rst(reset),
        .pc(pc_address)                
    );

    instMem IM (
        .clk(clk),
        .address(pc_address),          // Only use the program counter for addressing
        .instruction(fetched_instruction)  // Fetched instruction output
    );

    assign ir_out = fetched_instruction;  // Output the fetched instruction
    assign pcOut = pc_address;

endmodule
