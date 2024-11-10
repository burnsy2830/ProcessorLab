module instMem (
    input wire clk,                   
    input wire [4:0] address,          // Address for fetching instructions
    output wire [12:0] instruction     // Fetched instruction 
);

    // Define memory with 32 13-bit registers
    reg [12:0] memory [31:0];

  
    initial begin
        integer i;
        for (i = 0; i < 32; i = i + 1) begin
            memory[i] = 13'b0;  
        end
        
        
        memory[0] = 13'b1111111111111;  
        memory[1] = 13'b0010011001010;  
        memory[2] = 13'b0000000000011; 
        
    end

    assign instruction = memory[address];

endmodule
