.model small
.stack 100h

.data
    binary_prompt db "Enter an 8-bit binary number (e.g., 11010101): $"
    result_msg db "The decimal equivalent is: $"
    newline db 13, 10, "$"
    binary_input db 8 dup(?)
    decimal_output db 5 dup('$')  ; Space for decimal output (max value for 8-bit is 255)

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Prompt user for binary input
    mov ah, 09h
    lea dx, binary_prompt
    int 21h

    ; Read 8 characters (binary digits)
    lea di, binary_input
    mov cx, 8                ; We expect exactly 8 binary digits
read_loop:
    mov ah, 01h              ; Read character
    int 21h
    mov [di], al             ; Store input character in binary_input array
    inc di
    loop read_loop

    ; Initialize variables for conversion
    mov bx, 2                ; Base (binary = 2)
    mov cx, 8                ; Number of bits
    mov si, 0                ; Start from first character in binary_input
    mov ax, 0                ; Clear accumulator for final decimal value

convert_loop:
    shl ax, 1                    ; Shift AX left to make room for next bit
    mov al, [binary_input + si]  ; Get the next binary digit as ASCII
    sub al, '0'                  ; Convert ASCII '0' or '1' to binary (0 or 1)
    add ax, ax                   ; Convert AL to 16-bit and add to AX
    inc si                       ; Move to the next binary digit
    loop convert_loop

    ; AX now contains the decimal equivalent of the binary number

    ; Display result message
    mov ah, 09h
    lea dx, result_msg
    int 21h

    ; Convert AX to decimal ASCII representation
    mov bx, 10                   ; Set divisor for decimal conversion
    lea di, decimal_output + 4   ; Point to the end of the output buffer
    mov cx, 0                    ; Clear CX for leading zeros

decimal_conversion:
    xor dx, dx                   ; Clear DX for division
    div bx                       ; Divide AX by 10, quotient in AX, remainder in DX
    add dl, '0'                  ; Convert remainder to ASCII
    dec di                       ; Move left in the output buffer
    mov [di], dl                 ; Store ASCII character
    inc cx                       ; Increment character count
    test ax, ax                  ; Check if AX is zero
    jnz decimal_conversion       ; Repeat until no digits are left

    ; Display the decimal result
    mov ah, 09h
    lea dx, di                   ; Point DX to the start of the decimal result
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
