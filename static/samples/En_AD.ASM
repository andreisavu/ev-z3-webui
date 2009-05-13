PAGE 70,166
;------------------------ PRG_AD ----------------------
;reading from the Analog/Digital converter
;and displays the result result
MEM_POS    =  0800H
DS_SEG     =  0080H
IAD_READ   =  0EH     ;interruption reading conv. A/D
IDIS_BYTE  =  09H     ;interruption visual. byte
IDIS_STR   =  0BH     ;interruption visual. stringe
IWAIT_MS   =  0DH     ;interruption wait
;---------------------------------------- CODE
;program charged in address 0000:MEM_POS
CODE	SEGMENT
	ASSUME CS:CODE, DS:CODE
	ORG  0H
START:	MOV  AX,DS_SEG
	MOV  DS,AX          ;carga data segment
	MOV  SI,OFFSET MSG
	INT  IDIS_STR       ;display message MSG
TLOOP:  INT  IAD_READ       ;lee A/D
	MOV  CL,13
	INT  IDIS_BYTE      ;visualiza código tecla
	MOV  AX,200
	INT  IWAIT_MS
	JMP  TLOOP

MSG     DB   ' A/D value : xx ',00H

CODE    ENDS
	END  START
