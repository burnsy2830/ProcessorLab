module irtb;
    reg clk;
    reg rst;
    wire [12:0] irOut;


    iu iu (
        .clk(clk),
        .reset(rst),           
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

endmodule
