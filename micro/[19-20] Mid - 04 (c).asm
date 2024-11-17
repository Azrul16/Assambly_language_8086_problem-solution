; C = A + B using only MOV, ADD, SUB, INC, DEC and NEG

DATA 	SEGMENT 
A   DW  5h
B   DW  3h
C   DW  ? 
DATA	ENDS

CODE	SEGMENT 
ASSUME	CS:CODE,DS:DATA 
START: 
        MOV AX, DATA  ;Set DS register 
        MOV DS, AX 
 
        MOV AX, A
        ADD AX, B
        
        MOV WORD PTR [C], AX
 
        MOV AX,4C00H ;Return with 
        INT 21H     ;return code zero 
CODE ENDS 
END START 