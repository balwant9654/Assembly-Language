;Program to check whether the given number is prime or not

.model small

.data

input dw 19                 ;Input value
tru   db 'True$'            ;True string
fals  db 'False$'           ;False string

.code

main proc                   ;Main procedure
    
    mov ax,@data            ;loading data
    mov ds,ax

    mov cx,1                ;cx register is used for the divisibilty of input value
    
Prime:                      ;Prime Label
    mov ax,input            ;Moving input to accumulator
    mov dx,0                ;Clearing data register
    inc cx                  ;incrementing cx to check whether the input value is divisible
    div cx                  ;Dividing value present in accumulator which is input value by cx and this is the main part of the program
    cmp dx,0                ;comparing if remainder is 0
    jne Prime               ;jump to Prime label until remainder is 0 
    
    mov bx,input            ;Moving input value to bx
    cmp cx,bx               ;Comparing incremented value with the input
    je true                 ;if result is equal then print true by going to true label
    
false:                      ;false label used to print False on the output console
    lea dx,fals
    mov ah,9
    int 21h
    
    mov ah,4ch
    int 21h
    
true:                       ;true label used to print True on the output console
    lea dx,tru
    mov ah,9
    int 21h
    
    mov ah,4ch
    int 21h    
    
main endp
end main