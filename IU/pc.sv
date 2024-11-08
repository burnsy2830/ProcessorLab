module pc (
    input wire clk,           // Clock signal
    input wire rst,           // Reset signal
    output reg [4:0] pc       // 5-bit Program Counter output
);

  
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 5'b00000;   
        end else begin
            pc <= pc + 1;     
        end
    end

endmodule
