module alu(
    input wire [3:0] opcode,           // 3-bit control signal for operation selection
    input wire [7:0] operandA,        // 16-bit first operand
    input wire [7:0] operandB,        // 16-bit second operand
    output reg [7:0] result          // 16-bit result of the ALU operation
);


 always @(*) begin
    case(opcode)
        4'b0000: result = 8'b0; // NOPp

        4'b0001: begin
            result = operandA + operandB;
        end  
         4'b0010: begin // SUB
            result = operandA - operandB;
        end

        4'b0011: result = operandA & operandB; // AND

        4'b0100: result = operandA | operandB; // OR 

        4'b0101: result = operandA ^ operandB; // XOR

        4'b0110: result = operandA + 1; // INC

        4'b0111: result = operandA - 1; // DEC

        4'b1000: result = ~operandA; // NOT

        4'b1001: result = -operandA; // NEG (Two's complement)

        4'b1010: begin
            result = operandA >> 1; // SHR (Shift Right)
           
        end

        4'b1011: begin // SHL (Shift Left)
            result = operandA << 1;
        end

        4'b1100: begin // ROR (Rotate Right)
            result = {operandA[0], operandA[7:1]};
        end

        4'b1101: begin // ROL (Rotate Left)
            result = {operandA[6:0], operandA[7]};
        end
            
        4'b1110: result = operandA;

        4'b1111: result = operandA; 
            
        default: result = 8'b0; 
    endcase
   
 end 

endmodule

    