module imm_gen (input [31:0] instr,
                output reg [31:0] immediate)
;

wire signed [31:0] instr_signed = instr;

always @ (instr) begin
    case (instr[6:0])
        7'b0110011 : immediate = 32'b0;
        7'b0010011 : immediate = instr_signed >>> 19;
        default : immediate = 32'b0; 
    endcase
end

endmodule