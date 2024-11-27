module instMem (
    input wire clk,                   
    input wire [4:0] address,          
    output wire [12:0] instruction     
);

    // Define memory with 32 13-bit registers
    reg [12:0] memory [31:0];

  
    initial begin
        integer i;
        for (i = 0; i < 32; i = i + 1) begin
            memory[i] = 13'b0;  
        end


        //memory[00] = 13'b0001011000101;  -> custom instruction for demonstration purposes;
        memory[00] = 13'h1c00;
        memory[01] = 13'h1c11;
        memory[02] = 13'h1c22;
        memory[03] = 13'h1c33;
        memory[04] = 13'h1c44;
        memory[05] = 13'h1c55;
        memory[06] = 13'h1c66;
        memory[07] = 13'h1c77;
        memory[08] = 13'h0208;
        memory[09] = 13'h05f1;
        memory[10] = 13'h06aa;
        memory[11] = 13'h08e3;
        memory[12] = 13'h0b24;
        memory[13] = 13'h0d45;
        memory[14] = 13'h0f86;
        memory[15] = 13'h11c7;
        memory[16] = 13'h1200;
        memory[17] = 13'h1441;
        memory[18] = 13'h1682;
        memory[19] = 13'h18c3;
        memory[20] = 13'h1b04; 
        memory[21] = 13'h1e08;
        memory[22] = 13'h1e19;
        memory[23] = 13'h1e2a;
        memory[24] = 13'h1e3b;
        memory[25] = 13'h1e4c;
        memory[26] = 13'h1e5d;
        memory[27] = 13'h1e6e;
        memory[28] = 13'h1e7f;
        memory[29] = 13'h0000;
        memory[30] = 13'h0000;
        memory[31] = 13'h0000;
        
    end

    assign instruction = memory[address];

endmodule
