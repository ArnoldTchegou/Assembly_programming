; @param R1 contient l'adresse de début de la chaîne

; Programme principal
		.ORIG x0000
pile: 		.FILL stackend
main:		LEA R1,chaine	; Chargement dans R1 de l’adresse de la chaîne
		JSR strlen
		BR fini
		
; La routine strlen utilise les registres R1 et R2 pour les calculs
; @param R0 contient la longueur de la chaîne
; @R6 pointeur sur la pile
strlen:	LD R6,pile 		
		ADD R6, R6, -2
		STR R2, R6, 1
		STR R1, R6, 0
		NOT R0,R1	; R0 = -R1
		ADD R0,R0,1
loop:		LDR R2,R1,0	; Chargement dans R2 du caractère pointé par R1
		BRz fin	; Test de fin de chaîne
		ADD R1,R1,1	; Incrémentation du pointeur : p++
		BR loop
fin:		ADD R0,R0,R1	; Calcul de la différence q-p
		LDR R1, R6, 0
		LDR R2, R6, 1
		ADD R6, R6, 2
		RET
		
; Réservation de l’espace pour la pile
		.BLKW x00A 	
stackend: 				; Adresse de mot mémoire suivant
fini : 	NOP 
chaine: 	.STRINGZ "Hello"
		.END
