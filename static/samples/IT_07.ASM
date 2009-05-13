PAGE 70,166
;------------------- PRG_07 -----------------
;Somma di 2 words di valore 0120H e 0241H presenti
;in memoria, il risultsto viene salvato in una 
;terza word di memoria ( il risultato non deve 
;superare  i 16bit ).
;
IMONITOR = 07H
DS_SEG   = 0080H

;-------------------------------------- DATA
DATA     xxxxxxxxxxxx
DATA_1   xxxxxxxxxxxx
DATA_2   xxxxxxxxxxxx
SOMMA	 DW	0H
xxxxxxxx ENDS

;-------------------------------------- CODE
;il programma viene caricato all'indirizzo 0000:0810H
PROG	SEGMENT
         ASSUME xxxxxxxxxxxxxxxxxxx

START:  MOV  AX,xxxxx	;
        MOV  DS,AX	;carica DS segment
        MOV  xx,DATA_1	;carica il primo dato
        MOV  BX,DATA_2	;carica il secondo dato
	ADD  AX,BX
	MOV  SOMMA,AX	;somma
	INT  IMONITOR	;ritorno al monitor
	
PROG	ENDS
	END  START
