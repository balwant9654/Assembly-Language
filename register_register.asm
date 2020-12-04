
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here 

A DW 2
B DW 3

MOV AX,4
ADD AX,5
SUB AX,2
MUL A
DIV B

ret




