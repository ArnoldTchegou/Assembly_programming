;@R0 nombres de caractères à copier dépuis la source dans la chaine de destination
;@R1 adresse de début de la chiane source
;@R2 adresse de début de la chiane destination

; Programme principal

		.ORIG x0000
pile: 		.FILL stackend
main:		LEA R1, source   
		LEA R2, destination
		LD  R0, nombre
		JSR strncpy
		BR fini
		
;La routine strncpy utilise le registre R0, R1, R2 et R3 pour les calculs
;@R6 pointeur sur la pile

strncpy:	LD R6,pile
		ADD R6, R6, -4
		STR R0, R6, 3
		STR R1, R6, 2
		STR R2, R6, 1
		STR R3, R6, 0		
IF:		AND R0, R0, R0 	; verifie si nombre positif
		BRnz fin
Do:		LDR R3, R1, 0
		BRz fin
		STR R3, R2, 0		; copie le contenu de R3 à l'adresse R2 
		ADD R1, R1, 1
		ADD R2, R2, 1
					; verifie si (nombre positive && R3 !='\0')
		ADD R0, R0, -1
		BRnz fin
		AND R3, R3, R3
		BRz fin
		BR Do
fin:		LDR R3, R6, 0
		LDR R2, R6, 1
		LDR R1, R6, 2
		LDR R0, R6, 3
		ADD R6, R6, 4
		RET
		
; Réservation de l’espace pour la pile
		.BLKW x001A  	
stackend: 				; Adresse de mot mémoire suivant		
fini: 		NOP
nombre: 	.FILL 7  		; nombre de caractères à copier
source: 	.STRINGZ "hello"
destination: 	.STRINGZ "kgggggff"
		.END
