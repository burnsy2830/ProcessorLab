module regMem(
    input wire clk,
    input wire write,
    input wire reset,
    input wire [2:0] opA,
    input wire [3:0] dmaddr,
    input wire [2:0] dest,
    input wire [3:0] opcode,
    input wire [2:0] opB,
    input wire [2:0] wR,
    input wire [7:0] dataIn,
    output wire [7:0] operand_a,
    output wire [7:0] operand_b,
    output wire [2:0] adderAO,
    output wire [2:0] adderBO,
    output wire [3:0] dmaddrO,
    output wire [2:0] destO,
    output wire [3:0] opcodeO
);

    reg [7:0] registers [7:0];
    reg [2:0] adderAInt;
    reg [2:0] adderBInt;
    reg [3:0] dmaddrInt; 
    reg [2:0] destInt;
    reg [3:0] opcodeInst;
    reg [7:0] operandAInt;
    reg [7:0] operandBInt;

    assign adderAO = adderAInt;
    assign adderBO = adderBInt;
    assign dmaddrO = dmaddrInt;
    assign destO = destInt;
    assign opcodeO = opcodeInst;
    assign operand_a = operandAInt;
    assign operand_b = operandBInt;

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
            $display("Time: %0t - Register %0d written with value: 0x%0h", $time, wR, dataIn);
        end
    end

    always @(posedge clk) begin
        operandAInt <= registers[opA];
        operandBInt <= registers[opB];
        adderAInt <= opA;
        adderBInt <= opB;
        dmaddrInt <= dmaddr;
        destInt <= dest;
        opcodeInst <= opcode;
    end

endmodule
