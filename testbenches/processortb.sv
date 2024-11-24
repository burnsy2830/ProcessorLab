// Testbench for structural RISC CPU top module
module risc_system_top_tb;

    // Declare testbench signals
    reg clk, rst_n;

    // Clock generation
    initial begin
        clk = 1'b0;                       // Initialize clock to 0
        forever #10 clk = ~clk;           // Generate clock with 20 ns period
    end

    // Reset sequence
    initial begin
        rst_n = 1'b1;                     // Initialize reset to 0 (active low)
        #5 rst_n = 1'b0;                  // Deassert reset after 5 ns
        #640 $stop;                       // Stop simulation after 640 ns
    end

    // Instantiate the DUT (Device Under Test)
    processor uut (
        .clk(clk),                        // Connect clock
        .reset(rst_n)                     // Connect reset
    );

endmodule
