module Test_chessclkfsm();
reg RES, A, B, CLK;
wire Ta, Tb, Clrt;
//generate a 10 Hz clock
initial
begin
    CLK=1'b0;
    forever
    #50 CLK = ~CLK;
end
//generate inputs
initial
begin
    RES = 1'b1; A = 1'b0; B=1'b0;
    #200 RES = 1'b0;
    #200;
    A = 1'b1;
    #550 A = 1'b0;
    #350 B = 1'b1;
    #750 B= 1'b0;
    #400;
    A = 1'b1; B = 1'b1;
    #350;
    A = 1'b0; B = 1'b0;
    #450;
    A = 1'b1;
    #800;
    $stop;
end
//instantiate the FSM
chessclkfsm mut (.reset (RES),
                .Pa (A), . Pb(B), . clock (CLK),
                .Ta (Ta), .Tb (Tb), .Clr (Clrt));
endmodule
