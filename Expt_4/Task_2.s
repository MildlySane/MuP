	AREA Program, CODE, READONLY
	
	ENTRY
	
	LDR R0, =Num1 ;load the numbers into R0 and R1
	LDR R1, =Num2
	MOV R2, #0; assign and clear the quotient register
Loop
	CMP R1, #0 ;test division by 0
	BEQ Error1
	CMP R0, R1 ;is the dividend less than the divisor ?
	BEQ Result ;if yes, then we are done
	ADD R2, R2, #1 ;add one to quotient
	SUB R0, R0, R1
	B Loop

Error1
	MOV R3, #0xFFFFFFFF ;error flag (-1)

Result
	LDR R4, = Remainder ;store the remainder and quotient
	STR [R0], R4
	LDR R5, = Quotient
	STR [R1], R5
	SWI &11

Num1 DCD &.............
Num2 DCW &..............

	ALIGN
	
	AREA Data2, DATA, Readwrite
Quotient DCD 0
Remainder DCD 0
	
	END