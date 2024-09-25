; @param R1 contient l'adresse de début de la chaîne
; @param R2 code du caractère

; Le programme principal utilise les sous-routine rindex pour trouver la dernière occurrence d'un caractère

		.ORIG x0000
pile: 		.FILL stackend
main:		LEA R1,chaine		; Chargement dans R1 de l’adresse de la chaîne
		LD R2, caract 		; R2 <--- code de caract
		JSR rindex
		BR fini


;La routine rindex utilise les registres R1, R2, R3, R4 et R5 pour les calculs
; @param R0 adresse de la dernière occurence
; @R6 pointeur sur la pile
		
rindex:	LD R6,pile 		
		ADD R6, R6, -6
		STR R1, R6, 5		; sauvegarde du contenu du registre R1
		STR R2, R6, 4		; sauvegarde du contenu du registre R2
		STR R3, R6, 3		; sauvegarde du contenu du registre R3
		STR R4, R6, 2		; sauvegarde du contenu du registre R4
		STR R5, R6, 1		; sauvegarde du contenu du registre R5
		STR R7, R6, 0		; sauvegarde du contenu du registre R7
		NOT R3, R2
		ADD R3, R3, 1		; R3 <--- -R2
 		JSR strlen 		; Appel de la sous-routine strlen
 		AND R4, R4, 0
 		ADD R0, R0, -1 
		ADD R4, R1, R0 	; R4 pointe sur la fin de la chine de caractère
		NOT R1, R1
		ADD R1, R1, 1
		AND R0, R0, 0		; initialisation de R0 à 0 au cas ou le caractère n'est pas trouvé		
loop:		ADD R2, R4, R1		; parcourir la chaine dans la sens inverse à partir de la fin, on vérifie si R4!=R1
		BRnz end_loop
		LDR R5, R4, 0
		ADD R5, R5, R3		; on vérifie si on a trouver la dernier occurance du caractère contenu dans R2 (Mem(R5)!=R2)
		BRz resultat
		ADD R4, R4, -1
		BR loop
resultat:	ADD R0, R0, R4
end_loop:	LDR R7, R6, 0		; Restauration du contenu du registre R7
		LDR R5, R6, 1		; Restauration du contenu du registre R5
		LDR R4, R6, 2		; Restauration du contenu du registre R4
		LDR R3, R6, 3		; Restauration du contenu du registre R3
		LDR R2, R6, 4		; Restauration du contenu du registre R2
		LDR R1, R6, 5		; Restauration du contenu du registre R1
		ADD R6, R6, 6
		RET 
		
; La routine strlen utilise les registres R1 et R2 pour les calculs
; @param R0 contient la longueur de la chaine
; @R5 pointeur sur la pile
		
strlen:	LD R5,pile 		
		ADD R5, R5, -2
		STR R2, R5, 1		; sauvegarde du contenu du registre R2
		STR R1, R5, 0		; sauvegarde du contenu du registre R1
		NOT R0,R1		; R0 = -R1
		ADD R0,R0,1
while:		LDR R2,R1,0		; Chargement dans R2 du caractère pointé par R1
		BRz fin		; Test de fin de chaîne
		ADD R1,R1,1		; Incrémentation du pointeur : p++
		BR while
fin:		ADD R0,R0,R1		; Calcul de la différence q-p
		LDR R1, R5, 0		; Restauraion du contenu du registre R1
		LDR R2, R5, 1		; Restauraion du contenu du registre R2
		ADD R5, R5, 3
		RET

	
; Réservation de l’espace pour la pile
		.BLKW x00A  	
stackend:   				; Adresse de mot mémoire suivant
fini:		NOP
caract: 	.FILL 111  		; ici caract contient le code ASCII du caractère o
; Chaine constante
chaine: 	.STRINGZ "Bonjour"		
		.END
	
				
