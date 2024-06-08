module dflipflop(q, d, clk);
    output q;
    input d, clk;
    reg q;
    always @ (posedge clk) 
        q = d;
endmodule
