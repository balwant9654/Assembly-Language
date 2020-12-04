
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
                     
                     
; add your code here 

.model 
.data
.code

    main proc
        
      mov ax,1
      mov cx,0
      mov [800h],2
      mov bx,[800h]
      add cx,[bx]
      
      sub cx,[bx]
      
      mul [bx]
      div [bx]
      
    endp
    end main.

ret




