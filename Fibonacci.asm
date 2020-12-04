;Program to print fibonacci series

.model small 

.data

Input db 'Enter the length of fibonacci series you want( >2 ) : $'
 
.code

PrintString Macro string        ;Print string
    lea dx,string               ;Moving the given string to register dx 
    mov ah,09h                  ;Using service routine to print string 
    int 21h                     ;Interrupt to cpu
endm           
     
PrintInt Macro integer          ;Print Integer
    
    mov dl,integer              ;Moving the given integer to dl
    mov ah,02h                  ;using service routine to print integer value
    int 21h                     ;Interrupt
    
    mov dl,' '                  ;moving space to dl so as to seperate the values
    mov ah,02h                  ;Printing the space to output console
    int 21h
endm   

PrintNewline Macro              ;Print New line
    mov dl,0ah                  ;using service routine to print newline 
    mov ah,02h
    int 21h
    
    mov dl,0dh                  ;using service routine to get the carriage return
    mov ah,02h
    int 21h
endm 

Fibo proc
    
    mov ax,@data                ;Loading the data to ax 
    mov ds,ax                   ;Assingning address to data segment
    
    PrintString Input           ;Print the string using macro PrintString
    
    mov ah,01h                  ;Taking input from the user and saved it to al (Accumulator register)
    int 21h                     ;Interrupt used to interrupt the cpu's all processes
            
    mov cl,al                   ;counter register taking value from accumulator(al) which contains the input
    sub cl,50                   ;Subracting 2 because we are already printing two values i.e.,0 1
                                ;Calling macro PrintNewline
    PrintNewline
                                ;Moving value 0 to bl using 48 as ascii code of 0
    mov bl,48                   ;Moving 500h an address to source index(si) 
    mov si,500h
                                ;Moving value which bl contains to the given source index
    mov [si],bl
                                ;Calling macro PrintInt to print integer located on given address
    PrintInt [si]
                                ;Adding 1 to bl to get the value as 1 of fibonacci series
    add bl,1                    ;Increasing the source index by 1 to store the bl value 
    add si,01h
                                ;bl value is stored in the given address
    mov [si],bl
    
    PrintInt [si]               ;calling PrintInt to print integer value of given integer Present at the given address
    
    fibonacci:                  ;fibonacci is the label to print the fibonacci series
        
        mov bl,[si-1]           ;Moving the values present in the source address just before
        add bl,[si]             ;adding values of present source index to bl and storing in bl only
        sub bl,48               ;Subtracting 48 which is the ascii value of 0 to get the exact result after adding two values of ascii 
        
        PrintInt bl             ;PrintInt to print integer value
        
        add si,01h              ;Incrementing source index to store next value of fibonacci series
        
        mov [si],bl             ;Moving the present value of register bl to the incremented address
        
        
    Loop fibonacci              ;Looping fibonacci
    
    mov ah,4ch                  ;moving 4ch to ah register as service routing to return back
    int 21h                     ;Interrupt to cpu
    
Fibo endp                       ;Ending of the procedure

end Fibo                        ;Ending the program