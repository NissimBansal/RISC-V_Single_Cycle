module ALU (input [31:0] DataA, DataB,
            input ALUSel,
            output ALU_output)
;

always @ (*) begin
    if (!ALUSel) ALU_output = DataA + DataB;
    else ALU_output = DataA - DataB;
end

endmodule