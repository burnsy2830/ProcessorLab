module id_ex(
    input wire clk,               // Clock signal
    input wire rst,               // Reset signal
    input wire [3:0] opcode,      // 4-bit opcode input
    input wire [2:0] operanda,    // 3-bit operand a input
    input wire [2:0] operandb,    // 3-bit operand a input
    input wire [3:0] dmaddr,      // 4-bit data memory address input
    input wire [2:0] dest,        // 3-bit destination input
    input wire [7:0] opAdata,     // 8-bit operand A data input
    input wire [7:0] opBdata,     // 8-bit operand B data input

    output reg [3:0] prev_opcode, // 4-bit output of previous opcode
    output reg [2:0] prev_operanda, // 3-bit output of previous operanda
    output reg [2:0] prev_operandb, // 3-bit output of previous operandb
    output reg [3:0] prev_dmaddr,   // 4-bit output of previous dmaddr
    output reg [2:0] prev_dest,     // 3-bit output of previous dest
    output reg [7:0] prev_opAdata,  // 8-bit output of previous operand A data
    output reg [7:0] prev_opBdata   // 8-bit output of previous operand B data
);

    reg [3:0] curr_opcode;
    reg [2:0] curr_operanda;
    reg [2:0] curr_operandb;
    reg [3:0] curr_dmaddr;
    reg [2:0] curr_dest;
    reg [7:0] curr_opAdata;
    reg [7:0] curr_opBdata;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            prev_opcode <= 4'b0;
            prev_operanda <= 3'b0;
            prev_operandb <= 3'b0;
            prev_dmaddr <= 4'b0;
            prev_dest <= 3'b0;
            prev_opAdata <= 8'b0;
            prev_opBdata <= 8'b0;
            curr_opcode <= 4'b0;
            curr_operanda <= 3'b0;
            curr_operandb <= 3'b0;
            curr_dmaddr <= 4'b0;
            curr_dest <= 3'b0;
            curr_opAdata <= 8'b0;
            curr_opBdata <= 8'b0;
        end else begin
            prev_opcode <= curr_opcode;
            prev_operanda <= curr_operanda;
            prev_operandb <= curr_operandb;
            prev_dmaddr <= curr_dmaddr;
            prev_dest <= curr_dest;
            prev_opAdata <= curr_opAdata;
            prev_opBdata <= curr_opBdata;

            curr_opcode <= opcode;
            curr_operanda <= operanda;
            curr_operandb <= operandb;
            curr_dmaddr <= dmaddr;
            curr_dest <= dest;
            curr_opAdata <= opAdata;
            curr_opBdata <= opBdata;
        end
    end
endmodule
