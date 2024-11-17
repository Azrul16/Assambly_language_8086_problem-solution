.model small
.stack 100h
.data
    num1 dw 1234h
    num2 dw 5678h
    result dw 0
    msg_result db 'Result of addition: ', '$'
    newline db 13, 10, '$'
    buffer db 6 dup('$')

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ax, num1
    add ax, num2
    mov result, ax

    lea dx, msg_result
    mov ah, 09h
    int 21h

    mov ax, result
    call display_number
    call newline_func

    mov ah, 4Ch
    int 21h
main endp

display_number proc
    push ax
    push bx
    push dx

    mov bx, 16
    lea di, buffer+4

convert_loop:
    xor dx, dx
    div bx
    add dl, '0'
    cmp dl, '9'
    jbe store_digit
    add dl, 7

store_digit:
    mov [di], dl
    dec di
    test ax, ax
    jnz convert_loop

    lea dx, di+1
    mov ah, 09h
    int 21h

    pop dx
    pop bx
    pop ax
    ret
display_number endp

newline_func proc
    mov ah, 09h
    lea dx, newline
    int 21h
    ret
newline_func endp

end main
