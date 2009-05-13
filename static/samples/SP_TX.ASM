PAGE 70,166
;----------------------- PRG_TX -----------------------
;transmisión de datos en el interfaz serie
;parámetros de TX: 1200, N, 8, 1
;espera de DSR al comienzo de la conexión
;espera de CTS tras cada byte a transmitir
MEM_POS    =  0800H
DS_SEG     =  0080H
DELAY      =  500     ;retardo en ms
IDIS_STR   =  0BH     ;interrupción visual. ristra
IWAIT_MS   =  0DH     ;interrupción gestión espera
ISERIAL    =  14H     ;interrupción gestión serie
IDA        =  0FH

;---------------------------------------- CODE
;programa cargado en la dirección 0000:MEM_POS
CODE    SEGMENT
	ASSUME CS:CODE, DS:CODE
	ORG  00H
START:  MOV  AX,DS_SEG
	MOV  AX,DS_SEG
	MOV  DS,AX             ;carga data segment
	MOV  SI,OFFSET MW_DSR
	INT  IDIS_STR          ;display message MSG
	MOV  AH,00H
	MOV  AL,01100011B
	INT  ISERIAL           ;programación serie
	MOV  AH,04H
	MOV  AL,00000001B      ;DTR activo
	INT  ISERIAL
W_DSR:  MOV  AH,03H
	INT  ISERIAL
	AND  AH,00100000B      ;check DSR
	JZ   W_DSR             ;loop if not

TLOOP:  MOV  SI,OFFSET MW_CTS
	INT  IDIS_STR          ;display message MSG
W_CTS:  MOV  AH,03H
	INT  ISERIAL
	AND  AH,00010000B      ;check CTS
	JZ   W_CTS             ;loop if not

	MOV  AH,01H
	MOV  AL,01010101B
	INT  ISERIAL           ;transmisión de dato
	MOV  SI,OFFSET MS_BYTE
	INT  IDIS_STR          ;display message MSG
	MOV  AX,2000
	INT  IWAIT_MS
	JMP  TLOOP

MW_DSR   DB   'Wait for DSR    ',00H
MW_CTS   DB   'Wait for CTS    ',00H
MS_BYTE  DB   'Byte transmitido',00H

CODE    ENDS
	END  START

