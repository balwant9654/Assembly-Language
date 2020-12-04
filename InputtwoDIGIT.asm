.model small 

.data

.code

main proc

    mov ah,1
    int 21h
    add al,48
    mov dl,al
    
    mov ah,1
    int 21h
    add al,48 
    aaa
    
    add dl,al
    sub dl,48
    mov ah,2
    int 21h    
main endp
end main