;Program to implement x = y + 4 

.model small 

.data

inp  db  0ah,0dh,'Enter the value of y  : $'                ;Giving input the value of y
exp  db  0ah,0dh,'Result of the expression  :: x = y + 4$'  ;using value of y and the expression x=y+4 ,x is calculated
vx   db  0ah,0dh,'Value of x = $'                           ;result i.e.,x value is shown with this variable

.code

PrintString Macro string                                    ;Macro declared to print String on the output screen  
    mov ah,9 
    int 21h
endm

main proc
    
    mov ax,@data                                            ;Loading data
    mov ds,ax 
    
    lea dx,inp                                              ;initializing the dx register with the string address
    PrintString dx                                          ;Calling macro to print the string contained in variable inp
    
    mov ah,1                                                ;Ask for user input i.e., the value of y
    int 21h
    
    mov bl,al                                               ;The input value is stored in bl register 
    add bl,'4'                                              ;4 is added to y value according to expression
    sub bl,48                                               ;ascii to integer
    
    lea dx,exp                                              ;initialising the dx register with the string address 
    PrintString dx                                          ;Calling macro to print the string contained in variable exp
     
    lea dx,vx                                               ;Again initialising dx with variable address of vx
    PrintString dx                                          ;And printing the string present in vx
      
    mov dl,bl                                               ;moving the resultant value to data register
    mov ah,2                                                ;using service routine value is printed on the screen
    int 21h
    
main endp
end main