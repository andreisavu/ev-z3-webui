PAGE 70,166
;----------------------- PRG_TX -----------------------
; data transmission on the serial interface
;parameters TX: 1200, N, 8, 1
;waiting of DSR at the beginning of the connection
; waiting of CTS at each byte to transmit
MEM_POS    =  0800H
DS_SEG     =  0080H
DELAY      =  500     ; retard in ms
IDIS_STR   =  0BH     ; visual interruption.  stringe
IWAIT_MS   =  0DH     ; management interruption waiting
ISERIAL    =  14H     ; management interruption serial
IDA        =  0FH

;---------------------------------------- CODE
;program charged in address 0000:MEM_POS
CODE    SEGMENT
        ASSUME CS:CODE, DS:CODE
	ORG  00H
START:  MOV  AX,DS_SEG
	MOV  AX,DS_SEG
	MOV  DS,AX             ;load data segment
	MOV  SI,OFFSET MW_DSR
	INT  IDIS_STR          ;display message MSG
	MOV  AH,00H
	MOV  AL,01100011B
	INT  ISERIAL           ;serial programing
	MOV  AH,04H
	MOV  AL,00000001B      ;DTR active
	INT  ISERIAL
W_DSR:  MOV  AH,03H
	INT  ISERIAL
	AND  AH,00100000B      ;check DSR
	JZ   W_DSR             ;loop if not

TLOOP:	MOV  SI,OFFSET MW_CTS
	INT  IDIS_STR          ;display message MSG
W_CTS:  MOV  AH,03H
	INT  ISERIAL
	AND  AH,00010000B      ;check CTS
	JZ   W_CTS             ;loop if not

	MOV  AH,01H
	MOV  AL,01010101B
	INT  ISERIAL           ;transmission data
	MOV  SI,OFFSET MS_BYTE
 	INT  IDIS_STR          ;display message MSG
	MOV  AX,2000
	INT  IWAIT_MS
	JMP  TLOOP

MW_DSR   DB   'Wait for DSR    ',00H
MW_CTS   DB   'Wait for CTS    ',00H
MS_BYTE  DB   'Byte transmitted',00H

CODE    ENDS
	END  START
