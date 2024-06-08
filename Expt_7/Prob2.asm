.CSEG
.ORG 0
.EQU NUM1 =0x65
.EQU NUM2 =0x05
	LDI R30, NUM1
	LDI R31, NUM2
	STS 0x0E, R30
	STS 0x10, R31
	LDS R18, 0x0E
	LDS R19,0x10
	LDI R20, 0x00

LOOP:
	CP R18, R19
	BRLO FINISH; Carry Clear (If R17>R16) that is, divisor> dividend (division over)
	SUB R18, R19
	INC R20
	RJMP LOOP

FINISH:
STS 0xF0, R20; Quotient
STS 0xFF,R18; Remainder