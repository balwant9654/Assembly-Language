
.model small 
.stack 100h
.data
.code

ballu proc
    
     mov cx,10
     mov bx,1 
     
     L1:
     
        push cx
     
        mov cx,bx
     
        L2:
     
            mov dx,'*'
            mov ah,2
            int 21h 
     
            mov dx,' '
            mov ah,2
            int 21h
     
        Loop L2 
     
        mov dx,10
        mov ah,2
        int 21h
     
        mov dx,13
        mov ah,2
        int 21h
        inc bx
        
        pop cx 
     
     Loop L1
     
     mov ah,4ch
     int 21h
    

ballu endp

end ballu