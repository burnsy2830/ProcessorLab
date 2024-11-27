module if_id(
    input wire clk,               // Clock signal
    input wire rst,               // Reset signal
    input wire [3:0] opcode,      // 4-bit opcode input
    input wire [2:0] operanda,    // 3-bit operand a input
    input wire [2:0] operandb,    // 3-bit operand b input
    input wire [3:0] dmaddr,      // 4-bit data memory address input
    input wire [2:0] dest,        // 3-bit destination input
    output reg [3:0] prev_opcode, // 4-bit output of previous opcode
    output reg [2:0] prev_operanda, // 3-bit output of previous operanda
    output reg [2:0] prev_operandb, // 3-bit output of previous operandb
    output reg [3:0] prev_dmaddr,   // 4-bit output of previous dmaddr
    output reg [2:0] prev_dest      // 3-bit output of previous dest
);

    reg [3:0] curr_opcode;
    reg [2:0] curr_operanda;
    reg [2:0] curr_operandb;
    reg [3:0] curr_dmaddr;
    reg [2:0] curr_dest;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
     
            prev_opcode <= 4'b0;
            prev_operanda <= 3'b0;
            prev_operandb <= 3'b0;
            prev_dmaddr <= 4'b0;
            prev_dest <= 3'b0;
            curr_opcode <= 4'b0;
            curr_operanda <= 3'b0;
            curr_operandb <= 3'b0;
            curr_dmaddr <= 4'b0;
            curr_dest <= 3'b0;
        end else begin
            
            prev_opcode <= curr_opcode;
            prev_operanda <= curr_operanda;
            prev_operandb <= curr_operandb;
            prev_dmaddr <= curr_dmaddr;
            prev_dest <= curr_dest;

           
            curr_opcode <= opcode;
            curr_operanda <= operanda;
            curr_operandb <= operandb;
            curr_dmaddr <= dmaddr;
            curr_dest <= dest;
        end
    end
endmodule
