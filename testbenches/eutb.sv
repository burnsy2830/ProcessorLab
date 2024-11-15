module eutb;

    // Inputs to EU
    reg clk;
    reg reset;
    reg [2:0] opAAdr;                
    reg [2:0] opBAdr;               
    reg [3:0] opcode;                 
    reg [2:0] dest_reg;            
    reg [3:0] storeDataAdr;         
    reg [7:0] operandA;               
    reg [7:0] operandB;             
    reg [7:0] data_memory_data;            

    // Outputs from EU
    wire [2:0] opAsendAdr;            
    wire [2:0] opBsendAdr;           
    wire [3:0] storeDataAdrOut;     
    wire [7:0] result;              
    wire write_enable;                
    wire [7:0] store_data;                
    wire data_memory_write_enable;   

    // Instantiate the eu module
    eu dut (
        .clk(clk),
        .reset(reset),
        .opAAdr(opAAdr),
        .opBAder(opBAdr),           
        .opcode(opcode),
        .dest_reg(dest_reg),         
        .storeDataAdr(storeDataAdr), 
        .opAsendAdr(opAsendAdr),
        .opBsendAdr(opBsendAdr),
        .storeDataAdrOut(storeDataAdrOut),
        .operandA(operandA),
        .operandB(operandB),
        .data_memory_data(data_memory_data),  
        .result(result),
        .write_enable(write_enable),
        .store_data(store_data),     
        .data_memory_write_enable(data_memory_write_enable)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        reset = 1;
        #10;
        reset = 0;
        opAAdr = 3'b000;
        opBAdr = 3'b001;
        opcode = 4'b0001;
        dest_reg = 3'b010;
        storeDataAdr = 4'b0010;       
        operandA = 8'h01;
        operandB = 8'h02;
        data_memory_data = 8'h00;  
        #10;

        $display("reset = %b, opcode = %h, operandA = %h, operandB = %h, result = %h", reset, opcode, operandA, operandB, result);

        opcode = 4'b1110;            // LOAD operation
        data_memory_data = 8'hAB; 

        $display("reset = %b, opcode = %h, operandA = %h, operandB = %h, result = %h", reset, opcode, operandA, operandB, result);  
        #10;



        storeDataAdr = 4'b1010;
        opcode = 4'b1111;            // STORE operation
        #10;
        $display("reset = %b, opcode = %h, operandA = %h, operandB = %h, result = %h", reset, opcode, operandA, operandB, result);
        
                 
        #10;
        

        //Test 3: SUB
        opcode = 4'b0010;
        operandA = 8'h05;
        operandB = 8'h03;
        #10;
        $display("reset = %b, opcode = %h, operandA = %h, operandB = %h, result = %h", reset, opcode, operandA, operandB, result);
      
        // Test 4: AND
        opcode = 4'b0011;
        operandA = 8'h0F;
        operandB = 8'hF0;
        #10;
        $display("reset = %b, opcode = %h, operandA = %h, operandB = %h, result = %h", reset, opcode, operandA, operandB, result);

        // Test 5: OR
        opcode = 4'b0100;
        operandA = 8'h0F;
        operandB = 8'hF0;
        #10;
        $display("reset = %b, opcode = %h, operandA = %h, operandB = %h, result = %h", reset, opcode, operandA, operandB, result);

        // Test 6: XOR
        opcode = 4'b0101;
        operandA = 8'h0F;
        operandB = 8'hF0;
        #10;
        $display("reset = %b, opcode = %h, operandA = %h, operandB = %h, result = %h", reset, opcode, operandA, operandB, result);

        // Test 7: INC
        opcode = 4'b0110;
        operandA = 8'h05;
        #10;
        $display("reset = %b, opcode = %h, operandA = %h, operandB = %h, result = %h", reset, opcode, operandA, operandB, result);

        // Test 8: DEC
        opcode = 4'b0111;
        operandA = 8'h05;
        #10;
        $display("reset = %b, opcode = %h, operandA = %h, operandB = %h, result = %h", reset, opcode, operandA, operandB, result);

        // Test 9: NOT
        opcode = 4'b1000;
        operandA = 8'hAA;
        #10;
        $display("reset = %b, opcode = %h, operandA = %h, operandB = %h, result = %h", reset, opcode, operandA, operandB, result);

        // Test 10: NEG
        opcode = 4'b1001;
        operandA = 8'h05;
        #10;
        $display("reset = %b, opcode = %h, operandA = %h, operandB = %h, result = %h", reset, opcode, operandA, operandB, result);

        // Test 11: SHR (Shift Right)
        opcode = 4'b1010;
        operandA = 8'hAA;
        #10;
        $display("reset = %b, opcode = %h, operandA = %h, operandB = %h, result = %h", reset, opcode, operandA, operandB, result);

        // Test 12: SHL (Shift Left)
        opcode = 4'b1011;
        operandA = 8'hAA;
        #10;
        $display("reset = %b, opcode = %h, operandA = %h, operandB = %h, result = %h", reset, opcode, operandA, operandB, result);

        // Test 13: ROR (Rotate Right)
        opcode = 4'b1100;
        operandA = 8'hAA;
        #10;
        $display("reset = %b, opcode = %h, operandA = %h, operandB = %h, result = %h", reset, opcode, operandA, operandB, result);

        // Test 14: ROL (Rotate Left)
        opcode = 4'b1101;
        operandA = 8'hAA;
        #10;
        $display("reset = %b, opcode = %h, operandA = %h, operandB = %h, result = %h", reset, opcode, operandA, operandB, result);
        $stop;                       
    end 
endmodule
