;@R1 adresse de début de la chiane de destination
;@R2 adresse de début de la chiane source
;@R3 le nombre maximal de caractère que doit contenir la chaine de destination

; Programme principal

		.ORIG x0000
pile: 		.FILL stackend
main:		LD  R3, nombre
		LEA R1, destination
		LEA R2, source
		JSR strlcat
		BR fini

;La routine strlcat utilise les registres R0, R1, R2, R3, R4 et R5 pour les calculs
;@R6 pointeur sur la pile
strlcat:	LD R6,pile
		ADD R6, R6, -6
		STR R0, R6, 5
		STR R1, R6, 4
		STR R2, R6, 3
		STR R3, R6, 2
		STR R4, R6, 1
		STR R5, R6, 0
		AND R4, R4, 0		; R4 va contenir la longueur de la chaine de destination avant la concatenation
while: 	LDR R0, R1, 0		; On se déplace à l'adresse de fin de la chaine de destination
		BRz next
		ADD R4, R4, 1		
		ADD R1, R1, 1
		BR while
next:		NOT R4, R4
		ADD R4, R4, -1		; R4 <-- -R4
if:		AND R5, R3, R4		; verifie si (nombre - longueur_de_destination) est positif
		BRnz fin
Do:		LDR R0, R2, 0
		STR R0, R1, 0
		ADD R2, R2, 1
		ADD R1, R1, 1
		ADD R3, R3, -1
					; verifie si ((nombre - longueur_de_destination) est positif ou null && R0 !='\0')
		AND R5, R3, R4
		BRnz fill
		AND R0, R0, R0
		BRz fill
		BR Do	
		AND R0, R0, R0
		BRz Do
fill:		AND R0, R0, 0
		STR R0, R1, 1		; mettre à la fin '\0'
fin:		LDR R5, R6, 0
		LDR R4, R6, 1
		LDR R3, R6, 2
		LDR R2, R6, 3
		LDR R1, R6, 4
		LDR R0, R6, 5
		ADD R6, R6, 6
		RET	
	

; Réservation de l’espace pour la pile
		.BLKW x001A  	
stackend: 				; Adresse de mot mémoire suivant
fini:		NOP
nombre: 	.FILL 7  		; nombre de caractères à copier
source: 	.STRINGZ "world"
destination: 	.STRINGZ "hel"
		.END
