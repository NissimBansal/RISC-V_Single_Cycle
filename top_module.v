module top_module (input MASTER_RESET, clk);

ALU u0 (.OperandA(OperandA), .OperandB(OperandB), .ALUSel(ALUSel), .ALU_output(ALU_output));

ASel_Mux u1 (.DataA(DataA), instr_addr(instr_addr), .ASel(ASel), .OperandA(OperandA));

brnch_comp u2 (.DataA(), .DataB(), .BrUn(), .BrEq(), .BrLT());

BSel_Mux u3 (.DataB(DataB), .immediate(immediate), .BSel(BSel), .OperandB(OperandB));

cntrl_unit u4 (.BrLT(BrLT), .BrEq(BrEq), .instr(instr), .ASel(ASel), .BSel(BSel), .MemRW(MemRW), .RegWEn(RegWEn), .BrUn(BrUn), .WBSel(WBSel), .RWCntrl(RWCntrl), .PCSel(PCSel), .ALUSel(ALUSel));

d_mem #(.DMEM_SIZE(32)) u5 (.addr_dmem(), .DataB(), .clk(clk), .MemRW(), .MASTER_RESET(MASTER_RESET), .RWCntrl(), .DataRead());

i_mem #(.IMEM_SIZE(16)) u6 (.MASTER_RESET(MASTER_RESET), .instr_addr(instr_addr), .instr(instr));

imm_gen u7 (.instr(instr), .immediate(immediate));

prog_cntr u8 (.current_instr_addr(), .instr_addr_ALU(), .PCSel(), .clk(clk), .instr_addr());

reg_file u9 (.instr(), .clk(clk), .RegWEn(), .MASTER_RESET(MASTER_RESET), .DataD(), .DataA(), .DataB());

WBSelMux u10 (.ALU_output(), DataRead(), instr_addr(), .WBSel(), .DataD());

endmodule