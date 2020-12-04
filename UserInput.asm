.model small 

.data

.code

main proc
    
    mov bl,3
    mov cl,1
    
    sub bl,cl
    
    add bl,48
    
    mov dl,bl
    
    mov ah,2
    int 21h
    
    
main endp
end main