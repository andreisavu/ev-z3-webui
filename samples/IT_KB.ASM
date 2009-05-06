PAGE 70,166
;----------------------------- PRG_KB -------------------
;lettura di un tasto dalla tastiera
;e visualizzazione del codice sul display
MEM_POS    =  0800H
DS_SEG     =  0080H
IKEYBOARD  =  08H     ;interruzione di lettura tastiera
IDIS_BYTE  =  09H     ;interruzione di vis. byte
IDIS_STR   =  0BH     ;interruzione di vis. stringa

;---------------------------------------- CODE
;programma caricato all'indirizzo 0000:MEM_POS
CODE     SEGMENT
         ASSUME CS:CODE, DS:CODE
         ORG  00H
START:   MOV  AX,DS_SEG
         MOV  AX,DS_SEG
         MOV  DS,AX         ;carica data segment
         MOV  SI,OFFSET MSG
         INT  IDIS_STR      ;display message MSG
TLOOP:   INT  IKEYBOARD     ;leggi tastiera
         MOV  CL,13
         INT  IDIS_BYTE     ;visualizza codice tasto
         JMP  TLOOP

MSG      DB   'KB, hex key: xx ',00H
CODE     ENDS
         END  START
