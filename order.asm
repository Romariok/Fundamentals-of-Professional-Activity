ORG 0x566
d0: WORD 0x30
d1: WORD 0x31
d2: WORD 0x32
d3: WORD 0x33
d4: WORD 0x34
d5: WORD 0x35
d6: WORD 0x36
d7: WORD 0x37
d8: WORD 0x38
d9: WORD 0x39


STOP: WORD 0x00
ARR: WORD $STRING
VAR: WORD 0x00FF
START: CLA
S1:   
  LD (ARR)
  SWAB
  AND VAR
  CMP  STOP
  BEQ EXIT
  CALL checkDigit

S2:  
  LD (ARR)+
  AND VAR
  CMP  STOP
  BEQ EXIT
  CALL checkDigit
  JUMP S1 

EXIT: HLT



checkDigit: CMP d0
BEQ print0
CMP d1
BEQ print1
CMP d2
BEQ print2
CMP d3
BEQ print3
CMP d4
BEQ print4
CMP d5
BEQ print5
CMP d6
BEQ print6
CMP d7
BEQ print7
CMP d8
BEQ print8
CMP d9
BEQ print9
JUMP RETUR

print0:  
tmp0: IN 0x15
  AND #0x40
  BEQ tmp0
  CLA
  ADD #0x0
  ADD index
  OUT 0x14
  LD index
  SUB #0x10
  ST index
  JUMP RETUR

print1:
tmp1: IN 0x15
  AND #0x40
  BEQ tmp1
  CLA
  ADD #0x1
  ADD index
  OUT 0x14
  LD index
  SUB #0x10
  ST index
  JUMP RETUR

print2:
tmp2: IN 0x15
  AND #0x40
  BEQ tmp2
  CLA
  ADD #0x2
  ADD index
  OUT 0x14
  LD index
  SUB #0x10
  ST index
  JUMP RETUR

print3:  
tmp3: IN 0x15
  AND #0x40
  BEQ tmp3
  CLA
  ADD #0x3
  ADD index
  OUT 0x14
  LD index
  SUB #0x10
  ST index
  JUMP RETUR

print4:  
tmp4: IN 0x15
  AND #0x40
  BEQ tmp4
  CLA
  ADD #0x4
  ADD index
  OUT 0x14
  LD index
  SUB #0x10
  ST index
  JUMP RETUR

print5:  
tmp5: IN 0x15
  AND #0x40
  BEQ tmp5
  CLA
  ADD #0x5
  ADD index
  OUT 0x14
  LD index
  SUB #0x10
  ST index
  JUMP RETUR

print6:
tmp6: IN 0x15
  AND #0x40
  BEQ tmp1
  CLA
  ADD #0x6
  ADD index
  OUT 0x14
  LD index
  SUB #0x10
  ST index
  JUMP RETUR

print7:
tmp7: IN 0x15
  AND #0x40
  BEQ tmp7
  CLA
  ADD #0x7
  ADD index
  OUT 0x14
  LD index
  SUB #0x10
  ST index
  JUMP RETUR

print8:
tmp8: IN 0x15
  AND #0x40
  BEQ tmp8
  CLA
  ADD #0x8
  ADD index
  OUT 0x14
  LD index
  SUB #0x10
  ST index
  JUMP RETUR

print9:
tmp9: IN 0x15
  AND #0x40
  BEQ tmp9
  CLA
  ADD #0x9
  ADD index
  OUT 0x14
  LD index
  SUB #0x10
  ST index
  JUMP RETUR


RETUR: RET
index: WORD 0x70


ORG 0x5B4
STRING:WORD 0xF0C5
WORD 0x3037
WORD 0x3801
WORD 0x4D36
WORD 0x0036


