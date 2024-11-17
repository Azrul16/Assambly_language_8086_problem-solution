.model small
.stack 100h
.data
    message db 'Hello, World!$', 0 ; The message to print, terminated with '$'

.code
main proc
    ; Set up the data segment
    mov ax, @data       ; Load the address of the data segment
    mov ds, ax          ; Initialize DS with the data segment

    ; Point to the start of the message
    lea dx, message     ; Load the address of the message into DX
    mov ah, 09h         ; DOS function to display string
    int 21h             ; Call DOS interrupt to print string

    ; Exit the program
    mov ah, 4Ch         ; DOS interrupt to terminate program
    int 21h             ; Call interrupt to exit

main endp
end main

    
    
    




