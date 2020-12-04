;Program for addtion,subtraction,multiplication and divison
.model small

.data

.code
    main proc
        
mov cl,8
add cl,3
sub cl,5
mov ax,3
mul cl
mov ax,4
div cl

    endp 
    end main
       ret
       