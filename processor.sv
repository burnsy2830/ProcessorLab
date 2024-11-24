module processor (
    input wire clk,
    input wire reset
);


    //-------------IU signals-----------
    wire [4:0] pc_address; // for PC
    wire [12:0] fetched_instruction; // for CU 
    //---------------------------


    //-------------CU signals----------
    wire [3:0] opcode;
    wire [2:0] operand_a_addr; // REGISTER MEM 
    wire [2:0] operand_b_addr; // REGISTER MEM
    wire [2:0] dest_reg; // REGISTER MEMORY ADDRESS DEST 
    wire [3:0] dm_addr;  //DATA MEMORY ADDRESS 
    //------------------------------------

    //-----------Register memory signals---
    wire write_enable;
    reg [7:0] value_opA;
    reg [7:0] value_opb;
    wire [7:0] pass_to_euA;
    wire [7:0] pass_to_euB;

    assign pass_to_euA = value_opA;
    assign pass_to_euB = value_opB;
    //---------------------------------------

    //-----EU signals-----------
    wire [7:0] store_data;
    wire [7:0] store_dataOUT;  
    wire [7:0] data_memory_data;




    //-------------------------------


    //--------Data memory Signals---
    reg [7:0] read_data;
    wire[7:0] read_data_wire;
    assign read_data_wire = read_data;


    //-----------------------------











    



    iu IU (
        .clk(clk),
        .reset(reset),
        .pcOut(pc_address),
        .ir_out(fetched_instruction)
    );


    cu CU (
        .instIn(fetched_instruction),
        .opcode(opcode),
        .operanda(operand_a_addr),
        .operandb(operand_b_addr),
        .dmaddr(dm_addr),
        .dest(dest_reg)
    );

      regMem REG_MEM (
        .clk(clk),
        .write(write_enable),
        .reset(reset),
        .opA(operand_a_addr),
        .opB(operand_b_addr),
        .wR(dest_reg),
        .dataIn(),
        .operand_a(value_opA),
        .operand_b(value_opB)
    );



    data_memory DM (
        .clk(clk),
        .reset(reset),
        .write_enable(data_memory_write_enable),
        .address(dm_addr),
        .write_data(store_data),
        .read_data(read_data)
    );



     eu EU (
        .clk(clk),
        .reset(reset),
        .opAAdr(operand_a_addr),
        .opBAder(operand_b_addr),
        .opcode(opcode),
        .dest_reg(dest_reg),
        .storeDataAdr(dm_addr),
        .opAsendAdr(operand_a_addr),
        .opBsendAdr(operand_b_addr),
        .storeDataAdrOut(store_dataOUT),
        .operandA(value_opA),    // Connect operand A from regMem
        .operandB(value_opB),    // Connect operand B from regMem
        .data_memory_data(data_memory_data),
        .result(alu_result),
        .write_enable(write_enable),
        .store_data(store_data),
        .data_memory_write_enable(data_memory_write_enable)
    );


endmodule