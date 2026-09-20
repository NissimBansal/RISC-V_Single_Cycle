module reg_file (   input [31:0] instr,
                    input clk,
                    input RegWEn,
                    input [31:0] ALU_op,
                    output [31:0] DataA, DataB)
;

reg [31:0] register [31:0]; // 32-bit register file with ach register being 32 bits wide

wire [4:0] addrA = instr[19:15]; // capture rs1
wire [4:0] addrB = instr[24:20]; // capture rs2
wire [4:0] addrD = instr[11:7]; // capture rd

always @ (posedge clk) begin
    if ((RegWEn) && (addrD != 5'b0)) begin // to prevent writing into x0 register
        register[addrD] <= ALU_op;
    end
end

assign DataA = (addrA == 5'b0) ? 32'b0 : register[addrA];
assign DataB = (addrB == 5'b0) ? 32'b0 : register[addrB];

endmodule