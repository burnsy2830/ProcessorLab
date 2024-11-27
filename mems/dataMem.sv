module data_memory (
    input wire clk,
    input wire reset,
    input wire write_enable,
    input wire regWE,
    input wire [2:0] dest_reg,
    input wire [3:0] opcode,
    input wire [3:0] address,
    input wire [2:0] opAaddr,
    input wire [7:0] write_result,
    input wire [7:0] write_data,
    output wire [2:0] opAaddrOut,
    output wire regWEO,
    output reg [7:0] read_data,
    output wire [2:0] destReg
);

    reg [7:0] memory [0:255];
    reg [2:0] opAaddrReg;
    reg [2:0] destRegInt;
    reg regWEInt;

    assign opAaddrOut = opAaddrReg;
    assign destReg = destRegInt;
    assign regWEO = regWEInt;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            integer i;
            for (i = 0; i < 256; i = i + 1) begin
                memory[i] = 8'b0;
            end
            memory[00] = 8'h11;
            memory[01] = 8'h22;
            memory[02] = 8'h44;
            memory[03] = 8'h00;
            memory[04] = 8'h88;
            memory[05] = 8'haa;
            memory[06] = 8'hcc;
            memory[07] = 8'hff;
            read_data = 8'bz;
            opAaddrReg = 3'b0;
            destRegInt = 3'b0;
            regWEInt = 1'b0;
        end else begin
            opAaddrReg <= opAaddr;
            destRegInt <= dest_reg;
            regWEInt <= regWE;

            if (write_enable) begin
                memory[address] <= write_data;
            end

            if (opcode == 4'b1110 && !write_enable) begin
                read_data <= memory[address];
                $display("Opcode triggered: Read from address %0d, data = %h", address, memory[address]);
            end else begin
                read_data <= write_result;
            end
        end
    end
endmodule
