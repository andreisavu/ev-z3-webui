PAGE 70,166
;--------------------- PRG_DA -----------------------
;generating a waveform with saw teeth shape in 
;output of the Digital/Analog converter
MEM_POS    =  0800H
IDA_WRITE  =  0FH     ;interruption control conv. D/A
;---------------------------------------- CODE
;program charged in address 0000:MEM_POS
CODE	SEGMENT
        ASSUME CS:CODE, DS:CODE
	ORG  0H
START:	MOV  AL,0FFH
TLOOP:	INC  AL
	INT  IDA_WRITE    ;out en D/A
   	JMP  TLOOP
CODE 	ENDS
       	END  START

