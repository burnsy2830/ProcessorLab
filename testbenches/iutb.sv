module irtb;

    // Testbench signals
    reg clk;
    reg rst;
    reg writeEn;
    reg [4:0] writeAd;
    reg [12:0] writeData;
    wire [12:0] irOut;

    // Instantiate the IU (Instruction Fetch Unit)
    iu iu (
        .clk(clk),
        .reset(rst),           
        .write_enable(writeEn), 
        .write_address(writeAd), 
        .write_data(writeData),  
        .ir_out(irOut)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    // Test sequence
    initial begin
     
        rst = 1;                  
        #10 rst = 0;            
        
        // Test case: Manual Write to Instruction Memory
        writeEn = 1;
        writeAd = 5'b00011;      
        writeData = 16'b101010101010; 
        #10;                      
        
        writeEn = 1;
        writeAd = 5'b00100;       
        writeData = 12'b111111111111; 
        #10;                      

    
        writeEn = 0;
        
       
        #50;
        
        // End of test
        $stop;
    end

endmodule
