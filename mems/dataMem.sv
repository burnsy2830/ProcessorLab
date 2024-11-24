module data_memory (
    input wire clk,
    input wire reset,
    input wire write_enable,              // Write enable signal (from EU)
    input wire regWE,
    input wire [2:0] dest_reg,
    input wire [3:0] opcode,
    input wire [3:0] address,             // Memory address for read/write
    input wire [2:0] opAaddr,
    input wire [7:0] write_result,        // Data to write to memory
    input wire [7:0] write_data,          // Data to write to memory
    output wire [2:0] opAaddrOut,
    output wire regWEO,
    output reg [7:0] read_data,            // Data read from memory
    output wire [2:0] destReg
);

    reg [7:0] memory [0:255];
    assign opAaddrOut = opAaddr;
    assign destReg = dest_reg;
    assign regWEO = regWE;

    always @(*) begin
        if (opcode == 4'b1110) begin
            read_data = memory[address];
        end else begin
            read_data = write_result;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            integer i;
            for (i = 0; i < 256; i = i + 1) begin
                memory[i] <= 8'b0;
            end
            // These memory values are the same as given in the lab data memory.
            memory[00] = 8'h11;
            memory[01] = 8'h22;
            memory[02] = 8'h44;
            memory[03] = 8'h66;
            memory[04] = 8'h88;
            memory[05] = 8'haa;
            memory[06] = 8'hcc;
            memory[07] = 8'hff;
            memory[08] = 8'h00;
            memory[09] = 8'h00;
            memory[10] = 8'h00;
            memory[11] = 8'h00;
            memory[12] = 8'h00;
            memory[13] = 8'h00;
            memory[14] = 8'h00;
            memory[15] = 8'h00;
        end else if (write_enable) begin
            memory[address] <= write_data;
        end
    end
endmodule
