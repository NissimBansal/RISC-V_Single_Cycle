module i_mem (  input [31:0] instr_addr,
                output [31:0] instr)
;

reg [31:0] instr_mem [15:0]; // create an array of 16 instructions, each 32 bits wide
integer iptr; // take the value of targeted address into a pointer sort of variable

always @ (*) begin 

    iptr = instr_addr;


    instr_mem[0] = 32'h007302B3; // add x5, x6, x7 : R-Type

    instr_mem[1] = 32'h007342B3; // xor x5, x6, x7 : R-Type

    instr_mem[2] = 32'h12345678; // 

    instr_mem[3] = 32'h12345678; //

    instr_mem[4] = 32'h12345678; //

    instr_mem[5] = 32'h12345678; //

    instr_mem[6] = 32'h12345678; //

    instr_mem[7] = 32'h12345678; //

end

assign instr = instr_mem[iptr];

endmodule