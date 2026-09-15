module prog_cntr (  input [31:0] current_instr_addr,
                    input clk,
                    output reg [31:0] instr_addr)
;

always @ (posedge clk) begin
    instr_addr <= current_instr_addr + 1;
end

endmodule