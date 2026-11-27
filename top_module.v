module top_module (input MASTER_RESET, clk);

ALU u0 (.OperandA(), .OperandB(), .ALUSel(), .ALU_output());

ASel_Mux u1 (.DataA(), instr_addr(), .ASel(), .OperandA());

brnch_comp u2 (.DataA(), .DataB(), .BrUn(), .BrEq(), .BrLT());

endmodule