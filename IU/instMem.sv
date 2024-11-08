module instMem (
    input wire clk,                   
    input wire [4:0] address,          // Address for reading or writing
    input wire [12:0] data_in,         // Data to write to memory
    input wire write_enable,           // Write enable signal -> Using this so i can manualy write in instructions for the sake of testing!! 
    output wire [12:0] instruction     // Fetched instruction 
);

   
    reg [12:0] memory [31:0];

    initial begin
        integer i;
        for (i = 0; i < 32; i = i + 1) begin
            memory[i] = 16'b0; 
        end
    end


    always @(posedge clk) begin
        if (write_enable) begin
            memory[address] <= data_in;   
        end
    end

   
    assign instruction = memory[address];

endmodule
