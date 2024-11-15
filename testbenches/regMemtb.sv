module regMem_tb;
    reg clk;
    reg write;
    reg reset;
    reg [2:0] opA;
    reg [2:0] opB;
    reg [2:0] wR;
    reg [7:0] dataIn;


    wire [7:0] operand_a;
    wire [7:0] operand_b;

    
    regMem dut (
        .clk(clk),
        .write(write),
        .reset(reset),
        .opA(opA),
        .opB(opB),
        .wR(wR),
        .dataIn(dataIn),
        .operand_a(operand_a),
        .operand_b(operand_b)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    initial begin
        reset = 1;
        write = 0;
        opA = 3'b000;
        opB = 3'b001;
        wR = 3'b000;
        dataIn = 8'b00000000;
        #10 reset = 0;

    
     
        opA = 3'b000;
        opB = 3'b001;
        #10;
      

        opA = 3'b010;
        opB = 3'b011;
        #10;
       

        opA = 3'b100;
        opB = 3'b101;
        #10;
       
        opA = 3'b110;
        opB = 3'b111;
        #10;
     
        // Write new data to register 3
        reset = 0;
        write = 1;
        wR = 3'b011; 
        dataIn = 8'h0A; 
        #10 write = 0;

        opA = 3'b011;
        opB = 3'b011;
        #10;
        $stop;
    end


     initial begin
        $monitor("clk=%b, reset=%b, write=%b, opA=%b, opB=%b, wR=%b, dataIn=%h | operand_a=%h, operand_b=%h", 
                 clk, reset, write, opA, opB, wR, dataIn, operand_a, operand_b);
    end

endmodule
