;Program to print hello world

.model small

.data

hw db 'Hello World$'        ;Initialising variable hw with the string "Hello World" and is terminated with $ symbol to 
                            ;let the system know where the string ends
.code

main proc
                             
    mov ax,@data             ;Initialising ax register with data address
    mov ds,ax                ;Initializing data segment to directly access the variable
    
    mov dx,offset hw         ;moving the string to data register
    
    mov ah,9                 ;using service routine to print the string on the output console
    int 21h                  ;Interrupting the cpu 
    
    mov ah,4ch               ;Returning the control back to operating system
    int 21h
    
main endp
end main