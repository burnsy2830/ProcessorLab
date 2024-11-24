module cu(
    input wire [12:0] instIn,       // 13-bit instruction input
    output wire [3:0] opcode,       // 4-bit opcode
    output wire [2:0] operanda,     // 3-bit operand a
    output wire [2:0] operandb,     // 3-bit operand b
    output wire [3:0] dmaddr,        // 4- bit data memory
    output wire [2:0] dest          // 3-bit destination register
);


    //This module is for the D stage of F D X M W 

    // Extract the opcode from the 13-bit instruction
    assign opcode = instIn[12:9]; 

    assign dmaddr = (opcode == 4'b1111) ? instIn[8:5] : 4'b0000; 


    assign adrr = instIn[2:0];

    assign operanda = (opcode != 4'b1110 && opcode != 4'b1111) ? instIn[8:6] : 3'b000;
    assign operandb = (opcode != 4'b1110 && opcode != 4'b1111) ? instIn[5:3] : 3'b000;

  
    assign dest = instIn[2:0]; 

endmodule
