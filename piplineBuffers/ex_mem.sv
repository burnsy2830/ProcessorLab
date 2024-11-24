module ex_mem(
    input wire clk,
    input wire rst,
    input wire [3:0] storeDataAdrOut,
    input wire [7:0] result,
    input wire [2:0] opAAdr,
    input wire [3:0] opcode,
    input wire regWE,
    input wire data_memory_write_enable,
    input wire [7:0] load_result,
    input wire [2:0] dest_reg,         // New input: Destination register

    output reg [3:0] prev_storeDataAdrOut,
    output reg [7:0] prev_result,
    output reg [2:0] prev_opAAdr,
    output reg [3:0] prev_opcode,
    output reg prev_regWE,
    output reg prev_data_memory_write_enable,
    output reg [7:0] prev_load_result,
    output reg [2:0] prev_dest_reg     // New output: Previous destination register
);

    reg [3:0] curr_storeDataAdrOut;
    reg [7:0] curr_result;
    reg [2:0] curr_opAAdr;
    reg [3:0] curr_opcode;
    reg curr_regWE;
    reg curr_data_memory_write_enable;
    reg [7:0] curr_load_result;
    reg [2:0] curr_dest_reg;          // Internal register for destination register

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            prev_storeDataAdrOut <= 4'b0;
            prev_result <= 8'b0;
            prev_opAAdr <= 3'b0;
            prev_opcode <= 4'b0;
            prev_regWE <= 1'b0;
            prev_data_memory_write_enable <= 1'b0;
            prev_load_result <= 8'b0;
            prev_dest_reg <= 3'b0;

            curr_storeDataAdrOut <= 4'b0;
            curr_result <= 8'b0;
            curr_opAAdr <= 3'b0;
            curr_opcode <= 4'b0;
            curr_regWE <= 1'b0;
            curr_data_memory_write_enable <= 1'b0;
            curr_load_result <= 8'b0;
            curr_dest_reg <= 3'b0;
        end else begin
            prev_storeDataAdrOut <= curr_storeDataAdrOut;
            prev_result <= curr_result;
            prev_opAAdr <= curr_opAAdr;
            prev_opcode <= curr_opcode;
            prev_regWE <= curr_regWE;
            prev_data_memory_write_enable <= curr_data_memory_write_enable;
            prev_load_result <= curr_load_result;
            prev_dest_reg <= curr_dest_reg;

            curr_storeDataAdrOut <= storeDataAdrOut;
            curr_result <= result;
            curr_opAAdr <= opAAdr;
            curr_opcode <= opcode;
            curr_regWE <= regWE;
            curr_data_memory_write_enable <= data_memory_write_enable;
            curr_load_result <= load_result;
            curr_dest_reg <= dest_reg;  // Update current destination register
        end
    end
endmodule
