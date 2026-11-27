`timescale 1 ns / 1 ps
module ALU_tb ();

reg signed [31:0] OperandA, OperandB;
reg [3:0] ALUSel;
wire [31:0] ALU_output;

ALU u0 (.OperandA(OperandA), .OperandB(OperandB), .ALUSel(ALUSel), .ALU_output(ALU_output));

initial begin
    {OperandA, OperandB, ALUSel} = 68'b0;

    $monitor("OperandA=0x%h, OperandB=0x%h, ALUSel=%h, ALU_output=0x%h", OperandA, OperandB, ALUSel, ALU_output);

    #10; ALUSel = 4'b0000; OperandA = 32'h32072509; OperandB = 32'h3ae2c064; #10; OperandA = 32'hc2741539; OperandB = 32'had3a1a8a;
    #10; ALUSel = 4'b1000; OperandA = 32'haf66148f; OperandB = 32'h3a06ac30;
    #10; ALUSel = 4'b0001; OperandA = 32'h08e5308e; OperandB = 32'h88e114cc;
    #10; ALUSel = 4'b0010; OperandA = 32'h0a3e2fa6; OperandB = 32'hc1e798ea; #10; OperandA = 32'h67d6a0c2; OperandB = 32'h619ec409;
    #10; ALUSel = 4'b0011; OperandA = 32'hfc270a47; OperandB = 32'h3921036d;
    #10; ALUSel = 4'b0100; OperandA = 32'h390c11ce; OperandB = 32'h4369aff0;
    #10; ALUSel = 4'b0101; OperandA = 32'hfc270a47; OperandB = 32'h00000004; #10; OperandA = 32'hf39ee01d; OperandB = 32'h0000000C; #10; OperandA = 32'hc2745539; OperandB = 32'h0000000D;
    #10; ALUSel = 4'b1101; OperandA = 32'hf0363f56; OperandB = 32'h834d64d1;
    #10; ALUSel = 4'b0110; OperandA = 32'h5e4e6afb; OperandB = 32'haeff3408;
    #10; ALUSel = 4'b0111; OperandA = 32'hfc274a47; OperandB = 32'h49af4076; #10; OperandA = 32'hc267d6a0; OperandB = 32'h619ec409;
    #10; ALUSel = 4'b1101; OperandA = 32'hf0163f56; OperandB = 32'h844de4d1;
    #10; ALUSel = 4'b1111; OperandA = 32'hde682168; OperandB = 32'hf0063f56;
    #10; $finish;
end

initial begin
    $dumpfile ("ALU.vcd");
    $dumpvars (0,ALU_tb);
end

endmodule