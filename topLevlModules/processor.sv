module processor (
    input wire clk,
    input wire reset,
    input wire ce
);

//----------S0 Connections--------------
    wire [12:0] ir_outS0;
    wire [4:0] pcOutS0;
//-----------------------------------

// ------------ S1 connections-------------
    wire [3:0] opcodeS1;
    wire [2:0] opAS1;
    wire [2:0] opBS1;
    wire [3:0] dmaddrS1;
    wire [2:0] addrS1;
//------------------------------------------

// ------------ S2 connections-------------
    wire [3:0] opcodeS2;
    wire [2:0] opAS2;
    wire [2:0] opBS2;
    wire [3:0] dmaddrS2;
    wire [2:0] addrS2;
//------------------------------------------

// ------------ S3 connections-------------
    wire [3:0] opcodeS3;
    wire [2:0] opAS3;
    wire [2:0] opBS3;
    wire [3:0] dmaddrS3;
    wire [2:0] addrS3;
    wire [7:0] operandAdataS3;
    wire [7:0] operandBdataS3;
//------------------------------------------

// ------------ S4 connections-------------
    wire [3:0] opcodeS4;
    wire [2:0] opAS4;
    wire [2:0] opBS4;
    wire [3:0] dmaddrS4;
    wire [2:0] addrS4;
    wire [7:0] operandAdataS4;
    wire [7:0] operandBdataS4;
//------------------------------------------

// ------------ S5 connections-------------
    wire [3:0] opcodeS5;
    wire [2:0] opAS5;
    wire [3:0] dmaddrS5;
    wire [2:0] addrS5;
    //wire [7:0] operandAdataS5;
   // wire [7:0] operandBdataS5;
    wire [7:0] resultS5;
    wire writeEnS5;
    wire [7:0] storeDataS5;
    wire dmWES5;
//------------------------------------------

// ------------ S6 connections-------------
    wire [3:0] opcodeS6;
    wire [2:0] opAS6;
    wire [3:0] dmaddrS6;
    wire [2:0] adderS6;
    wire [7:0] resultS6;
    wire writeEnS6;
    wire [7:0] storeDataS6;
    wire dmWES6;
//------------------------------------------

// ------------ S7 connections-------------
    wire [2:0] opAS7;
    wire [2:0] addrS7;
    wire [7:0] readDataS7;
    wire writeEnS7;
//------------------------------------------

// ------------ S8 connections-------------
    wire [2:0] opAS8;
    wire [2:0] adderS8;
    wire [7:0] readDataS8;
    wire writeEnS8;
//------------------------------------------

// Instruction Unit
iu iu (
    .clk(clk),                
    .reset(reset),
    .ce(ce),            
    .pcOut(pcOutS0),          
    .ir_out(ir_outS0)         
);

// Control Unit
cu cu (
    .instIn(ir_outS0),       
    .opcode(opcodeS1),       
    .operanda(opAS1),        
    .operandb(opBS1),        
    .dmaddr(dmaddrS1),       
    .dest(addrS1)            
);

// IF/ID Pipeline Register
if_id if_id (
    .clk(clk),                
    .rst(reset),              
    .opcode(opcodeS1),        
    .operanda(opAS1),         
    .operandb(opBS1),         
    .dmaddr(dmaddrS1),        
    .dest(addrS1),            
    .prev_opcode(opcodeS2),   
    .prev_operanda(opAS2),    
    .prev_operandb(opBS2),    
    .prev_dmaddr(dmaddrS2),   
    .prev_dest(addrS2)        
);

// Register Memory
regMem regMem (
    .clk(clk),                
    .write(writeEnS8),        
    .reset(reset),            
    .opA(opAS2),              
    .opB(opBS2),              
    .dmaddr(dmaddrS2),        
    .dest(addrS2),            
    .opcode(opcodeS2),
    .wR(adderS8),             
    .dataIn(readDataS8),      
    .operand_a(operandAdataS3),
    .operand_b(operandBdataS3),
    .adderAO(opAS3),          
    .adderBO(opBS3),          
    .dmaddrO(dmaddrS3),       
    .destO(addrS3),           
    .opcodeO(opcodeS3)        
);

// ID/EX Pipeline Register
id_ex id_ex (
    .clk(clk),                     
    .rst(reset),                   
    .opcode(opcodeS3),             
    .operanda(opAS3),              
    .operandb(opBS3),              
    .dmaddr(dmaddrS3),             
    .dest(addrS3),                 
    .opAdata(operandAdataS3),      
    .opBdata(operandBdataS3),      
    .prev_opcode(opcodeS4),        
    .prev_operanda(opAS4),         
    .prev_operandb(opBS4),         
    .prev_dmaddr(dmaddrS4),        
    .prev_dest(addrS4),            
    .prev_opAdata(operandAdataS4),
    .prev_opBdata(operandBdataS4)  
);

// Execution Unit
eu eu (
    .clk(clk),                             
    .reset(reset),                         
    .opAAdr(opAS4),                        
    .opBAdr(opBS4),                       
    .opcode(opcodeS4),                     
    .dest_reg(addrS4),                     
    .storeDataAdr(dmaddrS4),               
    .operandA(operandAdataS4),             
    .operandB(operandBdataS4),             
    .storeDataAdrOut(dmaddrS5),            
    .result(resultS5),                     
    .write_enable(writeEnS5),              
    .store_data(storeDataS5),              
    .opcodeO(opcodeS5),                    
    .outAaddr(opAS5),                      
    .destReg(addrS5),                      
    .data_memory_write_enable(dmWES5)      
);

// EX/MEM Pipeline Register
ex_mem ex_mem (
    .clk(clk),                             
    .rst(reset),                           
    .storeDataAdrOut(dmaddrS5),            
    .result(resultS5),                     
    .opAAdr(opAS5),                        
    .opcode(opcodeS5),                     
    .regWE(writeEnS5),                     
    .data_memory_write_enable(dmWES5),    
    .load_result(storeDataS5),             
    .dest_reg(addrS5),                     
    .prev_storeDataAdrOut(dmaddrS6),       
    .prev_result(resultS6),                
    .prev_opAAdr(opAS6),                   
    .prev_opcode(opcodeS6),                
    .prev_regWE(writeEnS6),                
    .prev_data_memory_write_enable(dmWES6),
    .prev_load_result(storeDataS6),        
    .prev_dest_reg(adderS6)                
);

// Data Memory
data_memory data_memory (
    .clk(clk),                  
    .reset(reset),              
    .write_enable(dmWES6),      
    .regWE(writeEnS6),          
    .dest_reg(adderS6),         
    .opcode(opcodeS6),          
    .address(dmaddrS6),         
    .opAaddr(opAS6),            
    .write_result(resultS6),    
    .write_data(storeDataS6),   
    .regWEO(writeEnS7),         
    .read_data(readDataS7),     
    .opAaddrOut(opAS7),         
    .destReg(addrS7)            
);

// MEM/WB Pipeline Register
mem_wb mem_wb (
    .clk(clk),                 
    .rst(reset),               
    .result(readDataS7),       
    .opAAdr(opAS7),            
    .regWE(writeEnS7),         
    .dest_reg(addrS7),         
    .prev_result(readDataS8),  
    .prev_opAAdr(opAS8),       
    .prev_regWE(writeEnS8),    
    .prev_dest_reg(adderS8)    
);

endmodule
