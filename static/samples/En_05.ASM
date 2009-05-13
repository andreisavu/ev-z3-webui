PAGE 70,166
;----------------------------- PRG_05 ----------------
;this program sums two byte present in N.2 different 
;memory locations and puts the result in a third
;memory site of 1 byte (supposing that the 
;result does not exceed number 255)

IMONITOR = 07H
DS_SEG   = 0080H
;---------------------------------------- CODE
;the program is charged to the address 0080:0000H
PROG     SEGMENT
         ASSUME CS:PROG, DS:PROG

START:   MOV    AX,DS_SEG  ;load el registro DS
         MOV    DS,AX
         MOV    AL,DATA_1  ;load in AL the first data
         MOV    BL,DATA_2  ;load in BL the second data
         ADD    AL,BL      ;sums
         MOV    SUMA,AL
         INT    IMONITOR   ;returns to the monitor

         ;------------------------- datos
DATA_1   DB     04H        ;first  data (04H)
DATA_2   DB     12H        ;second data (12H)
SUMA     DB     00000000B  ;result

PROG     ENDS
         END    START
