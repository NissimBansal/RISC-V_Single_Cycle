module imm_gen_tb ();

reg [31:0] instr;
wire signed [31:0] immediate;

imm_gen u0 (.instr(instr),.immediate(immediate));

initial begin
    instr = 32'b0;
    #10;
    instr = 32'h007302B3; #5;
    $display("time=%0t instr=0x%h immediate=0x%h", $time, instr, immediate);
    #10;
    instr = 32'hFFB30293; #5;
    $display("time=%0t instr=0x%h immediate=0x%h", $time, instr, immediate);
    #10; $finish;
end

initial begin
    $dumpfile ("imm_gen.vcd");
    $dumpvars (0,imm_gen_tb);
end

endmodule