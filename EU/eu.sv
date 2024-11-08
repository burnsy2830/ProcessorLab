module eu (
    input wire clk,
    input wire reset,
    input wire [2:0] opAAdr,                 // Address for operand A
    input wire [2:0] opBAder,                // Address for operand B
    input wire [3:0] opcode,                 // Operation code from CU
    input wire [2:0] dest_reg,               // Destination register address from CU
    output wire [2:0] opAsendAdr,            // Output address for operand A
    output wire [2:0] opBsendAdr,            // Output address for operand B
    output wire [2:0] destReg,               // Destination register to be used in Register Memory
    input wire [7:0] operandA,               // Data for operand A from Register Memory
    input wire [7:0] operandB,               // Data for operand B from Register Memory
    input wire [7:0] data_memory_data,       // Data fetched from Data Memory (for load operations)
    output reg [7:0] result,                 // Result to be written back to Register Memory
    output reg write_enable,                 // Write enable for Register Memory
    output reg [7:0] store_data,             // Data to be stored in Data Memory
    output reg data_memory_write_enable      // Write enable for Data Memory
);

    // Signal for ALU result
    wire [7:0] alu_result;


    assign opAsendAdr = opAAdr;
    assign opBsendAdr = opBAder;
    assign destReg = dest_reg;

    // ALU instance
    alu ALU (
        .opcode(opcode),
        .operandA(operandA),
        .operandB(operandB),
        .result(alu_result)
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            write_enable <= 0;
            data_memory_write_enable <= 0;
            result <= 8'b0;
            store_data <= 8'b0;
        end else begin
            case (opcode)
                4'b0100: begin  // Load operation
                    write_enable <= 1;                    // write back to reg memory 
                    data_memory_write_enable <= 0;        // dont write to data memory 
                    result <= data_memory_data;           // Load value from data memory 
                end

                4'b0101: begin  // Store operation
                    write_enable <= 0;                    // no writing for reg memory 
                    data_memory_write_enable <= 1;        // write to data memory 
                    store_data <= operandA;               // store opA 
                end

                default: begin  // ALU operation or any other operation
                    write_enable <= 1;                    // write back to reg memory 
                    data_memory_write_enable <= 0;        // no writing to data memory 
                    result <= alu_result;                 // ALU result to reg mem 
                end
            endcase
        end
    end
endmodule
