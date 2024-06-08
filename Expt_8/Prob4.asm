.include "m8def.inc"


	LDI R25, 0xff
	LDI R20, 0x00
	LDI ZL,LOW(2 * Words)
	LDI ZH,HIGH(2 * Words)


Number:
	CP R17,R20
	BRSH Update
Loop:
	LPM R17, Z+1
	CP R17, R25
	BRNE Number
	LPM R18, Z
	CP R18, R25
	BRNE Number
	RJMP NEXT


Update:
	MOV R20, R17
	STS 0xFF, R20
	RJMP Loop

NEXT:
	LDI R21, 0xFF
	LDI ZL,LOW(2 * Words)
	LDI ZH,HIGH(2 * Words)
	LDI R17, 0xFF

Number1:
	CP R17,R21
	BRLO Update1
Loop1:
	LPM R17, Z+1
	CP R17, R25
	BRNE Number1
	LPM R18, Z
	CP R18, R25
	BRNE Number1
	RJMP EXIT


Update1:
	MOV R21, R17
	STS 0xF0, R21
	RJMP Loop1

EXIT: RJMP EXIT
; add words here
Words: .db 0x01, 0xf1, 0x05, 0xf0



