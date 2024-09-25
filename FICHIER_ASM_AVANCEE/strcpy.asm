;@R1 adresse de la chiane source
;@R2 adresse de la chiane destination

; Programme principal

		.ORIG x0000
pile: 		.FILL stackend
main:		LEA R1, source   
		LEA R2, destination
		JSR strcpy
		BR fini
		
;La routine strcpy utilise les registres R1, R2 et R3 pour les calculs
;@R6 pointeur sur la pile
strcpy:	LD R6,pile 		
		ADD R6, R6, -3
		STR R3, R6, 2
		STR R2, R6, 1
		STR R1, R6, 0		
Do:		LDR R3, R1, 0
		STR R3, R2, 0		; copie le contenue de R3 à l'adresse R2 
		ADD R1, R1, 1
		ADD R2, R2, 1
		AND R3, R3, R3
		BRz fin
		BR Do
fin:		LDR R1, R6, 0
		LDR R2, R6, 1
		LDR R3, R6, 2
		ADD R6, R6, 3
		RET		
		
; Réservation de l’espace pour la pile
		.BLKW x00A  	
stackend: 				; Adresse de mot mémoire suivant		
fini:		NOP
source: 	.STRINGZ "Hello"
destination: 	.STRINGZ ""
		.END
