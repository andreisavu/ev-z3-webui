PAGE 70,166
;------------------- PRG_CALL -----------------
;il buzzer emette 3 beep ad inetrvalli fissi,
;poi ritorna al controllo monitor
;
IMONITOR = 07H
IBUZZER  = 10H
IPARAL   = 12H
;-------------------------------------- CODE
;il programma viene caricato all'indirizzo 0000:0800H
PROG	SEGMENT
        ASSUME CS:PROG, DS:PROG

START:	MOV  AH,00H
        MOV  AL,00H
        INT  IPARAL     ;porte in Output
	MOV  BX,200	;durata beep
 	MOV  CX,20	;frequenza beep
	INT  IBUZZER	;1mo BEEP
	CALL ATT	;attesa
 	MOV  BX,200	;durata beep
 	MOV  CX,20	;frequenza beep
	INT  IBUZZER	;2mo BEEP
	CALL ATT	;attesa
 	MOV  BX,200	;durata beep
 	MOV  CX,20	;frequenza beep
	INT  IBUZZER	;3mo BEEP
	NOP
	INT  IMONITOR	;ritorna al controllo monitor
	
;routine di attesa
ATT	PROC NEAR
	PUSH AX		;salva i registi
	PUSH CX		;
	MOV  AX,1000	;carica dato di attesa Loop2
LOOP2:	MOV  CX,100	;carica dato di attesa Loop1
LOOP1:	DEC  CX
	CMP  CX,0000H
	JNZ  LOOP1
	DEC  AX
	CMP  AX,0000H
	JNZ  LOOP2
	POP CX		;ripristina i registri
	POP AX		;
	RET
ATT	ENDP
PROG	ENDS
	END  START
