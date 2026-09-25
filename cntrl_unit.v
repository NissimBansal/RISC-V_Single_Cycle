module cntrl_unit ( input [31:0] instr,
                    output PCSel, BSel)
;

assign PCSel = instr[6];
assign BSel = !(instr[6:0] == 7'b0110011) // if R-Type, BSel = 0; 1 if I-Type

endmodule