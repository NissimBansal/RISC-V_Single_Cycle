module cntrl_unit ( input [31:0] instr,
                    output PCSel, BSel, MemRW, RegWEn, WBSel,
                    output [2:0] ReadCntrl,
                    output reg [3:0] ALUSel)
;

assign PCSel = instr[6];
assign BSel = !(instr[6:0] == 7'b0110011); // if R-Type, BSel = 0; 1 if I/S-Type
assign ReadCntrl = instr[9:7];
assign MemRW = (instr[6:0] == 7'b0100011); // if S-Type, MemRW = 1; 0 otherwise
assign WBSel = !(instr[6:0] == 7'b0000011); // If I-Type Load, WBSel = 0; 1 otherwise
assign RegWEn = !(instr[6:0] == 7'b0100011); // if S-Type, RegWEn = 0; 1 otherwise

always @ (instr) begin
    case (instr[6:0])
        7'b0110011 : ALUSel = {instr[30],instr[9:7]}; // R-Type
        7'b0010011 : if (instr[9:7] == 3'b101) // I-Type Arithmetic
                        ALUSel = {instr[30],instr[9:7]};
                    else ALUSel = {1'b0,instr[9:7]};
        7'b0010011 : ALUSel = 4'b0; // I-Type Load
        7'b0100011 : ALUSel = 4'b0; // S-Type
        default : ALUSel = 4'b0;
    endcase
end

endmodule