PAGE 70,166
;----------------------------- PRG_07 -------------------------
;este programa suma dos palabras presentes en la memoria 
;de valor 0120H y 0241H y pone el resultado en una tercera
;palabra de memoria (se supone que el resultado
;no supere los 16 bits)
IMONITOR = 07H
DS_SEG   = 0080H

;---------------------------------------- DATA
DATA     xxxxxxxxxxxx
DATA_1   xxxxxxxxxxxx
DATA_2   xxxxxxxxxxxx
SOMMA	 DW	0H
xxxxxxxx ENDS

;---------------------------------------- CODE
;el programa se carga en la dirección 0000:0810H
PROG     SEGMENT
         ASSUME xxxxxxxxxxxxxxxxxxx

START:   MOV    AX,xxxxx   ;
         MOV    DS,AX	   ;carga DS con segmento de datos
         MOV    xx,DATA_1  ;carga el primer dato
         MOV    BX,DATA_2  ;carga el segundo dato
         ADD    AX,BX      ;suma
         MOV    SUMA,AX
         INT    IMONITOR   ;retorno al monitor

PROG     ENDS
         END    START
