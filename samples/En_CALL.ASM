PAGE 70,166
;-------------------------- PRG_CALL ---------------
;this emits  3 beeps  from the buzzer, at fixed time
;intervals. A procedure is used, called 2 times, 
;to obtain the time intervals.
IMONITOR  EQU   07H
IBUZZER   EQU   10H
IPARAL    EQU   12H
;---------------------------------------- CODE
;program charged in address 0000:0800H
PROG    SEGMENT
	ASSUME CS:PROG, DS:PROG

START:	MOV  AH,00H
        MOV  AL,00H
        INT  IPARAL     ;Output port
	MOV  BX,200     ;duration beep
	MOV  CX,20      ;frequency beep
	INT  IBUZZER    ;--------------- BEEP1
	CALL ATT        ;wait
	MOV  BX,200     ;
	MOV  CX,20      ;
	INT  IBUZZER    ;--------------- BEEP2
	CALL ATT        ;wait
	MOV  BX,200     ;
	MOV  CX,20      ;
	INT  IBUZZER    ;--------------- BEEP3

	INT  IMONITOR   ;return to the monitor

;procedure of waiting
ATT     PROC NEAR
        PUSH AX         ;save registers
	PUSH CX
	MOV  AX,1000    ;load the counter AX
LOOP2:  MOV  CX,100     ;load the counter CX
LOOP1:  DEC  CX         ;loop 
	CMP  CX,0000H   ;
	JNZ  LOOP1      ;
	DEC  AX
	CMP  AX,0000H
	JNZ  LOOP2
	POP  CX         ;reload registers
	POP  AX
	RET
ATT     ENDP
PROG    ENDS
	END  START
