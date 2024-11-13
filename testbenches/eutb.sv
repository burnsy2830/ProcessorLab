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

        opcode = 4'b1110;            // LOAD operation
        data_memory_data = 8'hAB;   
        #10;



        storeDataAdr = 4'b1010;
        opcode = 4'b1111;            // STORE operation
        #10;
        
        reset = 1;                   
        #10;
        $stop;                       
    end 
endmodule
