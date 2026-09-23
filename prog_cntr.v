module prog_cntr (input [31:0] current_instr_addr,
                  input [31:0] instr_addr_ALU,
                  input PCSel,
                  input clk,
                  output reg [31:0] instr_addr)
;

always @ (posedge clk) begin
    if (PCSel) instr_addr <= instr_addr_ALU; // send address from ALU
    else instr_addr <= current_instr_addr + 1; // goes to the next instruction in i_mem
end

endmodule