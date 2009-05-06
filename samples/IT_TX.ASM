PAGE 70,166
;------------------------- PRG_TX -----------------------
;trasmissione dati sulla interfaccia seriale
;parametri di TX: 1200, N, 8, 1
;attesa di DSR all'inizio del collegamento
;attesa di CTS ad ogni byte da trasmettere
MEM_POS    =  0800H
DS_SEG     =  0080H
DELAY      =  500     ;ritardo in ms
IDIS_STR   =  0BH     ;interruzione visual.  stringa
IWAIT_MS   =  0DH     ;interruzione gestione attesa
ISERIAL    =  14H     ;interruzione gestione seriale
IDA        =  0FH

;---------------------------------------- CODE
;programma caricato all'indirizzo 0000:MEM_POS
CODE     SEGMENT
         ASSUME CS:CODE, DS:CODE
         ORG  00H
START:   MOV  AX,DS_SEG
         MOV  AX,DS_SEG
         MOV  DS,AX             ;carica data segment
         MOV  SI,OFFSET MW_DSR
         INT  IDIS_STR          ;display message MSG
         MOV  AH,00H
         MOV  AL,00000011B
         INT  ISERIAL           ;programmazione seriale
         MOV  AH,04H
         MOV  AL,00000001B      ;DTR attivo
         INT  ISERIAL
W_DSR:   MOV  AH,03H
         INT  ISERIAL
         AND  AH,00100000B      ;check DSR
         JZ   W_DSR             ;loop if not

TLOOP:	 MOV  SI,OFFSET MW_CTS
         INT  IDIS_STR          ;display message MSG
W_CTS:   MOV  AH,03H
         INT  ISERIAL
         AND  AH,00010000B      ;check CTS
         JZ   W_CTS             ;loop if not

         MOV  AH,01H
         MOV  AL,01010101B	;carattere U
         INT  ISERIAL		;trasmissione
         MOV  SI,OFFSET MS_BYTE
         INT  IDIS_STR          ;display message MSG
         MOV  AX,200
         INT  IWAIT_MS
	 JMP	TLOOP

MW_DSR   DB   'Wait for DSR    ',00H
MW_CTS   DB   'Wait for CTS    ',00H
MS_BYTE  DB   'Byte trasmesso  ',00H

CODE     ENDS
         END  START
