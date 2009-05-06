PAGE 70,166
;--------------------- PRG_PAR ----------------------
; cyclic timed command of the bits of the Ports A/B
; and generation of a 'beep' at each change of state
MEM_POS    =  0800H
DS_SEG     =  0080H
IWAITMS    =  0DH    ;wait interruption 
IBUZZER    =  10H    ;interruption buzzer command 
IPARAL     =  12H    ;interruption parallel control 
IKEYBOARD  =  08H 
;---------------------------------------- CODE
;program charged in address 0000:MEM_POS
CODE    SEGMENT
	ASSUME CS:CODE, DS:CODE
	ORG  0H
START:  MOV  AX,DS_SEG
	MOV  DS,AX          ;charges data segment
	MOV  AH,00H
	MOV  AL,00H
	INT  IPARAL         ;ports in Output
	MOV  BL,00000001B   ;data out
LOOP1:  IMT IKEYBOARD
        MOV  AH,1
	MOV  AL,BL
	INT  IPARAL         ;command port A
	MOV  AH,2
	MOV  AL,BL
	INT  IPARAL         ;command port B
	PUSH BX
	MOV  BX	,20
	MOV  CX,10
	INT  IBUZZER        ;beep
	POP  BX
	MOV  AX,BX
	INT  IWAITMS
	SHL  BL,1           ;shifts bit to left
	CMP BL, 00H
	JNZ  LOOP1
	MOV  BL,00000001B 
	JMP  LOOP1

CODE    ENDS
	END  START
