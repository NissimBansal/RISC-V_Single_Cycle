module reg_file (input [31:0] instr,
                 input clk, RegWEn, MASTER_RESET,
                 input [31:0] DataD,
                 output [31:0] DataA, DataB)
;

reg [31:0] register [31:0]; // 32-bit register file with ach register being 32 bits wide


wire [4:0] addrA = instr[19:15]; // capture rs1
wire [4:0] addrB = instr[24:20]; // capture rs2
wire [4:0] addrD = instr[11:7]; // capture rd

always @ (*) begin
    if (MASTER_RESET) begin
    register[6] = 32'h000956ab;
    register[7] = 32'h003016ff;
    register[9] = 32'h03bd41fd;
    register[14] = 32'h097651ef;
    register[12] = 32'h301cdb98;
    register[29] = 32'h0087cbaa;
    register[28] = 32'h11122090;
    register[27] = 32'h87ddeef1;
    end
end

always @ (posedge clk) begin // write only at clock edge
    if ((RegWEn) && (addrD != 5'b0)) begin // to prevent writing into x0 register
        register[addrD] <= DataD;
    end
end

assign DataA = (addrA == 5'b0) ? 32'b0 : register[addrA]; // read as soon as address present
assign DataB = (addrB == 5'b0) ? 32'b0 : register[addrB]; // read as soon as address present

endmodule