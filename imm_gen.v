module imm_gen (input [31:0] instr,
                output reg [31:0] immediate)
;

always @ (instr) begin
    case (instr[6:0])
        7'b0010011 : begin case (instr[14:12]) // I-Type(arithemtic)
                        default : immediate = $signed(instr) >>> 19; // for logical/add
                        3'b101 : immediate = {27b'0,instr[24:20]}; // for srli/srai
                    endcase
                    end    
        7'b0110011 : immediate = 32'b0; // R-Type
        7'b0000011 : immediate = $signed(instr) >>> 19; // I-Type(load)                     
        default : immediate = 32'b0; 
    endcase
end

endmodule