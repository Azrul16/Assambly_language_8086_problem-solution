; A = B - A using only MOV, ADD, SUB, INC, DEC and NEG

DATA 	SEGMENT 
A   DW  5h 
DATA	ENDS

CODE	SEGMENT 
ASSUME	CS:CODE,DS:DATA 
START: 
        MOV AX, DATA  ;Set DS register 
        MOV DS, AX 
 
        MOV AX, A
        
        INC AX
        
        NEG AX 
        
        MOV WORD PTR [A], AX
 
        MOV AX,4C00H ;Return with 
        INT 21H     ;return code zero 
CODE ENDS 
END START 