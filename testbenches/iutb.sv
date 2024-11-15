module irtb;
    reg clk;
    reg rst;
    wire [4:0] pc;
    wire [12:0] irOut;


    iu iu (
        .clk(clk),
        .reset(rst),
        .pcOut(pc),           
        .ir_out(irOut)
    );


    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

 
    initial begin
        rst = 1;
        
        #10 rst = 0; 
        #50; 
        $stop;
    end
    initial begin
        $monitor("pc=%b, instruction=%b",pc,irOut);
    end

endmodule
