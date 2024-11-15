module alu_tb;

    
    reg [3:0] opcode;
    reg [7:0] operandA;
    reg [7:0] operandB;

  
    wire [7:0] result;


    alu uut (
        .opcode(opcode),
        .operandA(operandA),
        .operandB(operandB),
        .result(result)
    );


    initial begin
       
        opcode = 4'b0000;
        operandA = 8'h00;
        operandB = 8'h00;
        #10;
        
        // Test 2: ADD
        opcode = 4'b0001;
        operandA = 8'h05;
        operandB = 8'h03;
        #10;
    
        // Test 3: SUB
        opcode = 4'b0010;
        operandA = 8'h05;
        operandB = 8'h03;
        #10;
      
        // Test 4: AND
        opcode = 4'b0011;
        operandA = 8'h0F;
        operandB = 8'hF0;
        #10;

        // Test 5: OR
        opcode = 4'b0100;
        operandA = 8'h0F;
        operandB = 8'hF0;
        #10;

        // Test 6: XOR
        opcode = 4'b0101;
        operandA = 8'h0F;
        operandB = 8'hF0;
        #10;

        // Test 7: INC
        opcode = 4'b0110;
        operandA = 8'h05;
        #10;

        // Test 8: DEC
        opcode = 4'b0111;
        operandA = 8'h05;
        #10;

        // Test 9: NOT
        opcode = 4'b1000;
        operandA = 8'hAA;
        #10;

        // Test 10: NEG
        opcode = 4'b1001;
        operandA = 8'h05;
        #10;

        // Test 11: SHR (Shift Right)
        opcode = 4'b1010;
        operandA = 8'hAA;
        #10;

        // Test 12: SHL (Shift Left)
        opcode = 4'b1011;
        operandA = 8'hAA;
        #10;

        // Test 13: ROR (Rotate Right)
        opcode = 4'b1100;
        operandA = 8'hAA;
        #10;

        // Test 14: ROL (Rotate Left)
        opcode = 4'b1101;
        operandA = 8'hAA;
        #10;
    end

endmodule
