module cu_tb;


    reg [12:0] instIn;

  
    wire [3:0] opcode;
    wire [3:0] adrr;
    wire [2:0] operanda;
    wire [2:0] operandb;
    wire [2:0] dest;

    
    cu dut (
        .instIn(instIn),
        .opcode(opcode),
        .adrr(dmaddr),
        .operanda(operanda),
        .operandb(operandb),
        .dest(dest)
    );

    
    initial begin
        
        instIn = 13'b0001001010011; // opcode = 0001, operanda = 001, operandb = 010, dest = 011
        #10;

       
        instIn = 13'b11111100000101; // opcode = 1111, adrr = 1100, dest = 101
        #10;

        instIn = 13'b11100100000100; // opcode = 1110, adrr = 0100, dest = 100
        #10;

       
        instIn = 13'b0011001011100; // opcode = 0011, operanda = 001, operandb = 011, dest = 100
        #10;

      
        instIn = 13'b0100010100110; // opcode = 0100, operanda = 010, operandb = 100, dest = 110
        #10;

      
        instIn = 13'b1001011111000; // opcode = 1001, operanda = 011, operandb = 111, dest = 000
        #10;

       
        instIn = 13'b0000000000000; // opcode = 0000, operanda = 000, operandb = 000, dest = 000
        #10;

        $stop; 
    end

endmodule