module reg_file (   input [31:0] instr,
                    input clk,
                    input we_reg,
                    input [31:0] ALU_op,
                    output [31:0] DataA, DataB)
;

reg [31:0] register [31:0]; // 32-bit register file with ach register being 32 bits wide

reg [4:0] addrA; // rs1
reg [4:0] addrB; // rs2
reg [4:0] addrD; // rd

always @ (*) register[0] = 32'b0;

always @ (posedge clk) begin

addrA <= instr [19:15];
addrB <= instr [24:20];
addrD <= instr [11:7];

if ((we_reg) && (addrD != 5'b0)) begin // to prevent writing into x0!
    register[addrD] <= ALU_op;
end

end

assign DataA = (addrA == 5'b0) ? 32'b0 : register[addrA];
assign DataB = (addrB == 5'b0) ? 32'b0 : register[addrB];

endmodule