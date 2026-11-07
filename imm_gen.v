module imm_gen (input [31:0] instr,
                output reg [31:0] immediate)
;

always @ (instr) begin
    case (instr[6:0])
        7'b0110011 : immediate = 32'b0; // R-Type
        7'b0010011 : case (instr[14:12]) // I-Type(arithemtic)
                        default : immediate = $signed(instr) >>> 20; // for logical/add
                        3'b101 : immediate = {27b'0,instr[24:20]}; // for srli/srai
                    endcase
        7'b0000011 : immediate = $signed(instr) >>> 20; // I-Type(load)
        7'b1100111 : immediate = $signed(instr) >>> 20; // I-Type(JALR)
        7'b0100011 : immediate = {{20{instr[31]}},instr[31:25],instr[11:7]}; // S-Type  
        7'b1100011 : immediate = {{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0}; // B-Type  
        7'b1101111 : immediate = {{12{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0} // J-Type
        7'b0110111 : immediate = instr[31:12] << 12; // U-Type(LUI)
        7'b0010111 : immediate = instr[31:12] << 12; // U-Type(AUIPC)
        default : immediate = 32'b0;
    endcase
end

endmodule