module ASel_Mux(input [31:0] DataA, instr_addr,
        input ASel,
        output [31:0] OperandA)
;

assign OperandA = ASel ? instr_addr : DataA;

endmodule