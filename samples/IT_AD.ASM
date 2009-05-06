PAGE 70,166
;-------------------------- PRG_AD ----------------------
;lettura dal convertitore Analogico/Digitale
;e visualizzazione del risultato sul display
MEM_POS    =  0800H
DS_SEG     =  0080H
IAD_READ   =  0EH     ;interruzione lettura conv. A/D
IDIS_BYTE  =  09H     ;interruzione visual. byte
IDIS_STR   =  0BH     ;interruzione visual. stringa
IWAIT_MS   =  0DH     ;interruzione attesa
;---------------------------------------- CODE
;programma caricato all'indirizzo 0000:MEM_POS
CODE     SEGMENT
         ASSUME CS:CODE, DS:CODE
         ORG  0H
START:   MOV  AX,DS_SEG
         MOV  DS,AX          ;carica data segment
         MOV  SI,OFFSET MSG
         INT  IDIS_STR       ;display message MSG
TLOOP:   INT  IAD_READ       ;leggi A/D
         MOV  CL,13
         INT  IDIS_BYTE      ;visualizza codice tasto
         MOV  AX,200
         INT  IWAIT_MS
         JMP  TLOOP

MSG      DB   ' A/D value : xx ',00H
CODE     ENDS
         END  START
