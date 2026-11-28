module prog_cntr_tb ();

reg [31:0] current_instr_addr, instr_addr_ALU;
reg clk, PCSel;
wire [31:0] instr_addr;
integer i;

prog_cntr u0 (.current_instr_addr(current_instr_addr), .instr_addr_ALU(instr_addr_ALU), .clk(clk), .PCSel(PCSel), .instr_addr(instr_addr));

always #5 clk = ~clk;
always #10 current_instr_addr = instr_addr;

initial begin
    {clk, current_instr_addr, PCSel, instr_addr_ALU} = 0;    
    
    $monitor("time=%0t PCSel=%b current_instr_addr=0x%h instr_addr_ALU=0x%h instr_addr=0x%h", $time, PCSel, current_instr_addr, instr_addr_ALU, instr_addr);

    #7; instr_addr_ALU = 32'h007302B3;
    #10; PCSel = 1'b1;
    #10; PCSel = 1'b0;
    #2; instr_addr_ALU = 32'h00A4C433;
    #10; PCSel = 1'b1;
    #10; PCSel = 1'b0;
    
    #10 $finish;
end

initial begin
    $dumpfile ("prog_cntr.vcd");
    $dumpvars (0,prog_cntr_tb);
end

endmodule