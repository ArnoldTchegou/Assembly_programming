;@param R1 adresse de la chaine
;@param R2 code du caractère
;@param R3 nombre d'occurence du caractère

;Le programme principal main calcul le nombre d'occurence d'un caractère dans une chaine

		.ORIG x0000
pile: 		.FILL stackend	
main:		LEA R1, chaine  	; chargement dans R1 de l'adresse de chaine
		LD R2, caract		; chargement dans R2 du code de caract
		AND R3, R3, 0 		; initialisation de R3 à 0 au cas ou il y'a aucune occurence du caractère
loop:		JSR index
		AND R0, R0, R0		 
		BRz fini
		ADD R3, R3, 1
		ADD R1, R1, 1 
		BR loop

;La routine index utilise les registres R2, R3 et R4 pour les calculs
;@param R0 adresse de la première occurence
;@R6 pointeur sur la pile
index:		LD R6,pile 		
		ADD R6, R6, -3
		STR R2, R6, 2
		STR R3, R6, 1
		STR R4, R6, 0			
		NOT R3, R2
		ADD R3, R3, 1 		; R3 <-- -R2
		AND R0, R0, 0 		; initialisation de R0 à 0 au cas ou le caractère n'est pas trouvé
while : 	LDR R4, R1, 0 		; R4 contient le caractère à l'adresse R1
		BRz fin 		; On vérifie si R4!='\0'
		ADD R4, R4, R3 	; R4 <--- R4 - R3
		BRz resultat 		; On verifie si R4=0 (c-à-d si R1 pointe sur l'adresse de l'occurrence du caractère R2)
		ADD R1, R1, 1 		; On incréménte
		BRnzp while  		; On retourne dans la boucle
resultat: 	ADD R0, R0, R1
fin:		LDR R4, R6, 0
		LDR R3, R6, 1
		LDR R2, R6, 2
		ADD R6, R6, 3
		RET

; Réservation de l’espace pour la pile
		.BLKW x00A  	
stackend: 				; Adresse de mot mémoire suivant
fini : 	NOP
caract: 	.FILL 111  		; ici caract contient le code ASCII du caractère o
chaine: 	.STRINGZ "Hollo"
		.END
