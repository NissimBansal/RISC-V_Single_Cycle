module cntrl_unit ( input [31:0] instr,
                    output PCSel)
;

assign PCSel = instr[6];

endmodule