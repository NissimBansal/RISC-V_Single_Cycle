module top_module (input MASTER_RESET, clk);

ALU u0 (.OperandA(), .OperandB(), .ALUSel(), .ALU_output());

ASel_Mux u1 (.DataA(), instr_addr(), .ASel(), .OperandA());

brnch_comp u2 (.DataA(), .DataB(), .BrUn(), .BrEq(), .BrLT());

BSel_Mux u3 (.DataB(), .immediate(), .BSel(), .OperandB());

cntrl_unit u4 (.BrLT(), .BrEq(), .instr(), .BSel(), .MemRW(), .RegWEn(), .BrUn(), .WBSel(), .RWCntrl(), .PCSel(), .ALUSel());

d_mem #(.DMEM_SIZE(32)) u5 (.addr_dmem(), .DataB(), .clk(clk), .MemRW(), .MASTER_RESET(MASTER_RESET), .RWCntrl(), .DataRead());

i_mem #(.IMEM_SIZE(16)) u6 (.MASTER_RESET(MASTER_RESET), .instr_addr(), .instr());

imm_gen u7 (.instr(), .immediate());

prog_cntr u8 (.current_instr_addr(), .instr_addr_ALU(), .PCSel(), .clk(clk), .instr_addr());

reg_file u9 (.instr(), .clk(clk), .RegWEn(), .MASTER_RESET(MASTER_RESET), .DataD(), .DataA(), .DataB());

WBSelMux u10 (.ALU_output(), DataRead(), instr_addr(), .WBSel(), .DataD());

endmodule