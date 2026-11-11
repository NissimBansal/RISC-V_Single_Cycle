`timescale 1ns/1ps
module top_tb;

reg MASTER_RESET, clk;

top_module RISCV (.MASTER_RESET(MASTER_RESET), .clk(clk));

always #10 clk = ~clk;

initial begin
    {MASTER_RESET, clk} = 2'b00;

    #3; 
    MASTER_RESET = 1'b1; 
    #3; 
    MASTER_RESET = 1'b0;

end

endmodule