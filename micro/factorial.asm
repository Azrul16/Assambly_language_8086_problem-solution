.model small
.stack 100h

.data
    prompt db "Enter a single-digit number (0-9): $"
    result_msg db "The factorial is: $"
    newline db 13, 10, "$"
    error_msg db "Error: Enter a valid single-digit number (0-9). $"
    factorial_result db 6 dup('$')  ; Space for factorial result (max is 5! = 120)

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Display prompt to enter a single-digit number
    mov ah, 09h
    lea dx, prompt
    int 21h

    ; Read the input number
    mov ah, 01h
    int 21h
    sub al, '0'                ; Convert ASCII to integer
    cmp al, 9                  ; Check if input is greater than 9
    ja error                   ; Jump to error if not a single-digit number
    mov bl, al                 ; Move input number to BL register (for factorial calculation)

    ; Calculate factorial
    mov ax, 1                  ; Initialize AX to 1 (starting factorial value)
    mov cl, bl                 ; Move number to CL for loop counter

factorial_loop:
    cmp cl, 1                  ; Check if CL = 1 (base case)
    je display_result          ; If CL = 1, the factorial is complete
    mul cl                     ; Multiply AX by CL (AX = AX * CL)
    dec cl                     ; Decrement CL
    jmp factorial_loop         ; Repeat loop until CL reaches 1

display_result:
    ; Display result message
    mov ah, 09h
    lea dx, result_msg
    int 21h

    ; Convert the result in AX to ASCII and store in factorial_result
    mov bx, 10                 ; Set divisor for decimal conversion
    lea di, factorial_result + 5  ; Point to the end of the output buffer
    mov cx, 0                  ; Clear CX for leading zeros

decimal_conversion:
    xor dx, dx                 ; Clear DX for division
    div bx                     ; Divide AX by 10, quotient in AX, remainder in DX
    add dl, '0'                ; Convert remainder to ASCII
    dec di                     ; Move left in the output buffer
    mov [di], dl               ; Store ASCII character
    inc cx                     ; Increment character count
    test ax, ax                ; Check if AX is zero
    jnz decimal_conversion     ; Repeat until no digits are left

    ; Display the factorial result
    mov ah, 09h
    lea dx, di                 ; Point DX to the start of the decimal result
    int 21h

    ; Newline
    mov ah, 09h
    lea dx, newline
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h

error:
    ; Display error message if input is invalid
    mov ah, 09h
    lea dx, error_msg
    int 21h

    ; Newline
    mov ah, 09h
    lea dx, newline
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h
main endp
end main
