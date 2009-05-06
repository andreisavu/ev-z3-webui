PAGE 70,166
;----------------------- PRG_RAM --------------------
;escribe el código AA en cada celda de memoria RAM
;M1L y M1H, luego lee las celdas y visualiza el dato
;leído en el display, cada 1 s
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
START:  MOV  AX,DS_SEG
	MOV  DS,AX          ;carga data segment
	MOV  SI,OFFSET MSG
	INT  IDIS_STR       ;display message MSG
	MOV  AX,0400H       ;segmento RAM   
	MOV  ES,AX
	MOV  SI,0000H       ;dirección RAM
TLOOP:  MOV  AL,0AAH
	MOV  ES:[SI],AL     ;escribe dato en RAM
	MOV  AL,ES:[SI]     ;lee dato desde RAM
	MOV  CL,12
	INT  IDIS_BYTE      ;visualiza dato
	MOV  AX,SI
	MOV  AL,AH
	MOV  CL,5
	INT  IDIS_BYTE      ;visualiza MSB ind.
	MOV  AX,SI
	MOV  CL,7
	INT  IDIS_BYTE      ;visualiza LSB ind.
	MOV  AX,1000
	INT  IWAIT_MS       ;espera
	INC  SI             ;incrementa dirección
	JMP  TLOOP

MSG  DB  'RAM: xxxx - xx  ',00H

CODE    ENDS
	END  START

