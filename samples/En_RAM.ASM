PAGE 70,166
;----------------------- PRG_RAM --------------------
;writes code AA in each cell of the memories RAM
;M1L and M1H,then reads the cells and visualizes
;the data read on the display, each 1 sec.
MEM_POS    =  0800H
DS_SEG     =  0080H
IDIS_BYTE  =  09H     ;interruption vis. byte
IDIS_STR   =  0BH     ;interruption vis. stringe
IWAIT_MS   =  0DH     ;interruption wait ms
;---------------------------------------- CODE
;program charged at address 0000:MEM_POS
CODE    SEGMENT
	ASSUME CS:CODE, DS:CODE
	ORG  0H
START:  MOV  AX,DS_SEG
	MOV  DS,AX          ;charges data segment
	MOV  SI,OFFSET MSG
	INT  IDIS_STR       ;display message MSG
	MOV  AX,0400H       ;segment RAM   
	MOV  ES,AX
	MOV  SI,0000H       ;address RAM
TLOOP:  MOV  AL,0AAH
	MOV  ES:[SI],AL     ;writes data in RAM
	MOV  AL,ES:[SI]     ;reads data from RAM
	MOV  CL,12
	INT  IDIS_BYTE      ;display data
	MOV  AX,SI
	MOV  AL,AH
	MOV  CL,5
	INT  IDIS_BYTE      ;display MSB add.
	MOV  AX,SI
	MOV  CL,7
	INT  IDIS_BYTE      ;display LSB add.
	MOV  AX,1000
	INT  IWAIT_MS       ;wait
	INC  SI             ;increments address
	JMP  TLOOP

MSG  DB  'RAM: xxxx - xx  ',00H

CODE    ENDS
	END  START
