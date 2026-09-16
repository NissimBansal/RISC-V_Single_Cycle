module imm_gen (input [31:0] instr,
                output reg signed [31:0] immediate)
;

wire [6:0] opcode;
assign opcode = instr[6:0];

always @ (instr) begin
    case (opcode) 
        7'b0010011 : immediate <= instr >>> 19;
        default : immediate <= 32'b0; 
    endcase
end

endmodule