module ALU (input signed [31:0] DataA, DataB,
            input [3:0] ALUSel,
            output reg [31:0] ALU_output)
;

always @ (*) begin
    case (ALUSel) 
        4'b0000 : ALU_output = DataA + DataB; // add
        4'b1000 : ALU_output = DataA - DataB; // sub
        4'b0001 : ALU_output = DataA << DataB; // sll
        4'b0010 : ALU_output = (DataA < DataB) // slt
        4'b0011 : ALU_output = ($unsigned(DataA) < $unsigned(DataB)); // sltu
        4'b0100 : ALU_output = DataA ^ DataB; // xor
        4'b0101 : ALU_output = DataA >> DataB; // srl
        4'b1101 : ALU_output = DataA >>> DataB; // sra
        4'b0110 : ALU_output = DataA | DataB; // or
        4'b0111 : ALU_output = DataA & DataB; // and
        default : ALU_output = 32'b0; 
    endcase
end

endmodule