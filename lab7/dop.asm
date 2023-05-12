ORG 0x0
V0: WORD $DEFAULT, 0x180
V1: WORD $DEFAULT, 0x180
V2: WORD $INT2, 0x180
V3: WORD $DEFAULT, 0x180
V4: WORD $DEFAULT, 0x180
V5: WORD $DEFAULT, 0x180
V6: WORD $DEFAULT, 0x180
V7: WORD $DEFAULT, 0x180


ORG 0x01F
DEFAULT: IRET
typeColor: WORD 0xA
typeOutput: WORD 0x1
START:  DI
    CLA
    LD #0xA ;загрузка в аккумулятор MR (1000|0010=1010)
    OUT 5 ;разрешение прерываний для 2 ВУ
    EI
MAIN: 
spinloop: LD typeColor
SUB #0xB
BEQ print_invert
print:LD typeOutput
SUB #0x1
BEQ natural
LD typeOutput
SUB #0x2
BEQ even

odd: CALL $print1
CALL $print3
CALL $print5
CALL $print7
CALL $print9
JUMP ju
natural: CALL $print0
CALL $print1
CALL $print2
CALL $print3
CALL $print4
CALL $print5
CALL $print6
CALL $print7
CALL $print8
CALL $print9
JUMP ju
even:CALL $print2
CALL $print4
CALL $print6
CALL $print8
JUMP ju


print_invert: LD typeOutput
SUB #0x1
BEQ natural1
LD typeOutput
SUB #0x2
BEQ even1

odd1: CALL $printNeg1
CALL $printNeg3
CALL $printNeg5
CALL $printNeg7
CALL $printNeg9
JUMP ju
natural1: CALL $printNeg0
CALL $printNeg1
CALL $printNeg2
CALL $printNeg3
CALL $printNeg4
CALL $printNeg5
CALL $printNeg6
CALL $printNeg7
CALL $printNeg8
CALL $printNeg9
JUMP ju
even1:CALL $printNeg2
CALL $printNeg4
CALL $printNeg6
CALL $printNeg8


ju: JUMP MAIN




INT2: ;обработка прерывания на ВУ-2
    PUSH
    IN 0x4
    AND #0xF
    CMP #0xA
    BMI type
color: ST typeColor
  JUMP finish
type: ST typeOutput
finish: POP
IRET

;1 - норм 2 - чёт 3 - нечёт


print0:  
  LD #0X0
  OUT 0X10
  LD #0X3C
  OUT 0x10
  LD #0X42
  OUT 0x10
  LD #0X81
  OUT 0x10
  LD #0X81
  OUT 0x10
  LD #0X42
  OUT 0x10
  LD #0X3C
  OUT 0x10
  RET

printNeg0:  
  LD #0XFF
  OUT 0X10
  LD #0XC3
  OUT 0x10
  LD #0XBD
  OUT 0x10
  LD #0X7E
  OUT 0x10
  LD #0X7E
  OUT 0x10
  LD #0XBD
  OUT 0x10
  LD #0XC3
  OUT 0x10
  RET

print1:
  LD #0X0
  OUT 0X10
  LD #0X10
  OUT 0X10
  LD #0X20
  OUT 0X10
  LD #0X40
  OUT 0X10
  LD #0XFF
  OUT 0X10
  RET

printNeg1:
  LD #0XFF
  OUT 0X10
  LD #0XEF
  OUT 0X10
  LD #0XCF
  OUT 0X10
  LD #0XBF
  OUT 0X10
  LD #0X0
  OUT 0X10
  RET
  
print2:
  LD #0X0
  OUT 0X10
  LD #0X61
  OUT 0X10
  LD #0X83
  OUT 0X10
  LD #0X85
  OUT 0X10
  LD #0XF9
  OUT 0X10
  RET

printNeg2:
  LD #0XFF
  OUT 0X10
  LD #0X9E
  OUT 0X10
  LD #0X7C
  OUT 0X10
  LD #0X7A
  OUT 0X10
  LD #0X06
  OUT 0X10
  RET

print3:  
  LD #0X0
  OUT 0X10
  LD #0X42
  OUT 0X10
  LD #0X81
  OUT 0X10
  LD #0X91
  OUT 0X10
  LD #0X6E
  OUT 0X10
  RET

printNeg3:  
  LD #0XFF
  OUT 0X10
  LD #0XBD
  OUT 0X10
  LD #0X7E
  OUT 0X10
  LD #0X6E
  OUT 0X10
  LD #0X91
  OUT 0X10
  RET

print4:  
  LD #0X0
  OUT 0X10
  LD #0XF0
  OUT 0X10
  LD #0X10
  OUT 0X10
  LD #0X10
  OUT 0X10
  LD #0XFF
  OUT 0X10
  RET

printNeg4:  
  LD #0XFF
  OUT 0X10
  LD #0X0F
  OUT 0X10
  LD #0XEF
  OUT 0X10
  LD #0XEF
  OUT 0X10
  LD #0X0
  OUT 0X10
  RET

print5:  
  LD #0X0
  OUT 0X10
  LD #0XF1
  OUT 0X10
  LD #0X91
  OUT 0X10
  LD #0X91
  OUT 0X10
  LD #0X8E
  OUT 0X10
  RET

printNeg5:  
  LD #0XFF
  OUT 0X10
  LD #0X0E
  OUT 0X10
  LD #0X6E
  OUT 0X10
  LD #0X6E
  OUT 0X10
  LD #0X71
  OUT 0X10
  RET

print6:
  LD #0X0
  OUT 0X10
  LD #0XFF
  OUT 0X10
  LD #0X89
  OUT 0X10
  LD #0X89
  OUT 0X10
  LD #0XEF
  OUT 0X10
  RET

printNeg6:
  LD #0XFF
  OUT 0X10
  LD #0X00
  OUT 0X10
  LD #0X76
  OUT 0X10
  LD #0X76
  OUT 0X10
  LD #0X10
  OUT 0X10
  RET

print7:
  LD #0X0
  OUT 0X10
  LD #0X80
  OUT 0X10
  LD #0X87
  OUT 0X10
  LD #0X98
  OUT 0X10
  LD #0XE0
  OUT 0X10
  RET

printNeg7:
  LD #0XFF
  OUT 0X10
  LD #0X7F
  OUT 0X10
  LD #0X78
  OUT 0X10
  LD #0X67
  OUT 0X10
  LD #0X1F
  OUT 0X10
  RET

print8:
  LD #0X0
  OUT 0X10
  LD #0XE7
  OUT 0X10
  LD #0X99
  OUT 0X10
  LD #0X99
  OUT 0X10
  LD #0XE7
  OUT 0X10
  RET

printNeg8:
  LD #0XFF
  OUT 0X10
  LD #0X18
  OUT 0X10
  LD #0X66
  OUT 0X10
  LD #0X66
  OUT 0X10
  LD #0X18
  OUT 0X10
  RET


print9:
  LD #0X0
  OUT 0X10
  LD #0XF1
  OUT 0X10
  LD #0X91
  OUT 0X10
  LD #0X91
  OUT 0X10
  LD #0XFF
  OUT 0X10
  RET

printNeg9:
  LD #0XFF
  OUT 0X10
  LD #0X0E
  OUT 0X10
  LD #0X6E
  OUT 0X10
  LD #0X6E
  OUT 0X10
  LD #0X0
  OUT 0X10
  RET