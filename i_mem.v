module i_mem #(parameter IMEM_SIZE = 16)(   input MASTER_RESET,
                                            input [31:0] instr_addr,
                                            output [31:0] instr)
;

reg [31:0] instr_mem [IMEM_SIZE-1:0]; // array of IMEM_SIZE instructions, each 32 bits wide

always @ (*) begin
    if (MASTER_RESET) begin 
    instr_mem[0] = 32'h007302B3; // add x5, x6, x7 : R-Type
    instr_mem[1] = 32'h00A4C433; // xor x8, x9, x10 : R-Type
    instr_mem[2] = 32'hFFB60593; // addi x11, x12, -5 : Arithmetic I-Type
    instr_mem[3] = 32'h00B72423; // sw x11, 8(x14) : S-Type
    instr_mem[4] = 32'h00872683; // lw x13, 8(x14) : Load I-Type
    instr_mem[5] = 32'h00D59863; // bne x11, x13, Label1 (Label1 = PC + 0x10) : B-Type
    instr_mem[6] = 32'h4AC4F000; // lui x15, 0x4AC4F : LUI U-Type
    instr_mem[7] = 32'h980CC597; // auipc x11, 0x980CC : AUIPC U-Type
    instr_mem[8] = 32'h1254886F; // jal x16, Label2 (Label2 = PC + 0x48925) : J-Type
    instr_mem[9] = 32'h028008E7; // jalr x17, x0, 0x28 : JALR I-Type
    instr_mem[10] = 32'h44F60913; // addi x18, x12, 44F : Arithmetic I-Type
    end
end

assign instr = instr_mem[instr_addr[31:2]];

endmodule