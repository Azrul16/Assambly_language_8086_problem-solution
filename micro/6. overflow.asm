.model small
.stack 100h

.data
    initialAX dw 2143h              ; Initial value in AX
    initialBX dw 1986h              ; Initial value in BX
    no_overflow_msg db "No overflow occurred.$"
    unsigned_overflow_msg db "Unsigned overflow occurred.$"
    signed_overflow_msg db "Signed overflow occurred.$"
    newline db 13, 10, "$"

.code
main proc
    mov ax, @data                   ; Initialize data segment
    mov ds, ax

    ; Load initial values into AX and BX
    mov ax, initialAX               ; AX = 2143h
    mov bx, initialBX               ; BX = 1986h

    ; Perform AX = AX - BX
    sub ax, bx

    ; Check for unsigned overflow (carry flag)
    jc unsigned_overflow

    ; Check for signed overflow (overflow flag)
    jo signed_overflow

no_overflow:
    ; No overflow occurred
    mov ah, 09h
    lea dx, no_overflow_msg
    int 21h
    jmp print_newline

unsigned_overflow:
    ; Unsigned overflow occurred
    mov ah, 09h
    lea dx, unsigned_overflow_msg
    int 21h
    jmp print_newline

signed_overflow:
    ; Signed overflow occurred
    mov ah, 09h
    lea dx, signed_overflow_msg
    int 21h

print_newline:
    ; Print a newline
    mov ah, 09h
    lea dx, newline
    int 21h

    ; Exit the program
    mov ah, 4Ch
    int 21h

main endp
end main
