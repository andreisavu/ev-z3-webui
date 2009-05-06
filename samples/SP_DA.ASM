PAGE 70,166
2              ;--------------------- PRG_DA -----------------------
 3              ;generación de una forma de onda en diente de sierra
 4              ;en la salida del convertidor Digital/Analógico
 5 = 0800       MEM_POS    =  0800H
 6 = 000F       IDA_WRITE  =  0FH     ;interrupción gestión conv. D/A
 7
 8              ;---------------------------------------- CODE
 9              ;programa cargado en la dirección 0000:MEM_POS
10 0000         CODE     SEGMENT
11                       ASSUME CS:CODE, DS:CODE
12 0000                  ORG  0H
13 0000  B0 FF  START:   MOV  AL,0FFH
14 0002  FE C0  TLOOP:   INC  AL
15 0004  CD 0F           INT  IDA_WRITE    ;out en D/A
16 0006  EB FA           JMP  TLOOP
17 0008         CODE     ENDS
18                       END  START

