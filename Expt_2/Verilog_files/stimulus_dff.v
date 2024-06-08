module inputfordff;

reg d,clk;
wire q;

dflipflop d1(q,d,clk);

initial
 begin
  clk = 1'b0;
  repeat(30)
    #10 clk = ~clk;
 end


initial
 begin

 #10  d = 1'b1;


 #20  d = 1'b0;
 
 #30  d = 1'b1;


 #40 $finish;

 end
initial $monitor($time, "clk=%b, d = %b, q = %b", clk, d, q);


endmodule
