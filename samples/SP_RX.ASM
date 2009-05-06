PAGE 70,166
;------------------------- PRG_RX -----------------------
;recepción de datos del interfaz serie
;parámetros de RX: 1200, N, 8, 1
;habilita  DTR al comienzo de la conexión
;habilita  RTS tras cada byte a recibir
MEM_POS    =  0800H
DS_SEG     =  0080H
DELAY      =  500     ;retardo en ms
IDIS_BYTE  =  09H     ;interrupción vis. byte
IDIS_STR   =  0BH     ;interrupción visual.  ristra
IWAIT_MS   =  0DH     ;interrupción gestión  espera
ISERIAL    =  14H     ;interrupción gestión  serie
IDA        =  0FH

;---------------------------------------- CODE
;programa cargado en la dirección 0000:MEM_POS
CODE     SEGMENT
         ASSUME CS:CODE, DS:CODE
         ORG  00H
START:   MOV  AX,DS_SEG
         MOV  AX,DS_SEG
         MOV  DS,AX             ;carga data segment
         MOV  AH,00H
         MOV  AL,00000011B
         INT  ISERIAL           ;programación serie
         MOV  AH,04H
         MOV  AL,00000001B      ;DTR activo
         INT  ISERIAL

         MOV  SI,OFFSET MW_DSR
         INT  IDIS_STR          ; display message MSG
W_DSR:   MOV  AH,03H
         INT  ISERIAL
         AND  AH,00100000B      ;check DSR
         JZ   W_DSR             ;loop if not

         MOV  BX,0000H          ;contador
         MOV  SI,OFFSET M_BYTE
         INT  IDIS_STR          ;display message 

TLOOP:   MOV  AH,04H
         MOV  AL,00000011B      ;DTR=ON, RTS=ON
         INT  ISERIAL
         MOV  AH,02H
         INT  ISERIAL           ;lee dato
         PUSH AX
         MOV  AH,04H
         MOV  AL,00000011B      ;DTR=OFF, RTS=ON

         POP  AX
         MOV  CL,14
         PUSH AX
         INT  IDIS_BYTE         ;visualizza dato
         CALL CONV_HEX
         
         POP  AX
         MOV  CL,10
         INT  0AH
         MOV  CL,4
         INT  IDIS_BYTE       ; display MSB dirección
         MOV  AL,BL
         MOV  CL,6
         INT  IDIS_BYTE       ; display LSB dirección

         INC  BX
         MOV  AX,200
         INT  IWAIT_MS
	   JMP  TLOOP

CONV_HEX PROC  NEAR        
         AND   AL,0FH		;
         CMP   AL,10		;
         JNC   CONV_WH1		;
         ADD   AL,30H		;0-9
         JMP   CONV_WH2		;
CONV_WH1: ADD  AL,55		;A-F
CONV_WH2: RET
CONV_HEX  ENDP

MW_DSR   DB   'Wait for DSR    ',00H
M_BYTE   DB   'Num.xxxx ax H.xx',00H

CODE     ENDS
         END  START
