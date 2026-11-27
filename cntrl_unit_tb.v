`timescale 1 ns / 1 ps
module cntrl_unit_tb ();

reg [31:0] instr;
reg BrLT, BrEq;
wire ASel, BSel, MemRW, RegWEn, BrUn, PCSel;
wire [1:0] WBSel;
wire [2:0] RWCntrl;
wire [3:0] ALUSel;

cntrl_unit u4 (.BrLT(BrLT), .BrEq(BrEq), .instr(instr), .ASel(ASel), .BSel(BSel), .MemRW(MemRW), .RegWEn(RegWEn), .BrUn(BrUn), .WBSel(WBSel), .RWCntrl(RWCntrl), .PCSel(PCSel), .ALUSel(ALUSel));

initial begin
    {instr, BrEq, BrLT} = 34'b0;

    $monitor("instr=0x%h BrLT=%b BrEq=%b ASel=%b BSel=%b MemRW=%b RegWEn=%b BrUn=%b WBSel=%b RWCntrl=%b PCSel=%b ALUSel=%b);", instr, BrLT, BrEq, ASel, BSel, MemRW, RegWEn, BrUn, WBSel, RWCntrl, PCSel, ALUSel);

    #10; instr = 32'h007302B3; // add x5, x6, x7 : R-Type
    #10; instr = 32'h00A4C433; // xor x8, x9, x10 : R-Type
    #10; instr = 32'hFFB60593; // addi x11, x12, -5 : Arithmetic I-Type
    #10; instr = 32'h00B72423; // sw x11, 8(x14) : S-Type
    #10; instr = 32'h00872683; // lw x13, 8(x14) : Load I-Type
    #10; instr = 32'h00D59863; BrLT = 1'b0; BrEq = 1'b1; // bne x11, x13, Label1 (Label1 = PC + 0x10) : B-Type
    #10; instr = 32'h4AC4F000; // lui x15, 0x4AC4F : LUI U-Type
    #10; instr = 32'h980CC597; // auipc x11, 0x980CC : AUIPC U-Type
    #10; instr = 32'h1254886F; // jal x16, Label2 (Label2 = PC + 0x48925) : J-Type
    #10; instr = 32'h028008E7; // jalr x17, x0, 0x28 : JALR I-Type
    #10; instr = 32'h44F60913; // addi x18, x12, 44F : Arithmetic I-Type
    #10; $finish;
end

initial begin
    $dumpfile ("cntrl_unit.vcd");
    $dumpvars (0,cntrl_unit_tb);
end

endmodule