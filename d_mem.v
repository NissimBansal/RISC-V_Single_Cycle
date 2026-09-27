module d_mem #( parameter DMEM_SIZE = 32) 
              ( input [31:0] addr_dmem,
                input clk, MemRW,
                input [2:0] ReadCntrl;
                output reg [31:0] DataRead)
;

reg [31:0] Data_mem [DMEM_SIZE-1:0]; // array of DMEM_SIZE registers, each 32 bits/4 bytes wth each byte having a unique address

initial begin
    Data_mem[2] = 32'hDEAD_BEEF;
    Data_mem[5] = 32'h0000_0000;
    Data_mem[6] = 32'hFFFF_FFFF;
    Data_mem[8] = 32'hCAFE_CAFE;
    Data_mem[12] = 32'h0800_0000;
    Data_mem[21] = 32'h2000_7201;
    Data_mem[29] = 32'h53FB_AC02;
end

always @ (posedge clk) begin
    if (!MemRW) begin // if we have to load data from d_mem
        case (ReadCntrl) 
        3'b000 : case (addr_dmem[1:0]) // lb
                    2'b00 : DataRead <= {{24{Data_mem[addr_dmem[31:2]][7]}},Data_mem[addr_dmem[31:2]][7:0]};
                    2'b01 : DataRead <= {{24{Data_mem[addr_dmem[31:2]][15]}},Data_mem[addr_dmem[31:2]][15:8]};
                    2'b10 : DataRead <= {{24{Data_mem[addr_dmem[31:2]][23]}},Data_mem[addr_dmem[31:2]][23:16]};
                    2'b11 : DataRead <= {{24{Data_mem[addr_dmem[31:2]][31]}},Data_mem[addr_dmem[31:2]][31:24]};
                endcase
        3'b001 : case (addr_dmem[1:0]) // lh
                    2'b00 : DataRead <= {{16{Data_mem[addr_dmem[31:2]][15]}},Data_mem[addr_dmem[31:2]][15:0]};
                    2'b10 : DataRead <= {{16{Data_mem[addr_dmem[31:2]][31]}},Data_mem[addr_dmem[31:2]][31:16]};
                endcase
        3'b010 : DataRead <= Data_mem[addr_dmem[31:2]]; // lw
        3'b100 : case (addr_dmem[1:0]) // lbu
                    2'b00 : DataRead <= {{24'b0},Data_mem[addr_dmem[31:2]][7:0]};
                    2'b01 : DataRead <= {{24'b0},Data_mem[addr_dmem[31:2]][15:8]};
                    2'b10 : DataRead <= {{24'b0},Data_mem[addr_dmem[31:2]][23:16]};
                    2'b11 : DataRead <= {{24'b0},Data_mem[addr_dmem[31:2]][31:24]};
                endcase
        3'b101 : case (addr_dmem[1:0]) // lhu
                    2'b00 : DataRead <= {{16'b0},Data_mem[addr_dmem[31:2]][15:0]};
                    2'b10 : DataRead <= {{16'b0},Data_mem[addr_dmem[31:2]][31:16]};
                endcase
        default : DataRead <= Data_mem[addr_dmem[31:2]];
        endcase
    end
    else begin // if we have to store data into d_mem

    end
end

endmodule                                   