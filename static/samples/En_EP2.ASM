PAGE 70,166
;----------------------- PRG_EP2 --------------------
; display of the contents of the USER EPROM
; one byte at a time, each 1 sec.
MEM_POS    =  0800H
DS_SEG     =  0080H
IDIS_BYTE  =  09H     ;interruption vis. byte
IDIS_STR   =  0BH     ;interruption vis. string
IWAIT_MS   =  0DH     ;interruption wait ms
;---------------------------------------- CODE
;program charged in address 0000:MEM_POS
CODE    SEGMENT
	ASSUME CS:CODE, DS:CODE
	ORG  0H
START:	MOV  AX,DS_SEG
	MOV  DS,AX         ;charges data segment
	MOV  SI,OFFSET MSG
	INT  IDIS_STR      ;display message MSG
	MOV  AX,0F000H     ;segment USER EPROM
	MOV  ES,AX
	MOV  SI,0000H      ;address USER EPROM
TLOOP:  MOV  AL,ES:[SI]    ;reads data USER EPROM
	MOV  CL,12
	INT  IDIS_BYTE     ;display data
	MOV  AX,SI
	MOV  AL,AH
	MOV  CL,5
	INT  IDIS_BYTE     ;display MSB add.
	MOV  AX,SI
	MOV  CL,7
	INT  IDIS_BYTE     ;display LSB add.
	MOV  AX,1000
	INT  IWAIT_MS      ;wait
	INC  SI            ;increments address
	JMP  TLOOP

MSG      DB   'Add: xxxx - xx  ',00H

CODE    ENDS
	END  START
