PAGE 70,166
;------------------------- PRG_RX -----------------------
;ricezione dati dalla interfaccia seriale
;parametri di RX: 1200, N, 8, 1
;abilita  DTR all'inizio del collegamento
;abilita  RTS ad ogni byte da ricevere
MEM_POS    =  0800H
DS_SEG     =  0080H
DELAY      =  500     ; ms delay
IDIS_BYTE  =  09H     ; interruption vis. byte 
IDIS_STR   =  0BH     ; interruption visual.  string
IWAIT_MS   =  0DH     ; interruption management wait 
ISERIAL    =  14H     ; interruption management serial
IDA        =  0FH

;---------------------------------------- CODE
; program charged in address 0000:MEM_POS
CODE     SEGMENT
         ASSUME CS:CODE, DS:CODE
         ORG  00H
START:   MOV  AX,DS_SEG
         MOV  AX,DS_SEG
         MOV  DS,AX             ; load data segment 
         MOV  AH,00H
         MOV  AL,00000011B
         INT  ISERIAL           ;programing serial
         MOV  AH,04H
         MOV  AL,00000001B      ;DTR active
         INT  ISERIAL

         MOV  SI,OFFSET MW_DSR
         INT  IDIS_STR          ; display message MSG
W_DSR:   MOV  AH,03H
         INT  ISERIAL
         AND  AH,00100000B      ;check DSR
         JZ   W_DSR             ;loop if not

         MOV  BX,0000H          ;counter
         MOV  SI,OFFSET M_BYTE
         INT  IDIS_STR          ;display message 

TLOOP:	 MOV  AH,04H
         MOV  AL,00000011B      ;DTR=ON, RTS=ON
         INT  ISERIAL
         MOV  AH,02H
         INT  ISERIAL           ; reads data
         PUSH AX
         MOV  AH,04H
         MOV  AL,00000011B      ;DTR=OFF, RTS=ON

         POP  AX
         MOV  CL,14
         PUSH AX
         INT  IDIS_BYTE         ; DISPLAY dato
         CALL CONV_HEX
         
         POP  AX
         MOV  CL,10
         INT  0AH
         MOV  CL,4
         INT  IDIS_BYTE       ; display MSB address
         MOV  AL,BL
         MOV  CL,6
         INT  IDIS_BYTE       ; display LSB address


         INC  BX
         MOV  AX,200
         INT  IWAIT_MS
	 JMP	TLOOP

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
