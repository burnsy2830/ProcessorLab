module iu (
    input wire clk,                   
    input wire reset,                
    input wire write_enable,           
    input wire [4:0] write_address,   
    input wire [12:0] write_data,      
    output wire [12:0] ir_out          
);

//This module is the F part of the F D X M W cycle. 

   
    wire [4:0] pc_address;            
    wire [12:0] fetched_instruction;   

    // Instantiate PC 
    pc PC (
        .clk(clk),
        .rst(reset),
        .pc(pc_address)               
    );

    // Instanciate IM 
    instMem IM (
        .clk(clk),
        .address(write_enable ? write_address : pc_address), 
        .data_in(write_data),         
        .write_enable(write_enable),  
        .instruction(fetched_instruction) 
    );

    assign ir_out = fetched_instruction; // Used to display the current instruction
endmodule
