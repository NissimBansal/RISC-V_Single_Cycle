`timescale 1 ns / 1 ps
module i_mem_tb ();

reg [31:0] instr_addr;
reg MASTER_RESET;
wire [31:0] instr;
integer i;

i_mem #(.IMEM_SIZE(16)) u6 (.MASTER_RESET(MASTER_RESET), .instr_addr(instr_addr), .instr(instr));

initial begin
    MASTER_RESET <= 1'b1;
    #5 MASTER_RESET <= 1'b0;

    $monitor("instr_addr=0x%h instr=0x%h", instr_addr, instr);

    for (i = 0; i < 11; i = i + 1) begin
       #10 instr_addr <= i*4; 
    end
    #10; $finish;
end

initial begin
    $dumpfile ("i_mem.vcd");
    $dumpvars (0,i_mem_tb);
end

endmodule