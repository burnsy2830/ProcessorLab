module mProcessor(
    input wire clk,
    input wire reset,
    input wire write_enable,              // For testing purposes
    input wire [4:0] write_address,       // Address for instruction write
    input wire [12:0] write_data          // Data for instruction write
);

    wire [4:0] pc_address;
    wire [12:0] instruction;
    wire [3:0] opcode;
    wire [3:0] addr;
    wire [2:0] operand_a;
    wire [2:0] operand_b;
    wire [2:0] dest;
    wire [7:0] operandA_data;
    wire [7:0] operandB_data;
    wire [7:0] alu_result;
    wire zero_flag;
    wire carry_flag


    // Instantiate Instruction Unit (IU)
    iu IU (
        .clk(clk),
        .reset(reset),
        .write_enable(write_enable),
        .write_address(write_address),
        .write_data(write_data),
        .ir_out(instruction)               // Output the instruction
    );



    cu CU (
        .instIn(instruction),              // Connect instruction output from IU
        .opcode(opcode),
        .adrr(addr),
        .operanda(operand_a),
        .operandb(operand_b),
        .dest(dest)
    );



    regMem REG_MEM (
        .clk(clk),
        .write(1'b0),                      // Write enable logic can be added here
        .reset(reset),
        .opA(operand_a),                   // Connect CU outputs for operand addresses
        .opB(operand_b),
        .wR(dest),                         // Connect CU destination register
        .dataIn(alu_result),               // ALU result to write back to register
        .operand_a(operandA_data),         // Outputs for ALU operands
        .operand_b(operandB_data)
    );


endmodule