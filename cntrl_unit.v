module cntrl_unit ( input BrLT, BrEq,
                    input [31:0] instr,
                    output BSel, MemRW, RegWEn, BrUn,
                    output [1:0] WBSel,
                    output [2:0] RWCntrl,
                    output reg PCSel,
                    output reg [3:0] ALUSel)
;

wire [6:0] opcode = instr[6:0];

assign ASel = (opcode == 7'b1100011) || (opcode == 7'1101111); // if B/J-Type, ASel = 1; 0 otherwise
assign BSel = !(opcode == 7'b0110011); // if R-Type, BSel = 0; 1 if I/S/B/J-Type
assign BrUn = (instr[14:13] == 2'b11); // if funct3 is 110/111 or bltu/bgeu
assign RWCntrl = instr[14:12]; // funct3 field
assign MemRW = (opcode == 7'b0100011); // if S-Type, MemRW = 1; 0 otherwise
assign WBSel = ((opcode == 1100111) || (opcode == 1101111)) ? 2'b10 : !(opcode == 7'b0000011) ? 2'b01 : 2'b00; // If I-Type(JALR)/J-Type, WBSel = 2; if I-Type Load, WBSel = 0; 1 otherwise
assign RegWEn = !((opcode == 7'b0100011) | (opcode == 7'b1100011)); // if S/B-Type, RegWEn = 0; 1 otherwise

always @ (instr) begin
    case (opcode)
        7'b0110011 : ALUSel = {instr[30],instr[9:7]}; // R-Type
        7'b0010011 : if (instr[9:7] == 3'b101) // I-Type Arithmetic
                        ALUSel = {instr[30],instr[9:7]};
                    else ALUSel = {1'b0,instr[9:7]};
        7'b0000011 : ALUSel = 4'b0; // I-Type Load
        7'b1100111 : ALUSel = 4'b0; // I-Type JALR
        7'b0100011 : ALUSel = 4'b0; // S-Type
        7'b1100011 : ALUSel = 4'b0; // B-Type
        7'b1101111 : ALUSel = 4'b0; // J-Type
        default : ALUSel = 4'b0;
    endcase
end

always @ (instr) begin
    case (opcode)
    7'b1100011 : case (instr[14:12]) // B-Type
                    3'b000 : PCSel = BrEq; // beq
                    3'b001 : PCSel = !BrEq; // bne
                    3'b100 : PCSel = BrLT; //blt
                    3'b101 : PCSel = !BrLT; //bge
                    3'b110 : PCSel = BrLT; //bltu
                    3'b111 : PCSel = !BrLT; //bgeu
                    default : PCSel = 1'b0;
                endcase
    7'b1100111 : PCSel = 1'b1; // I-Type JALR
    7'b1101111 : PCSel = 1'b1; // J-Type
    default : PCSel = 1'b0;
    endcase
end

endmodule