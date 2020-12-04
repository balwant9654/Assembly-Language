;Program to check whether the given number is pallindrome or not

.model small

.data

input   dw      1031                     ;input is a variable contain the input value 
arr     db      10      dup(?)           ;initializing empty array of size 10
tru     db      'True$'                  ;tru is a variable containing string True
fals   db       'False$'                 ;fals is a variable containing False

.code

main proc
   
   mov ax,@data                          ;loading the data
   mov ds,ax
   
   call palin                            ;calling palin procedure
   
   mov ah,4ch                            ;returning back to the operating system
   int 21h
                                         ;end of the main
main endp  

palin proc
    mov ax,input                         ;intializing ax with the input variable
    mov si,offset arr                    ;intilizing source index with the array initial element address
    
Number:                                  ;Number is label used to add reverse elements of array
    mov dx,0                             ;initialising dx with 0
    mov bx,10                            ;initialising bx with 0
    div bx                               ;diving ax with bx and result is stored in ax
    mov arr[si],dl                       ;adding remainder to array which will contain the reverse of the input value
    inc si                               ;incrementing the source index
    cmp ax,0                             ;comparing quotient with 0 
    jg Number                            ;if quotient is greater than 0 then jump to Number label
    
    mov di,offset arr                    ;initialising di with array which is storing value
    dec si                               ;decrement of si

Equality:                                ;Equality is the label to check whether the value is palindrome or not
    cmp si,di                            ;compare si and di 
    je true                              ;if equal then jump to true label
    mov al,arr[si]                       ;moving array elements present at the address si to al
    mov bl,arr[di]                       ;moving array elements present at the address di to bl
    cmp al,bl                            ;comparing al with bl 
    jne false                            ;if not equal then jump to false label
    dec si                               ;Decrementing si 
    inc di                               ;Incrementing si
    Loop Equality                        ;Loop Equality until the result is obtained
    
true:                                    ;true is a label and will print true on the output console if value is pallindrome
    lea dx,tru
    mov ah,9
    int 21h
    ret

false:                                   ;false is a label and will print false on the output console if value is not pallindrome
    lea dx,fals
    mov ah,9
    int 21h
    ret

end main