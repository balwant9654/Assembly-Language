.model small

.data

var1 db '1'
var2 db ?
var3 db 'HelloWorld$'

.code
main proc
        
    mov ax,@data  ; Moves memory locations of @data into ax register(16 register)
    mov ds,ax     ; Moves data address to ds so that data segment gets initialized as heap memory to access the variables fast
    mov dl,var1   ; variable is accessed 
    
    mov ah,2
    int 21h
    
    mov var2,'2'
    mov dl,var2
    
    mov ah,2
    int 21h
    
    ;mov dx,offset var3
    lea dx,var3  ; LEA = Load Effective Address -> It's an indirect instruction used as a pointer in which first variable points the address of second variable
    
    mov ah,9
    int 21h
    
    mov ah,4ch    ; Return 
    int 21h       ; Interrupt 
    
    
main endp

end main