;Program to take n digit input

.model small
.data

inp dw 'Enter the number of digit you want to take input : $'

.code

main proc
    
    mov ax,@data
    mov ds,ax
    
    lea dx,inp
    mov ah,9
    int 21h
    
    mov ah,1
    int 21h
    sub al,48
    mov cl,al
    
    mov dl,10
    mov ah,2
    int 21h
    
    mov dl,13
    mov ah,2
    int 21h
    
    mov bl,10
    mov ch,1
    mov bh,0
    
Take_input:
    
    mov ah,1
    int 21h
    sub al,48
    add bh,al
    mov al,bh
    cmp cl,ch
    je outside
    mul bl
    mov bh,al
    inc ch
    jmp Take_input
    
outside: 

    mov ah,4ch
    int 21h 
    
main endp
end main