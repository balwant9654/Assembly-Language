.model small

.data
Quo dw ?
Rem dw ?
.code

main proc
                                            ; DX:AX     AX-Quotient DX-Remainder
    mov ax,27                               ; AX        AL-Quotient AH-Remainder
    mov bx,5
    mov dx,0
    
    div bx
    
    mov Quo,ax
    mov Rem,dx
    
    mov dx,Quo
    add dx,48
    mov ah,2
    int 21h
    
    mov dx,Rem
    add dx,48
    mov ah,2
    int 21h
    
    mov ah,4ch 
    int 21h
main endp
end main