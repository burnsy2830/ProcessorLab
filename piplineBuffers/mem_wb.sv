module mem_wb(
    input wire clk,
    input wire rst,

    input wire [7:0] result,
    input wire [2:0] opAAdr,
    input wire regWE,
    input wire [2:0] dest_reg,        

    output reg [7:0] prev_result,
    output reg [2:0] prev_opAAdr,
    output reg prev_regWE,
    output reg [2:0] prev_dest_reg    
);

    reg [7:0] curr_result;
    reg [2:0] curr_opAAdr;
    reg curr_regWE;
    reg [2:0] curr_dest_reg;          

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            prev_result <= 8'b0;
            prev_opAAdr <= 3'b0;
            prev_regWE <= 1'b0;
            prev_dest_reg <= 3'b0;    

            curr_result <= 8'b0;
            curr_opAAdr <= 3'b0;
            curr_regWE <= 1'b0;
            curr_dest_reg <= 3'b0;   
        end else begin
            prev_result <= curr_result;
            prev_opAAdr <= curr_opAAdr;
            prev_regWE <= curr_regWE;
            prev_dest_reg <= curr_dest_reg;  

            curr_result <= result;
            curr_opAAdr <= opAAdr;
            curr_regWE <= regWE;
            curr_dest_reg <= dest_reg;     
        end
    end
endmodule
