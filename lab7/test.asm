ORG 0x7A
RESULT: WORD 0x1

;Сложение чисел
ARG1: WORD 0xD3
AC1: WORD 0x9031

RES1: WORD 0x9104
ANS1: WORD ?
;Выборка младшего байта
ARG2: WORD 0xCDD3
AC2: WORD 0x9031

RES2: WORD 0x9104
ANS2: WORD ?

;Выставление флагов
ARG3: WORD 0xF5
AC3: WORD 0xF34A

RES3: WORD 0xF43F
ANS3: WORD ?

START:
TEST1: CLA
LD AC1
WORD 0x907B
ST ANS1
SUB RES1
BEQ SUCCESS1
FAIL1: CLA 
ST RESULT
JUMP STOP
SUCCESS1: CLA
TEST2: CLA
LD AC2
WORD 0x907F
ST ANS2
SUB RES2
BEQ SUCCESS2
FAIL2: CLA 
ST RESULT
JUMP STOP
SUCCESS2: CLA

TEST3: CLA
LD AC3
WORD 0x9083
ST ANS3
BMI SUCCESS3
FAIL3: CLA 
ST RESULT
JUMP STOP
SUCCESS3: 
CLA
STOP: HLT