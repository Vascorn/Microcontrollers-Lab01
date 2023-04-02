.global drootfactorial
.p2align 2
.type drootfactorial, %function
	
	/*! \brief 		calculates the digital root of a number and returns its factorial : (dr[n])!.
					(e.g. dr[66] = 6 + 6 = 12 := 1 + 2 = 3 => the return value would be 3! = 6)
					Used lemma: It can be proven that the digital root of an integer is equivalent 
					to computing the modulo 9 of the considered number. That is dr[n] = 1 + (n - 1)mod9.
	*  \param R0 	contains a signed integer n. 
	*/
	
	drootfactorial:
		.fnstart
			CMP R0, #0             // Compare R0 with 0
			BEQ factorial		   // If R0 == 0 jump to compute its factorial
			IT LT				   // IT enabling thumb mode with LT condition for RSBLT
			RSBLT R0, R0, #0       // R0 <- 0 - R0; perfoms reverse order subtraction if R0 < 0
			MOV R3, #0			   // Initializes R3 = 0. R3 stores 0 if the number of iterations is even, else 1 is stored
		loop:
			MOV R1, R0, LSR #3     // R1 <- floor(R0 / 8). R1 holds the quatient (q) of the division R0 / 8
			SUB R2, R0, R1, LSL #3 // R2 <- R0 - R1*8. R2 holds the remainder (r) of the division R0 / 8
			SUB R0, R2, R1         // R0 <- R2 - R1 (= r - q)
			CMP R0, #0             // Compare R0 with 0
			BEQ exit1              // If R0 == 0 (r - q = 0)jump to exit1
			BPL exit2              // If R0 > 0 (r - q > 0) jump to exit2
			EOR R3, R3, #1         // Performs logical exclusive OR with operands R3 and #1.
			RSB R0, R0, #0         // R0 <- -R0
			B loop                 // jump to loop (= move to next iteration)
		exit1:
			MOV R0, #9             // R0 <- 9;
			B factorial            // Jump to calculate the digital root's factorial
		exit2:
			CMP R3, #0             // Compare R3 with 0
			IT NE                  // IT enabling thumb mode with NE condition for RSBNE
			RSBNE R0, R0, #9       // R0 <- 9 - R0; perfoms reverse order subtraction if R0 != 0
			B factorial            // Jump to calculate the digital root's factorial
			
	factorial:
			CMP R0, #0            // Compare R0 with 0
			ITT EQ                // ITT enabling thumb mode with EQ condition for two following MOVEQ instructions
			MOVEQ R0, #1          // If R0 == 0; R0 <- 1; (0! = 1)
			MOVEQ PC, LR          // return
			MOV R4, #1            // If R0 != 0; R4 <- #1
			MOV R5, R0            // If R0 != 0; R5 <- R0
		calcres:
			CMP R4, R0            // Compare R4 with R0
			BEQ exit              // If R4 == R0; exit
			MUL R5, R5, R4        // If R4 != R0; R5 <- R5 * R4
			ADD R4, R4, #1        // If R4 != R0; R4 <- R4 + 1
			B calcres             // Jump to calcres (= move to next iteration)
		exit:
			MOV R0, R5            // R0 <- R5
			MOV PC, LR            // return
		.fnend
	
	