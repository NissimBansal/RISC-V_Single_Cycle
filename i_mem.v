module i_mem #(parameter IMEM_SIZE = 16)(input [31:0] instr_addr,
                                    output [31:0] instr)
;

reg [31:0] instr_mem [IMEM_SIZE-1:0]; // array of IMEM_SIZE instructions, each 32 bits wide

always @ (*) begin 
    instr_mem[0] = 32'h007302B3; // add x5, x6, x7 : R-Type
    instr_mem[1] = 32'h00A4C433; // xor x8, x9, x10 : R-Type
    instr_mem[2] = 32'hFFB60593; // addi x11, x12, -5 : Arithmetic I-Type
    instr_mem[3] = 32'h00D72423; // sw x13, 8(x14) : S-Type
    instr_mem[4] = 32'h00872783; // lw x15, 8(x14) : Load I-Type
    instr_mem[5] = 32'h12345678; //
    instr_mem[6] = 32'h12345678; //
    instr_mem[7] = 32'h12345678; //
end

assign instr = instr_mem[instr_addr];

endmodule