PAGE 70,166
;------------------- PRG_JUMP -----------------
;Realizza una serie di cicli di attesa di qualche
;secondo, poi ritorna al controllo monitor
;
IMONITOR = 07H

;-------------------------------------- CODE
;il programma viene caricato all'indirizzo 0000:0800H
PROG	SEGMENT
        ASSUME CS:PROG, DS:PROG
	
START:  MOV  AX,1000H	;carica dato di attesa Loop2
LOOP2:	MOV  CX,108H	;carica dato di attesa Loop1
LOOP1:	DEC  CX
	CMP  CX,0000H
	JNZ  LOOP1
	DEC  AX
	CMP  AX,0000H
	JNZ  LOOP2
	NOP
	INT  IMONITOR	;ritorna al controllo monitor
	
PROG	ENDS
	END  START
