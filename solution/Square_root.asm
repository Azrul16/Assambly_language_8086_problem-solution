.MODEL SMALL
.STACK 100H 
.DATA
  
  MSG DB 0AH, 0DH,"ENTER A NUMBER: $"
  OUT1 DB 0AH, 0DH, "SQUARE OF $"
  OUT2 DB " IS $"
  QUIT DB 0AH, 0DH, "CONTINUE? Y FOR YES ELSE FOR NO: $"
.CODE 

    MAIN:
        MOV AX,@DATA
        MOV DS,AX
    AGAIN:
        LEA DX,MSG
        MOV AH,09H
        INT 21H
        
        MOV AH,01H
        INT 21H
        
        PUSH AX
        
        CMP AL,39H
        JG AGAIN
        CMP AL,30H
        JL AGAIN
        PUSH AX
        SUB AL,30H
        MOV BL,AL
        MUL BL
        AAM
        
        MOV BX,AX
        
        LEA DX,OUT1
        MOV AH,09H
        INT 21H
        
        POP DX
        MOV AH,02H
        INT 21H
        
        LEA DX,OUT2
        MOV AH,09H
        INT 21H
        
        MOV DL,BH
        ADD DL,30H
        MOV AH,02H
        INT 21H
        
        MOV DL,BL
        ADD DL,30H
        MOV AH,02H
        INT 21H
        
        LEA DX,QUIT
        MOV AH,09H
        INT 21H
        
        MOV AH,01H
        INT 21H
        OR AL, 20H
        CMP AL,'y'
        JE AGAIN
        
        MOV AH,04CH
        INT 21H
    END MAIN
        
        




