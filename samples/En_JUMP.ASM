PAGE 70,166
;---------------- PRG_JUMP -------------------------
;this program follows a series of cycles 
;to determine a waiting time of several seconds  
;and then returns the control to the monitor

MEM_POS  EQU   0800H
IMONITOR EQU   07H
;---------------------------------------- CODE
;program charged in address 0000:0800H
PROG    SEGMENT
        ASSUME CS:PROG, DS:PROG

START:  MOV   AX,1000H  ;load the counter AX

LOOP2:  MOV   CX,108H   ;load the counter CX
LOOP1:  DEC   CX        ;
	CMP   CX,0000H  ;
	JNZ   LOOP1     ;
	DEC   AX       
	CMP   AX,0000H
	JNZ   LOOP2

	INT   IMONITOR ;returns to the monitor

PROG    ENDS
	END   START
