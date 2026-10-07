module prog_cntr (input [31:0] current_instr_addr,
                  input [31:0] instr_addr_ALU,
                  input PCSel,
                  input clk,
                  output reg [31:0] instr_addr)
;

reg [31:0] PC;

always @ (posedge clk) begin
    if (PCSel) PC <= instr_addr_ALU; // send address from ALU
    else PC <= current_instr_addr + 1; // goes to the next instruction in i_mem
end

assign instr_addr = PC;

endmodule