module risc_system_top_tb;

    reg clk, rst_n, ce;


    initial begin
        clk = 1'b0;                       
        forever #10 clk = ~clk;           
    end



    // Reset sequence
    initial begin
        rst_n = 1'b1;                     
        #50 rst_n = 1'b0;
        ce = 1'b1;                 
        #640 $stop;                     
    end

    processor dut (
        .clk(clk),                        
        .reset(rst_n),                    
        .ce(ce)                           
    );

    always @(posedge clk) begin

        $display("-------------------------");
        $display("Time: %t", $time);
        
        // Instruction Unit (iu)
        $display("Instruction Unit (iu): PC = %b, IR = %b", dut.iu.pcOut, dut.iu.ir_out);
        
        // Control Unit (cu)
        $display("Control Unit (cu): Opcode = %b, OpA = %b, OpB = %b, DMAddr = %b, Dest = %b", 
                 dut.cu.opcode, dut.cu.operanda, dut.cu.operandb, dut.cu.dmaddr, dut.cu.dest);

        // IF/ID Pipeline Register (if_id)
        $display("IF/ID Pipeline (if_id): Opcode = %b, OpA = %b, OpB = %b, DMAddr = %b, Dest = %b", 
                 dut.if_id.opcode, dut.if_id.operanda, dut.if_id.operandb, dut.if_id.dmaddr, dut.if_id.dest);

        // Register Memory (regMem)
        $display("Register Memory (regMem): Opcode = %b, OpA = %b, OpB = %b, DMAddr = %b, Dest = %b, OpAData = %b, OpBData = %b", 
                 dut.regMem.opcode, dut.regMem.opA, dut.regMem.opB, dut.regMem.dmaddr, dut.regMem.dest, dut.regMem.operand_a, dut.regMem.operand_b);

        // ID/EX Pipeline Register (id_ex)
        $display("ID/EX Pipeline (id_ex): Opcode = %b, OpA = %b, OpB = %b, DMAddr = %b, Dest = %b, OpAData = %b, OpBData = %b", 
                 dut.id_ex.opcode, dut.id_ex.operanda, dut.id_ex.operandb, dut.id_ex.dmaddr, dut.id_ex.dest, dut.id_ex.opAdata, dut.id_ex.opBdata);

        // Execution Unit (eu)
        $display("Execution Unit (eu): Opcode = %b, OpA = %b, OpB = %b, Dest = %b, StoreData = %b, Result = %b", 
                 dut.eu.opcode, dut.eu.opAAdr, dut.eu.opBAdr, dut.eu.dest_reg, dut.eu.store_data, dut.eu.result);

        // EX/MEM Pipeline Register (ex_mem)
        $display("EX/MEM Pipeline (ex_mem): Opcode = %b, Result = %b, Dest = %b, StoreData = %b, DMAddr = %b", 
                 dut.ex_mem.opcode, dut.ex_mem.result, dut.ex_mem.dest_reg, dut.ex_mem.prev_load_result, dut.ex_mem.storeDataAdrOut);

        // Data Memory (data_memory)
        $display("Data Memory (data_memory): Opcode = %b,  Address = %b, WriteData = %b, ReadData = %b, WriteEnable = %b", 
                 dut.data_memory.opcode, dut.data_memory.address, dut.data_memory.write_data, dut.data_memory.read_data, dut.data_memory.write_enable);

        // MEM/WB Pipeline Register (mem_wb)
        $display("MEM/WB Pipeline (mem_wb): Result = %b, Dest = %b, WriteEnable = %b", 
                 dut.mem_wb.result, dut.mem_wb.dest_reg, dut.mem_wb.regWE);

        $display("-------------------------");
    end

endmodule
