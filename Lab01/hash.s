.global hash
.p2align 2
.type hash, %function
	
   /*! \brief 		calculates the hash of a given string.
	*  \param R0 	pointer to the string S to be hashed
	*  \param R1  	pointer to the array A with the int hash value for every latin letter
	*/
	hash:
		.fnstart
			MOV R3, #0					// Initialize R3 = 0. Stores the hash result
			
		loop:								
			LDRB R2, [R0], #1				// Load next character to R2 and S++
			CMP R2, #0					// Compare R2 with '\0'
			BEQ exit					// If R2 == '\0'; break
			SUBS R2, R2, #48				// R2 = R2 - '0'[=48] (map ['0'-'9']->[0-9])
			BLS loop					// If R2 <= 0; continue
			CMP R2, #9					// Compare R2 with 9
			IT LS						// IT enabling thumb mode with LS condition for SUBLS instruction
			SUBLS R3, R3, R2				// if R2 <= 9; R3 -= R2 (subtract digit from result)
			BLS loop					// if R2 <= 9; continue
			SUBS R2, R2, #49				// R2 = R2 - ('a' - '0')[=48] (map ['a'-'z']->[0-25]) && update flags
			BLT loop					// if R2 < 0; continue
			CMP R2, #25					// Compare R2 with 25
			ITT LS						// ITT enabling thumb mode with LS condition for LDRLS and ADDLS
			LDRLS R4, [R1, R2, LSL #2]			// if R2 <= 25; R4 = A[R2 * 4 bytes]
			ADDLS R3, R3, R4				// if R2 <= 25; R3 = R3 + R4 (add A[letter] to result)
			B loop							
		exit:								
			MOV R0, R3					// move result to R0
			MOV PC, LR					// return
		.fnend
	
