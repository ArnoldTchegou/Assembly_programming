;@R1 adresse de début de la chiane de destination
;@R2 adresse de début de la chiane source

; Programme principal

		.ORIG x0000
pile: 		.FILL stackend
main:		LEA R1, destination
		LEA R2, source
		JSR strcat
		BR fini


;La routine strcat utilise les registres R0, R1, R2 et R3 pour les calculs
;@R6 pointeur sur la pile
strcat:	LD R6,pile 		
		ADD R6, R6, -4
		STR R3, R6, 3
		STR R2, R6, 2
		STR R1, R6, 1
		STR R0, R6, 0
while: 	LDR R3, R1, 0		; on se déplace à l'adresse de fin de la chaine de destination
		BRz Do
		ADD R1, R1, 1
		BR while
Do:		LDR R3, R2, 0
		STR R3, R1, 0
		ADD R2, R2, 1
		ADD R1, R1, 1
		AND R3, R3, R3
		BRz fill
		BR Do
fill:		AND R0, R0, 0
		STR R0, R1, 0		; mettre '\0' à la fin de la chaine de destination
		LDR R0, R6, 0
		LDR R1, R6, 1
		LDR R2, R6, 2
		LDR R3, R6, 3
		ADD R6, R6, 4
		RET

; Réservation de l’espace pour la pile
		.BLKW x00A  	
stackend: 				; Adresse de mot mémoire suivant
fini:		NOP
source: 	.STRINGZ "LC-3"
destination: 	.STRINGZ "hello "
		.END
