.model small 

.data
array db 26 Dup(?)
.code

main proc
  
  mov ax,@data
  mov ds,ax
  mov cx,26
  mov si,offset array
  mov bx,65
  
  L1:
    ;mov dx,[si]
    mov [si],bx 
    inc si
    inc bx
    
  Loop L1
        
  mov si,offset array
  mov cx,26
  
  L2:
    mov dx,[si]
    mov ah,2
    int 21h
    inc si
  
  Loop L2
  
  mov ah,4ch
  int 21h
  
    
main endp
end main