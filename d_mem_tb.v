module d_mem_tb ();

reg [31:0] addr_dmem;
reg clk, MemRW;
reg [2:0] ReadCntrl;
wire [31:0] DataRead;

d_mem #(.DMEM_SIZE(32)) u0 (.addr_dmem(addr_dmem),.clk(clk),.MemRW(MemRW),.ReadCntrl(ReadCntrl),.DataRead(DataRead));

always #10 clk = ~clk;

initial begin
    {addr_dmem, clk, ReadCntrl, MemRW} = 37'b1; #10;
    MemRW = 1'b0;
    #10;
    ReadCntrl = 3'b001;
    addr_dmem = 32'h0000_000A;
    #25;
    $display("time=%0t addr_dmem=0x%h DataRead=0x%h", $time, addr_dmem, DataRead);
    ReadCntrl = 3'b010;
    addr_dmem = 32'h0000_0018;
    #25;
    $display("time=%0t addr_dmem=0x%h DataRead=0x%h", $time, addr_dmem, DataRead);
    ReadCntrl = 3'b000;
    addr_dmem = 32'h0000_0055;
    #25;
    $display("time=%0t addr_dmem=0x%h DataRead=0x%h", $time, addr_dmem, DataRead);
    ReadCntrl = 3'b101;
    addr_dmem = 32'h0000_0076;
    #25;
    $display("time=%0t addr_dmem=0x%h DataRead=0x%h", $time, addr_dmem, DataRead);
    #10 $finish;
end

initial begin
    $dumpfile ("d_mem.vcd");
    $dumpvars (0,d_mem_tb);
end

endmodule