PAGE 70,166
;------------------ PRG_KB ------------------------
;lectura de una tecla desde el teclado
;y visualización del código en el display
PAGE 70,166
MEM_POS    =  0800H
DS_SEG     =  0080H
IKEYBOARD  =  08H     ;interrupción lectura teclado
IDIS_BYTE  =  09H     ;interrupción visual. byte
IDIS_STR   =  0BH     ;interrupción visual. ristra

;---------------------------------------- CODE
;programa cargado en la dirección 0000:MEM_POS
CODE	SEGMENT
	ASSUME CS:CODE, DS:CODE
	ORG    0H
START:  MOV  AX,DS_SEG
	MOV  DS,AX      ;carga data segment
	MOV  SI,OFFSET MSG
	INT  IDIS_STR   ;display message MSG
TLOOP:  INT  IKEYBOARD  ;lee teclado
	MOV  CL,13
	INT  IDIS_BYTE  ;visualiza código tecla
	JMP  TLOOP

MSG     DB 'KB, hex key: xx ',00H

CODE    ENDS
	END  START
