PAGE 70,166
;----------------------------- PRG_01 -------------------
;questo programma invia un dato sulla Porta A della
;interfaccia parallela
MEM_POS    =  0800H

;---------------------------------------- CODE
;programma caricato all'indirizzo 0000:MEM_POS
CODE     SEGMENT
         ASSUME CS:CODE
         ORG   0H
START:   MOV  DX,0310H  ;carica in DX indirizzo porta A
         MOV  AL,55H    ;carica in AL il dato
         OUT  DX,AL     ;uscita del dato
         INT  07H       ;ritorno al monitor
CODE     ENDS
         END  START

