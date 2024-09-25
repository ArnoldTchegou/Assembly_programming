; @R1 contient la prémière chaine
; @R2 contient la deuxième chaine

; Le programme principal main compare deux chaines de caractères

		.ORIG x0000
pile: 		.FILL stackend
main:		LEA R1, chaine1   
		LEA R2, chaine2
		JSR strcmp
		BR fini
		
; La routine strcmp utilise les registres R1, R2, R3 et R4 pour les calculs		
; @R0 un entier plus grand, égal ou plus petit que zéro
; @R6 pointeur sur la pile
strcmp:	LD R6,pile
		ADD R6, R6, -4
		STR R1, R6, 3
		STR R2, R6, 2
		STR R3, R6, 1
		STR R4, R6, 0		
Do:		LDR R3, R1, 0 		; R3 <--- Mem(R1)
		LDR R4, R2, 0 		; R4 <--- Mem(R2)
		NOT R4, R4
		ADD R4, R4, 1 		; R4 <--- -Mem(R2)
		ADD R1, R1, 1
		ADD R2, R2, 1
		ADD R0, R3, R4
while_cond1:	AND R3, R3, R3 	;  verifie si R3 contient '\0'
		BRz end_strcmp
while_cond2:	AND R0, R0, R0		; vérifie si les deux chaines contient des codes de caractères différents (R3!=R4)
		BRnp end_strcmp
		BR Do
end_strcmp:	LDR R4, R6, 0
		LDR R3, R6, 1
		LDR R2, R6, 2
		LDR R1, R6, 3
		ADD R6, R6, 4
		RET

; Réservation de l’espace pour la pile
		.BLKW x00A  	
stackend: 				; Adresse de mot mémoire suivant
fini:		NOP
chaine1: 	.STRINGZ "Hallo world"
chaine2: 	.STRINGZ "Hello world"
		.END
