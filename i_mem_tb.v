`timescale 1 ns / 1 ps
module i_mem_tb ();

reg [31:0] instr_addr;
wire [31:0] instr;
integer i;

i_mem u0 (.instr_addr(instr_addr), .instr(instr));

initial begin

    $monitor("instr_addr=0x%h instr=0x%h", instr_addr, instr);

    for (i = 0; i < 2; i = i + 1) begin
       #10 instr_addr <= i; 
    end
    #10;
end

initial begin
    $dumpfile ("i_mem.vcd");
    $dumpvars (0,i_mem_tb);
end

endmodule