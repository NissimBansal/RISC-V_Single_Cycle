module reg_file_tb ();

reg [31:0] instr;
reg [3:0] ALUSel;
wire [31:0] ALU_output, DataA, DataB;
reg clk, MASTER_RESET;

always #5 clk = ~clk;

reg_file u9 (.instr(instr), .clk(clk), .RegWEn(1'b1), .MASTER_RESET(MASTER_RESET), .ALU_output(ALU_output), .DataD(DataD), .DataA(DataA), .DataB(DataB));
ALU u0 (.DataA(DataA), .DataB(DataB), .ALUSel(ALUSel), .ALU_output(ALU_output));

initial begin

    {clk, ALUSel, instr, DataD, MASTER_RESET} = 70'b1;
    $monitor("time = %0t instr=0x%h ALUSel=%b DataD=0x%h DataA=0x%h DataB=0x%h ALU_output=0x%h", $time, instr, ALUSel, DataD, DataA, DataB, ALU_output);

       #10 instr = 32'h007302B3; ALUSel = 4'b0000;
       #10 instr = 32'h00A4C433; ALUSel = 4'b0100;
       #10 instr = 32'h00D645B3; ALUSel = 4'b0111;
       #10 instr = 32'h0107E733; ALUSel = 4'b0110;
    #10; $finish;
end

initial begin
    $dumpfile ("reg_file.vcd");
    $dumpvars (0,reg_file_tb);
end
    
endmodule