module pc (
    input wire clk,           // Clock signal
    input wire rst,           // Reset signal (active high)
    input wire ce,            // Clock enable signal
    output reg [4:0] pc       // 5-bit Program Counter output
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 5'bz;       // High-impedance during reset
        end else if (ce) begin
            pc <= (pc === 5'bz) ? 5'b00000 : pc + 1; 
        end else begin
            pc <= pc;         
        end
    end

endmodule