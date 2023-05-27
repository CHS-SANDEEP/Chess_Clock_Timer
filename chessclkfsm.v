module chessclkfsm(input reset, Pa, Pb, clock,
output Ta, Tb, Clr);
//ascending state assignment
localparam RunA = 0, RunB = 1, Stop =2, Wait=3;
reg [1:0] state;
//combined state register and next state sequential block
always @(posedge clock or posedge reset)
begin
if (reset)
state <= Stop;
else
case (state)
RunA:
casex({Pa, Pb})
2'b0x: state <= RunA;
2'b10: state <= RunB;
2'b11: state <= Wait;
endcase
RunB:
casex ({Pa, Pb})
    2'bx0: state <= RunB;
    2'b01: state <= RunA;
    2'b11: state <= Wait;
endcase
Stop:
case ({Pa, Pb})
2'b00: state <= Stop;
2'b01: state <= RunA;
2'b10: state <= RunB;
2'b11: state <= Wait;
endcase
Wait:
if (Pa == Pb)
state <= Wait;
else if (Pa == 1'b1)
state <= RunB;
else
state <= RunA;
    endcase
end
//Moore output assignments depend only on state
assign Ta = state == RunA;
assign Tb = state == RunB;
assign Clr = state == Stop;
endmodule
