;PROGRAM TO PRINT MULTIPLES FOR 4 and 7

org 100h

.data
    n dw 11      ; Input 'N' value to print multiples upto
    show db "Multiples upto given places of 4 and 7 are : $"
    four db 10,13,"For 4 :  $"
    sev  db 10,13, "For 7 : $"
    space db " $"

.code
    mov si,0;    ; set si reg to 0 to keep track of n terms
    
    lea dx,show ; displays label show on the console
    mov ah,9
    int 21h;
    mov cx,n;    ; cx holding the value of n label   
    lea dx,four  ; displays label four on the console
    mov ah,9
    int 21h;
    xor ax,ax    ; clears ax register
    
    print4:            ;label for printing 4's multiples 
        mov bl,4       ; mov 4 value to bl reg
        mov al,bl      ; copy of bl reg in al reg
        mul si         ; multiply by ith value store res in al reg
        inc si         ; inc si pointer by 1
        mov dl,al      ; mov result after multiplication to dl reg
        call dis       ; call dis procedure to print result for each term
        mov cx,n       ; mov value of n to cx reg
        sub cx,si      ; sub cx by si and store res in cx reg
        call spaceprint ; calls the procedure
        jcxz exit:     ; if cx reg becomes 0 jump to exit label
        jmp print4     ; jump back to print4 label
  exit:         
      lea dx,sev        ; display sev label to console
      mov ah,9          
      int 21h;
      xor ax,ax         ; clears ax reg
     
        mov si,0        ; reset si to 0, for printing 7's multiples  
      print7:
        mov bl,7         ; mov 4 value to bl reg
        mov al,bl        ; copy of bl reg in al reg
        mul si           ; multiply by ith value store res in al reg
        inc si           ; inc si pointer by 1
        mov dl,al        ; mov result after multiplication to dl reg
        call dis         ; call dis procedure to print result for each term
        mov cx,n         ;mov value of n to cx reg
        sub cx,si        ;sub cx by si and store res in cx reg
        call spaceprint  ;calls the procedure
        jcxz exit2:      ;jump to exit2 label if cx reg = 0
        jmp print7       ;jump back to print7 label
  exit2: 


ret
  
;PROCEDURE FOR PRINTING SPACE CHARACTER
spaceprint PROC near
     lea dx,space   ; 
     mov ah,9
     int 21h
     xor ax,ax      ; clear ax register 
     ret
spaceprint endp  


;PROCEDURE FOR DISPLAYING MULTIPLE DIGITS VALUE TO CONSOLE     
dis PROC near

      mov cx,0      ; counter set to 0
      mov bx,10     ; set value of bx reg to 10
   
pushnum: 
       mov dx,0
       div bx       ; remainder stored in dl
       add dl,48    ; convert to ascii add 48
       push dx      ; push remainder in stack
       inc cx       ; counter reg for counting number of digits
       cmp ax,0     ; loop exit condition
       jne pushnum  ; if not zero continue pushing

display: 
       pop ax       ;pop back digit  
       mov dx,ax
       mov ah,2     ; display digit by digit on console
       int 21h
       loop display ; loop until cx reg is 0
RET
dis ENDP     



