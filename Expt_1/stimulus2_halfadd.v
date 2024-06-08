module stimulus_halfadd;

reg a, b;
wire s, cout;

halfadd2 h1(a,b,s,cout);

initial
begin

a = 1'b0;
b = 1'b0;

#20
a = 1'b0;
b = 1'b1;

#20
a = 1'b1;
b = 1'b1;

#30
$finish;

end
initial $monitor($time, "s=%b, cout = %b", s, cout);


endmodule

