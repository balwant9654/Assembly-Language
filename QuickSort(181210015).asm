;Program of QuickSort

.DATA
    info1 DB 'Before sort:  ', '$'
    info2 DB 'After sort:  ', '$'
    arr DW 9, 64, 57, 81, 24
    arrLen DW 5
    temp DW 5 DUP (0)
    RES DB 10 DUP ('$')
    WSP DB ' ', '$'
    NEWLINE DB 10, 13, '$'
    i DW ?
    j DW ?
    p DW 0
    r DW 4
    q DW ?
    x DW ?

.CODE

stack segment
    stk DB  100  dup(0)
    top EQU 100
ends

DISPLAY MACRO string
    MOV AH, 9
    LEA DX, string
    INT 21H
ENDM

Main PROC FAR
    ; load data
    MOV AX, @DATA     
    MOV DS, AX
    MOV AX, stack
    MOV SS, AX
    MOV SP, top

    DISPLAY info1
    CALL Printarray
    
    ; Call procedure
    CALL Qsort
    DISPLAY NEWLINE

    DISPLAY info2
    Call Printarray

    ; exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP


; Schema ->
;QUICKSORT(A, p, r)
;   if p < r
;       q = PARTITION(A, p, r)
;       QUICKSORT(A, p, q-1)
;       QUICKSORT(A, q+1, r)
Qsort PROC                  ; Qsort(A, p, r)
    ; if p < r
    MOV AX, p               ; Load p
    CMP AX, r               ; compare p with r
    JGE complete            ; if p > r, then sorting is complete for this partition

    ; q = PARTITION(A, p, r)
    CALL Partition          ; call partition procedure
    MOV q, AX               ; store result in q

    ; We need q+1 and r for the second call, push them to stack
    INC AX                  ; do q+1
    PUSH AX                 ; push the value of q+1
    PUSH r                  ; push the value of r

    ; Set function parameters for first recursion call, arr, p and q-1
    MOV AX, q               ; get value of q
    MOV r, AX               ; set second parameter to q
    DEC r                   ; do q - 1 
    CALL Qsort              ; p is already p here, and r is now set to q-1

    ; get previously pushed values back for second recursion call, arr, q+1, r 
    pop r                   ; pop to r (we last pushed to r)
    pop p                   ; pop to p = q+1
    CALL Qsort              ; p is q+1 here, and r is r

    complete:
        ret                 ; standard return.
Qsort ENDP

; Schema ->
;PARTITION(A, p, r)
;    x = A[r]
;    i = p - 1
;    for j = p to r-1
;        if A[j] ≤ x
;            i = i + 1
;            swap A[i] with A[j]
;    swap A[i+1] with A[r]
;    return i+1
Partition PROC              ; PARTITION(A, p, r)

    MOV SI, OFFSET arr      ; load address of array
    MOV AX, r               ; get r

    ; since every int is 2 bytes, we need to move index*2 times from start of array
    SHL AX, 1               ; shift left will multiply ax by 2
    ADD SI, AX              ; add the result to start of array, we are at A[r] now
    ; copy A[r] to x
    MOV AX, [SI]
    MOV x, AX               ; x = A[r]
    ; copy p - 1 to i
    MOV AX, p               
    MOV i, AX               ; i = p
    DEC i                   ; i = i - 1
    ; copy P to j
    MOV AX, p               
    MOV j, AX               ; j = p

FOR1:                       ; for j=p to r-1
    MOV SI, OFFSET arr      ; get start of array
    MOV AX, j               ; move current value of j to ax
    SHL AX, 1               ; again int is 2 bytes, move index*2
    ADD SI, AX
    MOV AX, [SI]            ; move A[j] to AX

    ; if A[j] <= x
    CMP AX, x               
    JG bigger               ; if x > A[j] no need to swap

    INC i                   ; otherwise do i = i+1

    ; swap A[i] and A[j]
    MOV DI, OFFSET arr      ; get start of array again
    
    ; values is at index*2
    MOV CX, i               
    SHL CX, 1               
    ADD DI, CX

    MOV CX, [DI]            ; do temp = A[i]

    MOV [DI], AX            ; do A[i] = A[j]
    MOV [SI], CX            ; do A[j] = temp

bigger:
    INC j                   ; do j = j+1 for for loop
    
    ; check for for loop condition, if j < r loop again
    MOV AX, r
    CMP j, AX
    JL FOR1

    ; swap A[i+1] with A[r]
    INC i                   ; do i=i+1
    MOV SI, OFFSET arr      ; get start of array
    
    ; get A[i+1]
    MOV AX, i               
    SHL AX, 1               
    ADD SI, AX           
    MOV AX, [SI]            ; AX = A[i+1]

    ; get A[r]
    MOV DI, OFFSET arr
    MOV CX, r
    SHL CX, 1
    ADD DI, CX
    MOV CX, [DI]            ; CX = A[r]

    ; swap A[i+1] and A[r]
    MOV [DI], AX            ; A[r] = AX
    MOV [SI], CX            ; A[i+1] = CX

    MOV AX, i               ; i is already i+1, set ax to return value
    ret                     ; and return
Partition ENDP

Printarray PROC
    MOV DI, OFFSET arr      ; get start of array
    MOV AX, arrLen          ; get length of array
    MOV i, 0                ; set i to 0

    ; from i to arrLen print each value
print:                      ; for i=0 to arrLen
    ; check if array length has been exceeded
    MOV BX, i               
    CMP BX, arrLen
    JE endPrintArr          ; if array is traversed through completely, exit

    ; print current value
    MOV AX, [DI]            ; AX = A[i]
    LEA SI, RES             ; load string buffer for current number
    CALL Hexconv            ; convert number to ascii and store to string buffer
    DISPLAY RES             ; print string buffer
    DISPLAY WSP             ; show white space
    ADD DI, 2               ; next number at 2 bytes ahead
    INC i                   ; do i = i + 1
    JMP print               ; loop again

endPrintArr:
    ret 8                   ; exit print procedure
Printarray ENDP

Hexconv PROC
    MOV CX, 0               ; Set digit position counter
    MOV BX, 10              ; Load 10 to BX as base = 10

convert:
    MOV DX, 0               ; Clear remainder
    DIV BX                  ; Divide number by 10
    ADD DL, 30H             ; Convert remainder to ascii by adding 0x30
    PUSH DX                 ; push to stack
    INC CX                  ; increment digit counter
    CMP AX, 9               ; Compare remaining number to 9
    JG convert              ; If number is greater than 9 try for next digit

    ADD AL, 30H             ; Convert remaining number to ascii
    MOV [SI], AL            ; and add it to output string

format:
    POP AX                  ; Get next digit out of stack
    INC SI                  ; move to next digit pos    
    MOV [SI], AL            ; Add current digit to string
    LOOP format             ; loop until no digits remain
    INC SI                  ; Since we reuse RES for every digit,
    MOV [SI], '$'           ; Set null terminator at correct location
    ret
Hexconv ENDP

END MAIN