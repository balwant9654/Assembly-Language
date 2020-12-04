
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
.model small
.data
.code

Addressing proc
    
    mov al,10
    mov bl,2
    
    ;Register-Register Addressing mode
    add al,bl                             ;add Reg1,Reg2
    sub al,bl
    div bl
    mul bl
    
    ;Imediate addressing mode
    add al,6                              ;add Reg1,value
    sub al,4
    div bl
    mul bl
    
    mov [500h],2           
    mov al,10
  
    ;Indirect Addressing Mode
    add al,[500h]                         ;add Reg1,address ,here [500h] is the address
    sub al,[500h]
    div [500h]
    mul [500h]
     
Addressing endp
end Addressing




