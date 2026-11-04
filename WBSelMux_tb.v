module WBSelMux_tb ();

reg [31:0] ALU_output, DataRead, instr_addr;
reg [1:0] WBSel;
wire [31:0] DataD;

WBSelMux u125 (ALU_output, DataRead, instr_addr, WBSel, DataD);

initial begin

    {ALU_output, DataRead, instr_addr, WBSel} = 0;

    $monitor("ALU_output=%h DataRead=%h instr_addr=%h WBSel=%b DataD=%h", ALU_output, DataRead, instr_addr, WBSel, DataD);
    
    #5; ALU_output <= 32'hDEAD_BEEF; #4 ;DataRead <= 32'hFFFF_EEFE; instr_addr <= 32'h0880_0448; #2; WBSel <= 2'b00;
    #5; ALU_output <= 32'hCAFE_CAFE; #3; DataRead <= 32'h0000_0000; #8; instr_addr <= 32'h0200_0004; WBSel <= 2'b01;
    #7; ALU_output <= 32'hBC40_304D; #4; DataRead <= 32'hAACD_1287; instr_addr <= 32'h1230_044C; #1; WBSel <= 2'b10;
    #5; ALU_output <= 32'h231A_905F; #7; DataRead <= 32'h5243_0987; #2; instr_addr <= 32'h0000_0448; #2; WBSel <= 2'b11; #3;
    #10; ALU_output <= 32'hEAEA_4911; DataRead <= 32'h43EF_EEFE; #1; instr_addr <= 32'h0EEF_0F40; #3; WBSel <= 2'b00;
    #6; ALU_output <= 32'hDEAD_BEEF; #9; DataRead <= 32'hFFFE_FFFF; #3; instr_addr <= 32'hFFFF_FFFC; #7; WBSel <= 2'b10;

    #10 $finish;
end

initial begin
    $dumpfile ("WBSelMux.vcd");
    $dumpvars (0,WBSelMux_tb);
end

endmodule