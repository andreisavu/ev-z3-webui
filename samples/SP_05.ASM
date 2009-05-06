PAGE 70,166
;----------------------------- PRG_05 -------------------------
;este programa suma dos bytes presentes en N.2 posiciones 
;de memoria diferentes y pone el resultado en una tercera
;posición de memoria de 1 byte (se supone que el resultado
;no supere el número 255)
IMONITOR   =  07H
DS_SEG     =  0080H
;---------------------------------------- CODE
;el programa se carga en la dirección 0080:0000H
PROG     SEGMENT
         ASSUME CS:PROG, DS:PROG

START:   MOV    AX,DS_SEG  ;carga el registro DS
         MOV    DS,AX
         MOV    AL,DATA_1  ;carga en AL el primer dato
         MOV    BL,DATA_2  ;carga en BL el segundo dato
         ADD    AL,BL      ;suma
         MOV    SUMA,AL
         INT    IMONITOR   ;retorno al monitor

         ;------------------------- datos
DATA_1   DB     04H        ;primer  dato (03H)
DATA_2   DB     12H        ;segundo dato (12H)
SUMA     DB     00000000B  ;resultado

PROG     ENDS
         END    START
