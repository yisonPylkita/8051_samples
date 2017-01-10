LEFT_OPERAND_BASE    equ 2000h
RIGHT_OPERAND_BASE   equ 3000h
RESULT_BASE          equ 4000h


start:
    mov dptr, #LEFT_OPERAND_BASE
    movx a, @dptr
    mov r0, a
    mov dptr, #RIGHT_OPERAND_BASE
    movx a, @dptr
    mov r1, a

gcd0:
    mov a, r0    ; dividend
    mov b, r1    ; divisor
    cjne a, b, dummy
    jc swp    ; swap when a lower than b
    
dummy:
    div ab
    mov a, r1    ; old divisor is now dividend
    mov r0, a
    mov r1, b
    cjne r1, #0h, gcd0    ;loop if remainder != 0
    acall exit
;   
swp:
    mov r7, a
    mov a, b
    mov b, r7
    acall dummy

exit:
    mov a, r0
    mov dptr, #RESULT_BASE
    movx @dptr, a
END
