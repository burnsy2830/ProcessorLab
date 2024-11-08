module eutb;

    //Inputs to EU. 
    reg clk;
    reg reset;
    reg [2:0] opAAdr;                
    reg [2:0] opBAder;                
    reg [3:0] opcode;                 
    reg [2:0] dest_reg;              
    reg [7:0] operandA;               
    reg [7:0] operandB;             
    reg [7:0] dataMemoryData;         

    //Outputs from EU.
    wire [2:0] opAsendAdr;            
    wire [2:0] opBsendAdr;           
    wire [2:0] destReg;               
    wire [7:0] result;              
    wire writeEnable;                
    wire [7:0] storeData;             
    wire dmWE;                        

    eu dut (
        .clk(clk),
        .reset(reset),
        .opAAdr(opAAdr),
        .opBAder(opBAder),
        .opcode(opcode),
        .dest_reg(dest_reg),
        .opAsendAdr(opAsendAdr),
        .opBsendAdr(opBsendAdr),
        .destReg(destReg),
        .operandA(operandA),
        .operandB(operandB),
        .data_memory_data(dataMemoryData),  
        .result(result),
        .write_enable(writeEnable),
        .store_data(storeData),
        .data_memory_write_enable(dmWE)
    );

  
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

 
    initial begin
        reset = 1;
        #10;
        reset = 0;
        opAAdr = 3'b000;
        opBAder = 3'b001;
        opcode = 4'b0001;
        dest_reg = 3'b010;
        operandA = 8'h01;
        operandB = 8'h02;
        dataMemoryData = 8'h00;  
        #10;

        opcode = 4'b0100;
        dataMemoryData = 8'hAB;      //LOAD 
        #10;

        opcode = 4'b0101;
        dataMemoryData = 8'hAB;      //STORE 
        #10;  
        reset = 0;
        $stop; 


    end 
endmodule
