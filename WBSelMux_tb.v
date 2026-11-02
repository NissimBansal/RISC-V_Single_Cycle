module WBSelMux_tb ();

reg [31:0] ALU_output, DataRead, instr_addr;
reg [1:0] WBSel;
wire [31:0] DataD;

WBSelMux u125 (ALU_output, DataRead, instr_addr, WBSel, DataD);

initial begin

    {ALU_output, DataRead, instr_addr, WBSel} = 0;

    $monitor("ALU_output=%h DataRead=%h instr_addr=%h WBSel=%b DataD=%h", ALU_output, DataRead, instr_addr, WBSel, DataD);
    
    #5; ALU_output <= 32'hDEAD_BEEF; DataRead <= 32'hFFFF_EEFE; instr_addr <= 32'h0880_0448; WBSel <= 2'b00;
    #5; ALU_output <= 32'hCAFE_CAFE; DataRead <= 32'h0000_0000; instr_addr <= 32'h0200_0004; WBSel <= 2'b01;
    #5; ALU_output <= 32'hBC40_304D; DataRead <= 32'hAACD_1287; instr_addr <= 32'h1230_044C; WBSel <= 2'b10;
    #5; ALU_output <= 32'h231A_905F; DataRead <= 32'h5243_0987; instr_addr <= 32'h0000_0448; WBSel <= 2'b11;
    #5; ALU_output <= 32'hEAEA_4911; DataRead <= 32'h43EF_EEFE; instr_addr <= 32'h0EEF_0F40; WBSel <= 2'b00;
    #5; ALU_output <= 32'hDEAD_BEEF; DataRead <= 32'hFFFE_FFFF; instr_addr <= 32'hFFFF_FFFC; WBSel <= 2'b10;

    #10 $finish;
end

initial begin
    $dumpfile ("WBSelMux.vcd");
    $dumpvars (0,WBSelMux_tb);
end

endmodule