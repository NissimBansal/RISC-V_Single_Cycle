module (input [31:0] DataB, immediate,
        input BSel,
        output [31:0] OperandB)
;

assign OperandB = BSel ? immediate : DataB;

endmodule