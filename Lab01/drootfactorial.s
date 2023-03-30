.global drootfactorial
.p2align 2
.type drootfactorial, %function
	
	drootfactorial:
		.fnstart
			CMP R0, #0
			BEQ factorial
			IT LT
			RSBLT R0, R0, #0
			MOV R3, #0
		loop:
			MOV R1, R0, LSR #3 //R2 holds quotient
			SUB R2, R0, R1, LSL #3 // R1 holds remainder - b
			SUB R0, R2, R1
			CMP R0, #0
			BEQ exit1
			BPL exit2 // checks case if r > b
			EOR R3, R3, #1 // keeps -1*n ; n is the number of the current iteration
			RSB R0, R0, #0 // R0 <- -R0
			B loop
		exit1:
			MOV R0, #9
			B factorial
		exit2:
			CMP R3, #0
			IT NE
			RSBNE R0, R0, #9 
			B factorial
			
	factorial:
			CMP R0, #0
			ITT EQ
			MOVEQ R0, #1
			MOVEQ PC, LR
			MOV R4, #1
			MOV R5, R0
		calcres:
			CMP R4, R0
			BEQ exit
			MUL R5, R5, R4
			ADD R4, R4, #1
			B calcres
		exit:
			MOV R0, R5
			MOV PC, LR
		.fnend
	
	