ORG 0x0
V0: WORD $DEFAULT, 0x180
V1: WORD $DEFAULT, 0x180
V2: WORD $INT2, 0x180
V3: WORD $INT3, 0x180
V4: WORD $DEFAULT, 0x180
V5: WORD $DEFAULT, 0x180
V6: WORD $DEFAULT, 0x180
V7: WORD $DEFAULT, 0x180


ORG 0x01F
X: WORD 0x0
DEFAULT: IRET
LEFT: WORD 0xFFEB
RIGHT: WORD 0x15
X_ADDRES: WORD $X
temporary: WORD ?
START:  DI
    CLA
    LD #0xA ;загрузка в аккумулятор MR (1000|0010=1010)
    OUT 5 ;разрешение прерываний для 2 ВУ
    LD #0xB ;(1000|0011=1011)
    OUT 7 ;разрешение прерываний для 3 ВУ
    EI
MAIN: 
     EI
	 LD X
     ST temporary
     INC
	 CALL $CHECK_X
     PUSH
     LD temporary
     PUSH
     LD X_ADDRES
     PUSH
     CALL $CAS
JUMP MAIN




INT3: ;обработка прерывания на ВУ-3
    PUSH
	 CLA
	 SUB X
	 SUB X
	 SUB X
    OUT 6
    LD X
    NOP
    POP
    IRET
    
INT2: ;обработка прерывания на ВУ-2
    PUSH
    NOP
    IN 4
    AND #0x000F
    AND X
    ST X
    NOP
    POP
    IRET


CHECK_X:
CHECK_LEFT:  
    CMP LEFT
    BPL CHECK_RIGHT
    JUMP LD_LEFT
CHECK_RIGHT:  
    CMP RIGHT
    BMI RETURN 
LD_LEFT: 
    LD LEFT
RETURN: RET


DEREF: WORD ?
;&4 -какое подать при сходстве  &3 - которое должно быть  &2 -адрес X &0 - FLAGS
CAS:
    PUSHF
    DI
    LD &2
    ST DEREF
    LD (DEREF)
    CMP &3
    BNE FAIL
    SUCCES: LD &4
    ST (DEREF)
    LD #0x1
    JUMP EXIT
    FAIL:CLA
EXIT: POPF
SWAP
ST &3
SWAP
SWAP
POP
SWAP
POP
SWAP
POP
RET
; RET 1- новое  0 - старое

; &3 - VAL &2 - chislo &0 - FLAGS
FAA: 
    PUSHF
    DI
    LD &2
    ST DEREF
    LD (DEREF)
    ADD &3
    ST (DEREF)

    POPF
    SWAP
    ST &2
    SWAP
    SWAP
    POP
    SWAP
    POP
    RET