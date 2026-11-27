`timescale 1 ns / 1 ps
module cntrl_unit_tb ();

reg [31:0] instr;
reg BrLT, BrEq;
wire BSel, MemRW, RegWEn, BrUn, PCSel;
wire [1:0] WBSel;
wire [2:0] RWCntrl;
wire [3:0] ALUSel;

integer i;

cntrl_unit u4 (.BrLT(BrLT), .BrEq(BrEq), .instr(instr), .BSel(BSel), .MemRW(MemRW), .RegWEn(RegWEn), .BrUn(BrUn), .WBSel(WBSel), .RWCntrl(RWCntrl), .PCSel(PCSel), .ALUSel(ALUSel));

initial begin

    $monitor("instr_addr=0x%h instr=0x%h", instr_addr, instr);

    for (i = 0; i < 3; i = i + 1) begin
       #10 instr_addr <= i*4; 
    end
    #10; $finish;
end

initial begin
    $dumpfile ("i_mem.vcd");
    $dumpvars (0,i_mem_tb);
end

endmodule