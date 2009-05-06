PAGE 70,166
;----------------------- PRG_EP2 --------------------
;visualización del contenido de la USER EPROM
;un byte a la vez, cada 1 s
MEM_POS    =  0800H
DS_SEG     =  0080H
IDIS_BYTE  =  09H     ;interrupción vis. byte
IDIS_STR   =  0BH     ;interrupción vis. ristra
IWAIT_MS   =  0DH     ;interrupción espera ms
;---------------------------------------- CODE
;programa cargado en la dirección 0000:MEM_POS
CODE    SEGMENT
	ASSUME CS:CODE, DS:CODE
	ORG  0H
START:	MOV  AX,DS_SEG
	MOV  DS,AX         ;carga data segment
	MOV  SI,OFFSET MSG
	INT  IDIS_STR      ;display message MSG
	MOV  AX,0F000H     ;segmento USER EPROM
	MOV  ES,AX
	MOV  SI,0000H      ;dirección USER EPROM
TLOOP:  MOV  AL,ES:[SI]    ;lee dato USER EPROM
	MOV  CL,12
	INT  IDIS_BYTE     ;visualiza dato
	MOV  AX,SI
	MOV  AL,AH
	MOV  CL,5
	INT  IDIS_BYTE     ;visualiza MSB dirección
	MOV  AX,SI
	MOV  CL,7
	INT  IDIS_BYTE     ;visualiza LSB dirección
	MOV  AX,1000
	INT  IWAIT_MS      ;espera
	INC  SI            ;incrementa dirección
	JMP  TLOOP

MSG      DB   'Add: xxxx - xx  ',00H

CODE    ENDS
	END  START
