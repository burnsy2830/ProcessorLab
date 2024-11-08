module data_memory (
    input wire clk,
    input wire reset,
    input wire write_enable,              // Write enable signal (from EU)
    input wire [7:0] address,             // Memory address for read/write
    input wire [7:0] write_data,          // Data to write to memory
    output reg [7:0] read_data            // Data read from memory
);

    
    reg [7:0] memory [0:255];

    
    always @(*) begin
        read_data = memory[address];
    end

   
    always @(posedge clk) begin
        if (reset) begin
            integer i;
            for (i = 0; i < 256; i = i + 1) begin
                memory[i] <= 8'b0;
            end
        end else if (write_enable) begin
            memory[address] <= write_data;
        end
    end
endmodule
