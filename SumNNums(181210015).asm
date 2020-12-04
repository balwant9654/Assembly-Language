;Program to print sum of n natural numbers
.model small 

.data

.code

Natural proc
    
    mov cl,3        ;moving 3 to counter register to loop 3 times
    mov al,0        ;moving 0 to accumulator
    mov bl,0        ;moving 0 to base register
    
    sum:            ;label
        inc bl      ;incrementing base register
        add al,bl   ;This will give sum of n natural numbers
    
    cmp bl,cl       ;comparing counter with bl 
    jne sum         ;Jump if not equal  
    ret
endp
end Natural