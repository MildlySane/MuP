.CSEG
.ORG 0
.EQU N = 0x09; The value of N for which a(N) is to be found
	LDI R30, 0x01
	LDI R16, 0x00; a(1), stores a(n-1)
	LDI R17,0x01; a(2), stores a(n)
	LDI R18, 0x00; temporary variable
	LDI R19,N
	SUB R19, R30; N-2 more iterations
LOOP:
	MOV R18, R17
	ADD R17,R16
	MOV R16, R18
	DEC R19
	BRNE LOOP
	MOV R0,R17; Result stored in R0