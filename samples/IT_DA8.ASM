PAGE 70,166
;-------------------------- PRG_DA ----------------------
;generazione del valore massimo 8 volt in 
;uscita del convertitore Digitale/Analogico
MEM_POS    =  0800H
DS_SEG     =  0080H
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
         MOV  AL,0FFH
TLOOP:   INT  IDA_WRITE    ;out su D/A
         JMP  TLOOP

MSG      DB   ' outD/A 8volt   ',00H
CODE     ENDS
         END  START
