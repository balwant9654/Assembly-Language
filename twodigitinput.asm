.model small 

.data

.code

main proc
    
    mov ah,1
    int 21h
    sub al,48
    mov bh,al
    
    mov ah,1
    int 21h
    sub al,48
    mov cl,al
    
    mov al,bh
    
    mov bl,10
    mul bl
    add al,cl
    mov cx,ax  
    
    mov ah,4ch 
    int 21h
        
main endp
end main