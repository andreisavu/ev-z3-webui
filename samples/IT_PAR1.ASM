PAGE 70,166
;------------------------- PRG_PAR1 ---------------------
;comando ciclico temporizzato dei bits delle Porte A/B e
;generazione di un 'beep' ad ogni cambio di stato
MEM_POS    =  0800H
DS_SEG     =  0080H
IWAITMS    =  0DH     ;interruzione di attesa
IBUZZER    =  10H     ;interruzione comando buzzer
IPARAL     =  12H     ;interruzione controllo parallela
IDA_WRITE  =  0FH     ;interruzione gestione conv. D/A
IDIS_STR   =  0BH     ;interruzione visual. stringa

;---------------------------------------- CODE
;programma caricato all'indirizzo 0000:MEM_POS
CODE     SEGMENT
         ASSUME CS:CODE, DS:CODE
         ORG  0H
START:   MOV  AX,DS_SEG
         MOV  DS,AX          ;carica data segment
 	 MOV  SI,OFFSET MSG
         INT  IDIS_STR       ;display message MSG
         MOV  AH,00H
         MOV  AL,00H
         INT  IPARAL         ;porte in Output
         MOV  BL,00000001B   ;data out
LOOP1:   MOV  AH,1
         MOV  AL,BL
         INT  IPARAL         ;comando porta A
         MOV  AH,2
         MOV  AL,BL
         INT  IPARAL         ;comando porta B
         PUSH BX
         MOV  BX,20
         MOV  CX,10
         INT  IBUZZER        ;beep
         POP  BX
         MOV  AX,100  
         INT  IWAITMS
         SHL  BL,1           ;sposta bit sinistra
         CMP  BL,00H
         JNZ  LOOP1
         MOV  BL,00000001B 
         JMP  LOOP1

MSG      DB   ' out ports A/B  ',00H
CODE     ENDS
         END  START
