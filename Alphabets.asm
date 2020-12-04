.model small

.data
.code

main proc
    
    mov cx,26
    mov dx,65
    mov bx,dx
    
    Alphabets_NewLine:
    
        
        mov ah,2
        int 21h 
        
        mov dx,10
        mov ah,2
        int 21h
        
        mov dx,13
        mov ah,2
        int 21h
        
        inc bx 
        mov dx,bx 
        
    Loop Alphabets_NewLine
    
    mov dx,65
    mov cx,26
    Alphabets:
        mov ah,2
        int 21h
        
        inc dx
        
    Loop Alphabets  
    
    mov ah,4ch
    int 21h
    
main endp
end main