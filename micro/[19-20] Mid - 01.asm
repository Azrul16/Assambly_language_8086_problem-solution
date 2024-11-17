; Write a progratn to 
; (a) display a "?. 
; (b) lead two decimal digits whose sum is less than 10
; (c) display them and their sutu on the next line, with an appropriate message. 
; Sample execution:
; ?27
; THE SUM OF 2 AND 7 IS 9

.MODEL SMALL 

.DATA
MSG DB 0AH,0DH,'THE SUM OF '
C1 DB ?,' AND '
C2 DB ?,' IS '
SUM DB ?,'$'

.CODE
MAIN PROC
    mov ax,@data
    mov ds,ax
    
    ;DISPLAY ?
    MOV AH, 2
    MOV DL, '?'
    INT 21H
    
    ;READ THE FIRST DIGIT
    MOV AH, 1
    INT 21H
    
    ;STORE IN MEMORY
    MOV C1, AL
    
    ;READ THE SECOND DIGIT
    MOV AH, 1
    INT 21H
    
    ;STORE IN MEMORY
    MOV C2, AL  
    
    ;ADD THE TWO NUMBERS
    ADD AL, C1
    
    ;CONVERT DIGIT TO STRING
    SUB AL, 30H
    
    ;STORE RESULT
    MOV SUM, AL
               
    ;GET MESSAGE START ADDRESS            
    LEA DX, MSG
    MOV AH, 9
    INT 21H
   
    ;RETURN TO DOS
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN
