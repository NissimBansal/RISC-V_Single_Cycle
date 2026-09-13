module i_mem (  input [31:0] instr_addr,
                output [31:0] instr)
;

reg [31:0] instr_mem [15:0]; // create an array of 16 instructions, each 32 bits wide
integer iptr = instr_addr; // take the value of targeted address into a pointer variable

initial begin 

    instr_mem[0] = 32'h007302B3; // ADD x5, x6, x7

    instr_mem[0] = 32'h12345678; // 

    instr_mem[0] = 32'h12345678; //

    instr_mem[0] = 32'h12345678; //

    instr_mem[0] = 32'h12345678; //

    instr_mem[0] = 32'h12345678; //

    instr_mem[0] = 32'h12345678; //

    instr_mem[0] = 32'h12345678; //

end

assign instr = instr_mem[iptr];

endmodule