module halfadd2(a,b,s, c);

input a;
input b;
output s,c;

assign s = a ^ b;
assign c = a & b;




endmodule
