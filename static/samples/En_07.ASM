PAGE 70,166
;----------------------------- PRG_07 --------------------
;this program sums two words present in memory, 
;of value 0120H, 0240H, and puts the result in a third
;word in the memory (it is suppose that the result
;does not exceed 16 bit)
IMONITOR = 07H
DS_SEG   = 0080H

;---------------------------------------- DATA
DATA     xxxxxxxxxxxx
DATA_1   xxxxxxxxxxxx
DATA_2   xxxxxxxxxxxx
SOMMA	 DW	0H
xxxxxxxx ENDS

;---------------------------------------- CODE
;the program is charged  to the address 0000:0810H
PROG     SEGMENT
         ASSUME xxxxxxxxxxxxxxxxxxx

START:   MOV    AX,xxxxx   ;
         MOV    DS,AX	   ;load DS with data segment
         MOV    xx,DATA_1  ;load the first data
         MOV    BX,DATA_2  ;load the second data
         ADD    AX,BX      ;sums
         MOV    SUMA,AX
         INT    IMONITOR   ;returns to the monitor

PROG     ENDS
         END    START
