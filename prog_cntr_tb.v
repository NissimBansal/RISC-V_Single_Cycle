module prog_cntr_tb ();

reg [31:0] current_instr_addr;
reg clk;
wire [31:0] instr_addr;
integer i;

prog_cntr u0 (.current_instr_addr(current_instr_addr),.clk(clk),.instr_addr(instr_addr));

always #10 clk = ~clk;

initial begin
    {clk, current_instr_addr} = 0; #9;

    repeat (10) @ (posedge clk) begin     
        #1 $display("time=%0t current_instr_addr=0x%h instr_addr=0x%h", $time, current_instr_addr, instr_addr);
        #19;
        current_instr_addr = instr_addr;
    end
    #10 $finish;
end

initial begin
    $dumpfile ("prog_cntr.vcd");
    $dumpvars (0,prog_cntr_tb);
end

endmodule