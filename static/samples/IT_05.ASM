PAGE 70,166
;----------------------------- PRG_05 -------------------
;Somma di 2 Bytes di valore 04H e 12H presenti
;in memoria, il risultsto viene salvato in una 
;terza cella di memoria ( il risultato non deve 
;superare 8bit ).
IMONITOR   =  07H
DS_SEG     =  0080H
;---------------------------------------- CODE
;il programma viene caricato all'indirizzo 0080:0000H
PROG	SEGMENT
        ASSUME CS:PROG, DS:PROG
	
START:  MOV	AX,DS_SEG
        MOV	DS,AX         ;carica DS segment
        MOV	AL,DATA_1
        MOV	BL,DATA_2
	ADD	AL,BL
	MOV	SOMMA,AL
	NOP
	INT	IMONITOR 
	
;---------------------------------------- DATA
DATA_1	DB	04H
DATA_2	DB	12H
SOMMA	DB	00H


PROG	ENDS
	END  START
