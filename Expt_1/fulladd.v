module fulladd(a,b,cin,s,c);

input a;
input b;
input cin;

output s,c;

wire cout;
wire s1;
wire c1;

halfadd2 h1(a,b,s1,cout);
halfadd2 h2(s1,cin,s,c1);

assign c=c1 | cout;
 
endmodule
