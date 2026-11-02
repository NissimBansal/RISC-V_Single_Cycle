module WBSelMux(input [31:0] ALU_output, DataRead, instr_addr, 
                input [1:0] WBSel,
                output [31:0] DataD)
;

assign DataD = (WBSel==2'b10) ? instr_addr + 32'h4 : (WBSel==2'b01) ? ALU_output : DataRead;

endmodule