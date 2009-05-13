PAGE 70,166
;----------------------- PRG_KB --------------------
;reading of a key from the keyboard
;and display of the code on the display
;
MEM_POS    =  0800H
DS_SEG     =  0080H
IKEYBOARD  =  08H     ;interruption reading keyboard
IDIS_BYTE  =  09H     ;interruption visual. byte
IDIS_STR   =  0BH     ;interruption visual. string

;---------------------------------------- CODE
;program charged in address 0000:MEM_POS
CODE	SEGMENT
	ASSUME CS:CODE, DS:CODE
	ORG    0H
START:  MOV  AX,DS_SEG
	MOV  DS,AX      	;charges data segment
	MOV  SI,OFFSET MSG
	INT  IDIS_STR   	;display message MSG
TLOOP:  INT  IKEYBOARD  	;reads keyboard
	MOV  CL,13
	INT  IDIS_BYTE  	;display key code
	JMP  TLOOP

MSG     DB 'KB, hex key: xx ',00H

CODE    ENDS
	END  START
