module ALU (input signed [31:0] OperandA, OperandB,
            input [3:0] ALUSel,
            output reg [31:0] ALU_output)
;

always @ (*) begin
    case (ALUSel) 
        4'b0000 : ALU_output = OperandA + OperandB; // add
        4'b1000 : ALU_output = OperandA - OperandB; // sub
        4'b0001 : ALU_output = OperandA << OperandB; // sll
        4'b0010 : ALU_output = (OperandA < OperandB) // slt
        4'b0011 : ALU_output = ($unsigned(OperandA) < $unsigned(OperandB)); // sltu
        4'b0100 : ALU_output = OperandA ^ OperandB; // xor
        4'b0101 : ALU_output = OperandA >> OperandB; // srl
        4'b1101 : ALU_output = OperandA >>> OperandB; // sra
        4'b0110 : ALU_output = OperandA | OperandB; // or
        4'b0111 : ALU_output = OperandA & OperandB; // and
        default : ALU_output = 32'b0; 
    endcase
end

endmodule