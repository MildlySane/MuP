module halfadd(s, c, a,b);

input a;
input b;
output s,c;

sum s0(s,a,b);
carry c0(c,a,b);



endmodule
