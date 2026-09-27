module WBSel_Mux(input [31:0] ALU_output, DataRead,
        input WBSel,
        output [31:0] DataD)
;

assign DataD = WBSel ? ALU_output : DataRead;

endmodule