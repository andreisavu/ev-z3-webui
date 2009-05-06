PAGE 70,166
;-------------------------- PRG_CALL ---------------
;emite 3 beeps desde el buzzer, en intervalos
;de tiempo fijos.
;Se utiliza un procedimiento, llamada 2 veces, 
;para obtener los intervalos de tiempo.
IMONITOR = 07H
IBUZZER  = 10H
IPARAL   = 12H

;---------------------------------------- CODE
;programa cargado en la dirección 0000:0800H

PROG    SEGMENT
	ASSUME CS:PROG, DS:PROG

START:	MOV  AH,00H
        MOV  AL,00H
        INT  IPARAL     ;puertos de Salida
	MOV  BX,200     ;duración beep
	MOV  CX,20      ;frecuencia beep
	INT  IBUZZER    ;--------------- BEEP1
	CALL ATT        ;espera
	MOV  BX,200     ;
	MOV  CX,20      ;
	INT  IBUZZER    ;--------------- BEEP2
	CALL ATT        ;espera
	MOV  BX,200     ;
	MOV  CX,20      ;
	INT  IBUZZER    ;--------------- BEEP3

	INT  IMONITOR   ;retorno al Monitor

;procedimiento de espera
ATT     PROC NEAR
        PUSH AX         ;guarda los registros usados
	PUSH CX
	MOV  AX,1000    ;carga el contador AX
LOOP2:  MOV  CX,100     ;carga el contador CX
LOOP1:  DEC  CX         ;loop 
	CMP  CX,0000H   ;
	JNZ  LOOP1      ;
	DEC  AX
	CMP  AX,0000H
	JNZ  LOOP2
	POP  CX         ;restablece los registros
	POP  AX
	RET
ATT     ENDP
PROG    ENDS
	END  START
