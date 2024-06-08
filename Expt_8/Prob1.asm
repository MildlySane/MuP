.CSEG
.ORG 0
.EQU NUM1 = 0x02; 1st Number to be added
.EQU NUM2 = 0XFF; 2nd Number to be added

	LDI R16, NUM1
	LDI R17, NUM2
	MOV R18, R16
	ADD R18,R17; R18 contains the Sum
	MUL R16, R17
	LDS R19,0x00
	LDS R20, 0x01; R20R19 is the product