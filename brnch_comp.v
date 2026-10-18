module brnch_comp ( input [31:0] DataA, DataB,
                    input BrUn,
                    output BrEq, BrLT)
;

assign BrEq = (DataA == DataB);
assign BrLT = BrUn ? (DataA < DataB) : ($signed(DataA) < $signed(DataB));

endmodule