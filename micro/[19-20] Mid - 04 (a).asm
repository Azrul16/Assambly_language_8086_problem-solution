; A = B - A using only MOV, ADD, SUB, INC, DEC and NEG
DATA 	SEGMENT 
A   DW  5h 
B	DW	3h 
DATA	ENDS

CODE	SEGMENT 
ASSUME	CS:CODE,DS:DATA 
START: 
        MOV AX, DATA  ;Set DS register 
        MOV DS, AX 
 
        MOV AX, A  ;Move variable values 
        MOV BX, B
        
        SUB AX, B
        
        MOV word ptr [A], AX 
 
        MOV AX,4C00H ;Return with 
        INT 21H     ;return code zero 
CODE ENDS 
END START 