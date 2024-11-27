module iu (
    input wire clk,
    input wire reset,
    input wire ce,
    output wire [4:0] pcOut,
    output wire [12:0] ir_out
);

    reg [4:0] pc_address_reg;
    reg [12:0] fetched_instruction_reg;

    wire [4:0] pc_address;
    wire [12:0] fetched_instruction;

    assign pcOut = pc_address_reg;
    assign ir_out = fetched_instruction_reg;

    pc PC (
        .clk(clk),
        .ce(ce),
        .rst(reset),
        .pc(pc_address)
    );

    instMem IM (
        .clk(clk),
        .address(pc_address),
        .instruction(fetched_instruction)
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_address_reg <= 5'b0;
            fetched_instruction_reg <= 13'b0;
        end else begin
            pc_address_reg <= pc_address;
            fetched_instruction_reg <= fetched_instruction;
        end
    end
endmodule
