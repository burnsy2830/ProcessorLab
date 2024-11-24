module eu (
    input wire clk,
    input wire reset,
    input wire [2:0] opAAdr,                 // Address for operand A
    input wire [2:0] opBAdr,                 // Address for operand B
    input wire [3:0] opcode,                 // Operation code from CU
    input wire [2:0] dest_reg,               // Destination register address from CU
    input wire [3:0] storeDataAdr,           // 4-bit store address
    input wire [7:0] operandA,               // Data for operand A from Register Memory
    input wire [7:0] operandB,               // Data for operand B from Register Memory
    
    output wire [3:0] storeDataAdrOut,       // Destination register to be used in Register Memory
    output reg [7:0] result,                 // Result to be written back to Register Memory
    output reg write_enable,                 // Write enable for Register Memory
    output reg [7:0] store_data,             // Data to be stored in Data Memory
    output wire [3:0] opcodeO,
    output wire [2:0] outAaddr,
    output wire [2:0] destReg,               // Destination register address
    output reg data_memory_write_enable      // Write enable for Data Memory
);

    // Signal for ALU result
    wire [7:0] alu_result;
    assign outAaddr = opAAdr;
    assign opcodeO = opcode;
    assign storeDataAdrOut = (opcode == 4'b1111) ? storeDataAdr : 4'b0000;
    assign destReg = (opcode == 4'b1111 || opcode == 4'b1110) ? opAAdr : dest_reg;

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
                4'b1110: begin  // Load operation
                    write_enable <= 1;                    // Write back to reg memory
                    data_memory_write_enable <= 0;        // Don't write to data memory
                    store_data <= 8'b0; 
                end

                4'b1111: begin  // Store operation
                    write_enable <= 0;                    // No writing for reg memory
                    data_memory_write_enable <= 1;        // Write to data memory
                    store_data <= operandA;               // Store opA 
                end

                default: begin  // ALU operation or any other operation
                    write_enable <= 1;                    // Write back to reg memory
                    data_memory_write_enable <= 0;        // No writing to data memory
                    result <= alu_result;                 // ALU result to reg mem
                end
            endcase
        end
    end
endmodule
