PAGE 70,166
;------------------------- PRG_RAM ----------------------
;scrive il codice AA in ogni cella delle memorie RAM
;M1L e M1H, legge poi le celle e visualizza il dato
;letto sul display, ogni 1 s
MEM_POS    =  0800H
DS_SEG     =  0080H
IDIS_BYTE  =  09H     ;interruzione vis. byte
IDIS_STR   =  0BH     ;interruzione vis. stringa
IWAIT_MS   =  0DH     ;interruzione attesa ms
;---------------------------------------- CODE
;programma caricato all'indirizzo 0000:MEM_POS
CODE     SEGMENT
         ASSUME CS:CODE, DS:CODE
         ORG  0H
START:   MOV  AX,DS_SEG
         MOV  DS,AX          ;carica data segment
         MOV  SI,OFFSET MSG
         INT  IDIS_STR       ;display message MSG
         MOV  AX,0400H       ;segmento RAM   
         MOV  ES,AX
         MOV  SI,0000H       ;indirizzo RAM
TLOOP:   MOV  AL,0AAH
         MOV  ES:[SI],AL     ;scrivi dato in RAM
         MOV  AL,ES:[SI]     ;leggi dato da RAM
         MOV  CL,12
         INT  IDIS_BYTE      ;visualizza dato
         MOV  AX,SI
         MOV  AL,AH
         MOV  CL,5
         INT  IDIS_BYTE       ;visualizza MSB indirizzo
         MOV  AX,SI
         MOV  CL,7
         INT  IDIS_BYTE       ;visualizza LSB indirizzo
         MOV  AX,150
         INT  IWAIT_MS        ;attesa
         INC  SI              ;incrementa indirizzo
         JMP  TLOOP

MSG      DB  'RAM: xxxx - xx  ',00H
CODE     ENDS
         END  START
