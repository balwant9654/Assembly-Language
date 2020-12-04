
; Program to print values from 1 to 10

.model small 

.data

.code
main proc
    
    mov cl,10
    mov dl,48
    
    count:
        mov ah,2
        int 21h
        
        inc dl
        
    Loop count
    
    mov ah,4ch
    int 21h
        
main endp

end main