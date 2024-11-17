.MODEL SMALL 
.STACK 100H 
.DATA 
      MSG DB 'ENTER THE DECIMAL NUMBER : $'
      MSG1   DB 0DH, 0AH, 'BINARY NUMBER IS : $'
      
.CODE 

      MAIN PROC 
           MOV AX, @DATA 
           MOV DS, AX
           
           MOV AH,09H
           LEA DX,MSG 
           INT 21H 
           
           MOV AH,01H
           INT 21H
           SUB AL,48
           MOV AH,0     
           MOV BX,2 
           MOV DX,0     ;DIV 
           MOV CX,0
      AGAIN: 
           DIV BX
           PUSH DX 
           INC CX
           CMP AX,0 
           JNE AGAIN
           
           MOV AH,09H
           LEA DX,MSG1
           INT 21H
      DISP:
           POP DX
           ADD DX,48
           MOV AH,02H
           INT 21H
           LOOP DISP 
           
           MOV AH,4CH
           INT 21H
          MAIN ENDP
      END MAIN
           
           
             
           
           