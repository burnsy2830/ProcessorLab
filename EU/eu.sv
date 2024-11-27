module eu (
    input wire clk,
    input wire reset,
    input wire [2:0] opAAdr,
    input wire [2:0] opBAdr,
    input wire [3:0] opcode,
    input wire [2:0] dest_reg,
    input wire [3:0] storeDataAdr,
    input wire [7:0] operandA,
    input wire [7:0] operandB,
    
    output wire [3:0] storeDataAdrOut,
    output wire [7:0] result,
    output reg write_enable,
    output reg [7:0] store_data,
    output wire [3:0] opcodeO,
    output wire [2:0] outAaddr,
    output wire [2:0] destReg,
    output reg data_memory_write_enable
);

    reg [2:0] opAAdrI;
    reg [2:0] opBAdrI;
    reg [3:0] opcodeI;
    reg [2:0] dest_regI;
    reg [3:0] storeDataAdrI;
    reg [7:0] resultI;
    wire [7:0] alu_result;

    assign outAaddr = opAAdrI;
    assign opcodeO = opcodeI;
    assign storeDataAdrOut = storeDataAdrI;
    assign destReg = dest_regI;
    assign result = resultI;

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
            //resultI <= 8'b0;
            store_data <= 8'b0;
            opAAdrI <= 3'b0;
            opBAdrI <= 3'b0;
            opcodeI <= 4'b0;
            dest_regI <= 3'b0;
            storeDataAdrI <= 4'b0;
        end else begin
            opAAdrI <= opAAdr;
            opBAdrI <= opBAdr;
            opcodeI <= opcode;
            dest_regI <= dest_reg;
            

            case (opcode)
                4'b1110: begin
                    write_enable <= 1;
                    data_memory_write_enable <= 0;
                    storeDataAdrI <= storeDataAdr;
                end
                4'b1111: begin
                    write_enable <= 0;
                    data_memory_write_enable <= 1;
                    store_data <= operandA;
                    storeDataAdrI <= 4'bz;
                end
                4'b0000:begin
                    write_enable <= 1'bz;
                    data_memory_write_enable <= 1'bz;
                    resultI <= 8'bz;
                end 
                default: begin
                    write_enable <= 1;
                    data_memory_write_enable <= 0;
                    resultI <= alu_result;
                end
            endcase
        end
    end
endmodule
