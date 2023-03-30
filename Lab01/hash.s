.global hash
.p2align 2
.type hash, %function
	
	hash:
		.fnstart
			MOV R3, #0
		loop:
		
			LDRB R2, [R0], #1
			CMP R2, #0
			BEQ exit
			SUBS R2, R2, #48
			BLS loop
			CMP R2, #9
			IT LS
			SUBLS R3, R3, R2
			BLS loop
			SUBS R2, R2, #49
			BLT loop
			CMP R2, #25
			ITT LS
			LDRLS R4, [R1, R2, LSL #2]
			ADDLS R3, R3, R4
			B loop
		exit:
			MOV R0, R3
			MOV PC, LR
		.fnend
	