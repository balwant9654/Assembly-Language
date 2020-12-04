;Program to convert ascii string of decimal value to binary 

.STACK 100H
.DATA
    INPUT DB '5', '$'
    RES DB 10 DUP ('$')
    WSP DB ' ', '$'
.CODE

Print MACRO string
    MOV AH, 9
    LEA DX, string
    INT 21H
endm

main proc
    ; load data
    MOV AX, @DATA     
    MOV DS, AX

    ; Call procedure
    CALL Ascii

    ; exit
    MOV AH, 4CH
    INT 21H
main endp

Ascii PROC

    mov DI, offset INPUT    ; Load address of first char of input string to DI
Label:
    MOV AX, [DI]            ; Move char at pointer DI to AX
    CMP AL, '$'             ; Check if last character
    JE exit               ; If last character we are done
    LEA SI, RES             ; If not load address to store binary for current char at
    CALL binary            ; Convert current character to binary
    Print RES             ; Display converted value
    Print WSP             ; Print whitespace and proceed to next value
    INC DI                  ; Increment pointer to next character
    JMP Label                ; Loop

exit:                     
    ret                     ; Procedure complete return
Ascii endp

binary PROC
    MOV AH, 0               ; Clear high bit of ax
    SUB AL, 30H             ; Then subtract 0x30 or 48, number is now decimal
    MOV CX, 0               ; Set binary digit position counter
    MOV BX, 2               ; Load 2 to BX as base = 2

convert:
    MOV DX, 0               ; Clear remainder
    DIV BX                  ; Divide number by 2
    ADD DL, 30H             ; Convert remainder to ascii by adding 0x30 or 41
    PUSH DX                 ; push to stack
    INC CX                  ; increment digit counter
    CMP AX, 1               ; Compare remaining number to 1
    JG convert              ; If number is greater than 1 try for next digit

    ADD AL, 30H             ; Convert last number to ascii
    MOV [SI], AL            ; and add it to output string

format:
    POP AX                  ; Get next digit out of stack
    INC SI                  ; move to next digit pos    
    MOV [SI], AL            ; Add current digit to string
    LOOP format             ; loop until no digits remain
    INC SI                  ; Since we reuse RES for every digit,
    MOV [SI], '$'           ; Set null terminator at correct location
    ret                     ; Return to continue
binary ENDP
end main