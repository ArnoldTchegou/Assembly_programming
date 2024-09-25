;@R1 adresse de début de la chiane de destination
;@R2 adresse de début de la chiane source
;@R3 le nombre maximal de caractère à copier depuis la source

; Programme principal

		.ORIG x0000
pile: 		.FILL stackend
main:		LD  R3, nombre
		LEA R1, destination
		LEA R2, source
		JSR strncat
		BR fini
		
;La routine strncat utilise le registre R0, R1, R2 et R3 pour les calculs
;@R6 pointeur sur la pile
strncat:	LD R6,pile
		ADD R6, R6, -4
		STR R0, R6, 3
		STR R1, R6, 2
		STR R2, R6, 1
		STR R3, R6, 0
while: 	LDR R0, R1, 0		; on se déplace à l'adresse de fin de la chaine de destination
		BRz if
		ADD R1, R1, 1
		BR while
if:		AND R3, R3, R3		; verifie si nombre positif
		BRnz fin
Do:		LDR R0, R2, 0
		STR R0, R1, 0
		ADD R2, R2, 1
		ADD R1, R1, 1
					; verifie si (nombre strictement positif && R0 !='\0')
		ADD R3, R3, -1
		BRnz fill
		AND R0, R0, R0
		BRz fill
		BR Do
fill:		AND R0, R0, 0
		STR R0, R1, 1		; insère la caractère '\0' à la fin
fin:		LDR R3, R6, 0
		LDR R2, R6, 1
		LDR R1, R6, 2
		LDR R0, R6, 3
		ADD R6, R6, 4
		RET
		
; Réservation de l’espace pour la pile
		.BLKW x001A  	
stackend: 				; Adresse de mot mémoire suivant		
fini:		NOP
nombre: 	.FILL 3  		; nombre de caractères à copier
source: 	.STRINGZ "world"
destination: 	.STRINGZ "hello"
		.END
