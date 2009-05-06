PAGE 70,166
;--------------------- PRG_PAR ----------------------
;control cíclico y temporizado de bits de puertos A/B
;y emisión de un 'beep' tras cada cambio de estado
MEM_POS    =  0800H
DS_SEG     =  0080H
IWAITMS    =  0DH    ;interrupción de espera
IBUZZER    =  10H    ;interrupción control buzzer
IPARAL     =  12H    ;interrupción control paralelo

;---------------------------------------- CODE
;programa cargado en la dirección 0000:MEM_POS
CODE    SEGMENT
	ASSUME CS:CODE, DS:CODE
	ORG  0H
START:  MOV  AX,DS_SEG
	MOV  DS,AX          ;carga data segment
	MOV  AH,00H
	MOV  AL,00H
	INT  IPARAL         ;puertos de salida
	MOV  BL,00000001B   ;data out
LOOP1:  MOV  AH,1
	MOV  AL,BL
	INT  IPARAL         ;comando puerto A
	MOV  AH,2
	MOV  AL,BL
	INT  IPARAL         ;comando puerto B
	PUSH BX
	MOV  BX	,20
	MOV  CX,10
	INT  IBUZZER        ;beep
	POP  BX
	MOV  AX,700
	INT  IWAITMS
	SHL  BL,1           ;desplaza bit a izquierda
	CMP  BL,00H
	JNZ  LOOP1
	MOV  BL,00000001B 
	JMP  LOOP1

CODE    ENDS
	END  START

