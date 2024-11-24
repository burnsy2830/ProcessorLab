module regMem(
    input wire clk,                   // Clock signal for synchronous write
    input wire write,                 // Write enable signal
    input wire reset,                 // Reset signal to initialize all registers
    input wire [2:0] opA,             // 3-bit address for reading operand A
    input wire [3:0] dmaddr,
    input wire [2:0] dest,
    input wire [3:0] opcode,
    input wire [2:0] opB,             // 3-bit address for reading operand B
    input wire [2:0] wR,              // 3-bit address for writing data
    input wire [7:0] dataIn,          // Data to be written to the register file
    output reg [7:0] operand_a,       // Data output for operand A
    output reg [7:0] operand_b,        // Data output for operand B
    output wire [2:0] adderAO,
    output wire [2:0] adderBO,
    output wire [3:0] dmaddrO,
    output wire [2:0] destO,
    output wire [3:0] opcodeO
);

    // 8 x 8-bit register memory`
    reg [7:0] registers [7:0];        


    assign adderAO = opA;
    assign adderBO = opB;
    assign dmaddrO = dmaddr;
    assign destO = dest;
    assign opcodeO = opcode;

  
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            registers[0] <= 8'h00;
            registers[1] <= 8'h22;
            registers[2] <= 8'h44;
            registers[3] <= 8'h66;
            registers[4] <= 8'h88;
            registers[5] <= 8'haa;
            registers[6] <= 8'hcc;
            registers[7] <= 8'hff;
        end else if (write) begin
            registers[wR] <= dataIn;
        end
    end

    always @(*) begin
        operand_a = registers[opA];
        operand_b = registers[opB];
    end
    
endmodule
