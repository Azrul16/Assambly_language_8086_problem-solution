; Decimal to Binary Conversion
; Assumes input decimal number is a single-digit number

.model small
.stack 100h

.data
    prompt db "Enter a decimal digit: $"
    result db "The binary equivalent is: $"
    newline db 13, 10, "$"
    binary_output db 8 dup('0'), '$' ; Space for binary output (8 bits), terminated with $

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Display prompt
    mov ah, 09h
    lea dx, prompt
    int 21h

    ; Read decimal digit (input as ASCII)
    mov ah, 01h
    int 21h
    sub al, 30h       ; Convert ASCII to decimal

    ; Convert decimal to binary and store in binary_output
    mov cx, 8             ; We want 8 bits for the binary output
    lea di, binary_output ; Point DI to the start of binary_output buffer + 7 (for 8 bits in reverse order)
    add di, 7             ; Start storing from the last position (rightmost bit)
    
convert_loop:
    mov bl, al            ; Copy the decimal value into BL
    and bl, 1             ; Isolate the least significant bit (either 0 or 1)
    add bl, '0'           ; Convert bit to ASCII ('0' or '1')
    mov [di], bl          ; Store the ASCII character in the buffer at the current position
    dec di                ; Move to the next position (leftward in binary_output)
    shr al, 1             ; Shift the decimal number right by 1 to get the next bit
    loop convert_loop     ; Repeat for all 8 bits

    ; Display result message
    mov ah, 09h
    lea dx, result
    int 21h

    ; Display the binary equivalent
    mov ah, 09h
    lea dx, binary_output
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
