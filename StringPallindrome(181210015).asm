;Program to check whether the input string is palindrome or not
.model small
.data
    input DB 'Balwant','$'
    tru DB 'true$'
    fals DB 'false$'

.code

main PROC

    MOV AX, @data                          ;Loading data
    MOV DS, AX
    
    Call Palin                             ;call procedure

    MOV AH, 4CH                            ;Returning 
    INT 21H
main ENDP

Palin PROC

    MOV SI, OFFSET input                   ; Load string start add

Last:                                      ; move to end of the string
    MOV AX, [SI]                           ; bring char at addr to accumulator
    CMP AL, '$'                            ; Check if pointer at string terminator
    JE First                               ; If last cmp returns true, Proceed further
    INC SI                                 ; Else increment pointer
    JMP Last                               ; and go back

First:
    MOV DI, OFFSET input                   ; Load string start again
    DEC SI 

Equality:
    CMP SI, DI                             ; compare pointers
    JL True                                ; if right pointer comes before the left pointer,
                                           ; then all checks passed and string is palindrome
    MOV AX, [SI]                           ; bring char to accumulator (SI is pointer from right)
    MOV BX, [DI]                           ; bring char to bx accumulator (DI is pointer from left)
    CMP AL, BL                             ; compare both chars
    JNE False                              ; if not equal, then string is not palindrome
                                           ; last check passed
    DEC SI                                 ; move right pointer a step back
    INC DI                                 ; move left pointer a step forward
    JMP Equality                           ; loop back

True:
                                           ; print true
    LEA DX, tru
    MOV AH, 09H
    INT 21H
    ret

False:
                                           ; print false
    LEA DX, fals
    MOV AH, 09H
    INT 21H
    ret

Palin ENDP
END main