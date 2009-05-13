PAGE 70,166
;---------------- PRG_JUMP -------------------------
;este programa ejecuta una serie de ciclos
;para determinar una espera de algunos segundos
;y luego restituye el control al Monitor
IMONITOR = 07H

;---------------------------------------- CODE
;programa cargado en la dirección 0000:0800H

PROG    SEGMENT
        ASSUME CS:PROG, DS:PROG

START:  MOV   AX,1000H  ;carga el contador AX

LOOP2:  MOV   CX,108H    ;carga el contador CX
LOOP1:  DEC   CX        ;
	CMP   CX,0000H  ;
	JNZ   LOOP1     ;
	DEC   AX       
	CMP   AX,0000H
	JNZ   LOOP2

	INT    IMONITOR  ;retorno al monitor

PROG    ENDS
	END   START
