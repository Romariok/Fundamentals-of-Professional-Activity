ORG 0x0
inp_res: WORD ?
RES: WORD $D_7
h: WORD $part2
START: CLA
	CALL $input
	LD $part2
	BNE STARTB
	CALL $output
	JUMP START
STARTB: CLA
	CALL $inputB
	LD $EQ
	BNE RESULT
	CALL $outputB
	JUMP STARTB
RESULT: LD $minOrPlus
	BNE plus_execution
	JUMP minus_execution
plus_execution: CALL $sum
JUMP STOPAll
minus_execution: CALL $subtracting
LD inp_res
BNE STOPAll
LD #0xA
ST $A_7
STOPAll: 	CALL $output
true_end: HLT

;-2 - плюс   -3- минус    -1 - равно
;1 число
A__1: WORD 0x0
A_0: WORD 0x0
A_1: WORD 0x0
A_2: WORD 0x0
A_3: WORD 0x0
A_4: WORD 0x0
A_5: WORD 0x0
A_6: WORD 0x0
A_7: WORD 0x0
A_8: WORD 0x0

revExpand: LD A_0
ST A__1
LD A_1
ST A_0
LD A_2
ST A_1
LD A_3
ST A_2
LD A_4
ST A_3
LD A_5
ST A_4
LD A_6
ST A_5
LD A_7
ST A_6
LD A_8
ST A_7
RET
expand: LD A_7
ST A_8
LD A_6
ST A_7
LD A_5
ST A_6
LD A_4
ST A_5
LD A_3
ST A_4
LD A_2
ST A_3
LD A_1
ST A_2
LD A_0
ST A_1
LD A__1
ST A_0
RET

input: IN 0x1D
	AND #0x40
	BEQ input
	CALL $expand
	IN 0x1C
	PUSH
	CALL $checkInput
	BPL das
	BEQ das
	ADD #0x1
	BEQ equals1
	ADD #0x1
	BEQ plus1
	JUMP minus1
equals1: CALL $revExpand
	CLA
	ADD #0x1
	ST $EQ
	JUMP enddd
plus1: CALL $revExpand
	CALL $clearOutput
	CLA
	ADD #0x1
	ST $minOrPlus
	ST $part2
	JUMP enddd
minus1: CALL $revExpand
	CALL $clearOutput
	CLA
	ADD #0x1
	ST $part2
	JUMP enddd

das: 
	ST A_0

enddd: RET

Cr_AD: WORD $C_0
subtracting:CLA 

	CALL $checkNegative
	BNE inp

   LD C_AD1
	PUSH
	LD B_AD1
	PUSH
	LD A_AD1
	PUSH
	CALL $sub_res_last

begin_loop1:LD A_AD1
	ADD #0x1
	ST A_AD1
	LD B_AD1
	ADD #0x1
	ST B_AD1
	LD C_AD1
	ADD #0x1
	ST C_AD1


	LD Cr_AD
	PUSH
	LD C_AD1
	PUSH
	LD B_AD1
	PUSH
	LD A_AD1
	PUSH
	CALL $sub_res

	LD Cr_AD
	ADD #0x1
	ST Cr_AD
	LOOP IT1
	JUMP begin_loop1
	LD #0x1
	ST $inp_res
	JUMP ret_minus
inp: LD C_AD1
	PUSH
	LD B_AD1
	PUSH
	LD A_AD1
	PUSH
	CALL $sub_inp_last

begin_loop2:LD A_AD1
	ADD #0x1
	ST A_AD1
	LD B_AD1
	ADD #0x1
	ST B_AD1
	LD C_AD1
	ADD #0x1
	ST C_AD1

	LD Cr_AD
	PUSH
	LD C_AD1
	PUSH
	LD B_AD1
	PUSH
	LD A_AD1
	PUSH
	CALL $sub_inp

	LD Cr_AD
	ADD #0x1
	ST Cr_AD
	LOOP IT1
	JUMP begin_loop2
	CLA 
	ST $inp_res
ret_minus: RET



A_AD1: WORD $A_0
B_AD1: WORD $B_0
C_AD1: WORD $C_0
D_AD1: WORD $D_0
Dr_AD1: WORD $D_0
IT1: WORD 0x7

;&1 - A(i) &2 - B(i) &3 - C(i)
sub_res_last:  
	LD &1
	ST tmp11
	LD &2
	ST tmp22
	LD &3
	ST tmp33


  LD (tmp11)
  CMP (tmp22)
  BMI else_sub_last
  SUB (tmp22)
  ST (tmp11)
  JUMP ret_sub_last
else_sub_last:  LD (tmp11)
  ADD #0X10
  SUB (tmp22)
  SUB #0X6
  ST (tmp11)
  LD #0x1
  ST (tmp33)
ret_sub_last:  SWAP
ST &3
SWAP
SWAP
POP
SWAP
POP
SWAP
POP
RET 

;&1 - A(i) &2 - B(i) &3 - C(i) &4 - C(i-1)
sub_res:
	LD &1
	ST tmp11
	LD &2
	ST tmp22
	LD &3
	ST tmp33
	LD &4
	ST tmp44

  LD (tmp11)
  SUB (tmp44)
  CMP (tmp22)
  BMI else_sub
  SUB (tmp22)
  ST (tmp11)
  JUMP ret_sub
else_sub:  LD (tmp11)
  SUB (tmp44)
  ADD #0X10
  SUB (tmp22)
  SUB #0X6
  ST (tmp11)
  LD #0x1
  ST (tmp33)
ret_sub:  SWAP
ST &4
SWAP
SWAP
POP
SWAP
POP
SWAP
POP
SWAP
POP
RET 

tmp11: WORD ?
tmp22: WORD ?
tmp33: WORD ?
tmp44: WORD ?
;&1 - A(i) &2 - B(i) &3 - C(i)
sub_inp_last:  
	LD &1
	ST tmp11
	LD &2
	ST tmp22
	LD &3
	ST tmp33
  LD (tmp22)
  CMP (tmp11)
  BMI el_sub_last
  SUB (tmp11)
  ST (tmp11)
  JUMP r_sub_last
el_sub_last:  LD (tmp22)
  ADD #0X10
  SUB (tmp11)
  SUB #0X6
  ST (tmp11)
  LD #0x1
  ST (tmp33)
r_sub_last:  SWAP
ST &3
SWAP
SWAP
POP
SWAP
POP
SWAP
POP
RET 


;&1 - A(i) &2 - B(i) &3 - C(i) &4 - C(i-1)
sub_inp:
	LD &1
	ST tmp11
	LD &2
	ST tmp22
	LD &3
	ST tmp33
	LD &4
	ST tmp44

  LD (tmp22)
  SUB (tmp44)
  CMP (tmp11)
  BMI el_sub
  SUB (tmp11)
  ST (tmp11)
  JUMP r_sub
el_sub:  LD (tmp22)
  SUB (tmp44)
  ADD #0X10
  SUB (tmp11)
  SUB #0X6
  ST (tmp11)
  LD #0x1
  ST (tmp33)
r_sub:  SWAP
ST &4
SWAP
SWAP
POP
SWAP
POP
SWAP
POP
SWAP
POP
RET 

A_AD_in: WORD $A_7
B_AD_in: WORD $B_7

checkNegative:CLA
LD A_AD_in
ST tmp11
LD B_AD_in
ST tmp22
LD #0x8
ST tmp33



loop_check1:LD (tmp11)
SUB (tmp22)
BEQ le
BPL check_res
BMI check_inp
le: LD tmp11
SUB #0x1
ST tmp11
LD tmp22
SUB #0x1
ST tmp22
LOOP tmp33
JUMP loop_check1


; 0 - sub_res   1 -sub_inp
check_res:
CLA
JUMP end_of_check
check_inp: LD #0x1
end_of_check: RET







minOrPlus: WORD 0x0
part2: WORD 0x0
EQ: WORD 0x0
; 0 - minus, 1 - plus

;temporary
C_0: WORD 0x0
C_1: WORD 0x0
C_2: WORD 0x0
C_3: WORD 0x0
C_4: WORD 0x0
C_5: WORD 0x0
C_6: WORD 0x0
C_7: WORD 0x0

;Carry flags
D_0: WORD 0x0
D_1: WORD 0x0
D_2: WORD 0x0
D_3: WORD 0x0
D_4: WORD 0x0
D_5: WORD 0x0
D_6: WORD 0x0
D_7: WORD 0x0
;76


A_AD: WORD $A_0
B_AD: WORD $B_0 ;178
C_AD: WORD $C_0
D_AD: WORD $D_0
Dr_AD: WORD $D_0
IT: WORD 0x7
;&0 - A(i)  &1 - B(i) &2 - C(i) &3 - D(i) &4 - D(i-1) &5 - количество повторений
sum: CLA 


	LD D_AD
	PUSH
	LD C_AD
	PUSH
	LD B_AD
	PUSH
	LD A_AD
	ST $h
	PUSH
	CALL $sum_last

begin_loop:LD A_AD
	ADD #0x1
	ST A_AD
	LD B_AD
	ADD #0x1
	ST B_AD
	LD C_AD
	ADD #0x1
	ST C_AD
	LD D_AD
	ADD #0x1
	ST D_AD


	LD Dr_AD
	PUSH
	LD D_AD
	PUSH
	LD C_AD
	PUSH
	LD B_AD
	PUSH
	LD A_AD
	PUSH
	CALL $sum_smt

	LD Dr_AD
	ADD #0x1
	ST Dr_AD
	LOOP IT
	JUMP begin_loop
Gga: RET




;&1 - A(i)  &2 - B(i) &3 - C(i) &4 - D(i)    i -> i+1
tmp1: WORD 0x0
tmp2: WORD 0x0
tmp3: WORD 0x0
tmp4: WORD 0x0

sum_last:  CLA  
  LD &1
  ST tmp1
  LD &2 
  ST tmp2
  LD &3
  ST tmp3
  LD &4
  ST tmp4

  LD (tmp1)
  ADD (tmp2)
  ST (tmp3)



  LD #0x9
  CMP (tmp3)
  BMI else_sum_last
  LD (tmp3)
  ST (tmp1)
  JUMP return_sum_last
else_sum_last:  LD (tmp3)
  ADD #0x6
  AND #0xF
  ST (tmp1)
  CLA
  ADD #0x1
  ST (tmp4)
return_sum_last:  SWAP
ST &4
SWAP
SWAP
POP
SWAP
POP
SWAP
POP
SWAP
POP
RET

;&1 - A(i)  &2 - B(i) &3 - C(i) &4 - D(i) &5 - D(i-1)   i -> i+1
tmp5: WORD 0x0
sum_smt:  CLA
  LD &1
  ST tmp1
  LD &2 
  ST tmp2
  LD &3
  ST tmp3
  LD &4
  ST tmp4
  LD &5
  ST tmp5

  LD (tmp1)
  ADD (tmp2)
  ADD (tmp5)
  ST (tmp3)
  LD #0x9
  CMP (tmp3)
  BMI else_sum
  LD (tmp3)
  ST (tmp1)
  JUMP return_sum
else_sum:  LD (tmp3)
  ADD #0x6
  AND #0xF
  ST (tmp1)
  CLA
  ADD #0x1
  ST (tmp4)
return_sum: SWAP
ST &5
SWAP
SWAP
POP
SWAP
POP
SWAP
POP
SWAP
POP
SWAP
POP
RET





















;2 число
B__1: WORD 0x0
B_0: WORD 0x0
B_1: WORD 0x0
B_2: WORD 0x0
B_3: WORD 0x0
B_4: WORD 0x0
B_5: WORD 0x0
B_6: WORD 0x0
B_7: WORD 0x0
B_8: WORD 0x0

revExpandB: LD B_0
ST B__1
LD B_1
ST B_0
LD B_2
ST B_1
LD B_3
ST B_2
LD B_4
ST B_3
LD B_5
ST B_4
LD B_6
ST B_5
LD B_7
ST B_6
LD B_8
ST B_7
RET
expandB: LD B_7
ST B_8
LD B_6
ST B_7
LD B_5
ST B_6
LD B_4
ST B_5
LD B_3
ST B_4
LD B_2
ST B_3
LD B_1
ST B_2
LD B_0
ST B_1
LD B__1
ST B_0
RET

inputB: IN 0x1D
	AND #0x40
	BEQ inputB
	CALL $expandB
	IN 0x1C
	PUSH
	CALL $checkInput
	BNC dasB
	BEQ dasB
	ADD #0x1
	BEQ equals1B
	ADD #0x1
	BEQ plus1B
	ADD #0x1
	JUMP minus1B
equals1B: CALL $revExpandB
	LD #0x1
	ST $EQ
	JUMP endddB
plus1B: CALL $revExpandB
	LD #0x1
	CALL $clearOutput
	ST $minOrPlus
	ST $part2
	JUMP endddB
minus1B: CALL $revExpandB
	CALL $clearOutput
	LD #0x1
	ST $part2
	JUMP endddB

dasB: 
	ST B_0

endddB: RET


ORG 0x400
tmp: WORD 0x0
en: WORD $A_7
bool_out: WORD 0x0
LEN: WORD 0x70
output:  CLA
	PUSH
	PUSH
	PUSH
	LD bool_out
	ST &2
	LD LEN
	ST &0
	LD en
	ST &1
spinloop: IN 0x15
	AND #0x40
	BEQ spinloop
;проверка на ноль
	LD &1
	ST tmp
	LD (tmp)

	SUB #0xA
	BEQ minus_output
	ADD #0xA
	BNE true
	JUMP check
	true: LD #0x1
	ST &2
	check: LD &2
	BNE continue
	LD #0xB
	JUMP ou
	continue: LD &1
	ST tmp
	LD (tmp)
	JUMP ou
	minus_output:
	LD #0xA

	ou: ADD &0
	OUT 0x14
	LD &1
	SUB #0x1
	ST &1
	LD &0
	SUB #0x10
	ST &0
	BPL spinloop
	
	SWAP
	POP
	SWAP
	POP
	SWAP
	POP
	RET

tmpB: WORD 0x0
enB: WORD $B_7
bool_outB: WORD 0x0
LENB: WORD 0x70
outputB:  CLA
	PUSH
	PUSH
	PUSH
	LD bool_outB
	ST &2
	LD LENB
	ST &0
	LD enB
	ST &1
spinloopB: IN 0x15
	AND #0x40
	BEQ spinloopB
;проверка на ноль
	LD &1
	ST tmpB
	LD (tmpB)


	BNE trueB
	JUMP checkB
	trueB: LD #0x1
	ST &2
	checkB: LD &2
	BNE continueB
	LD #0xB
	JUMP ouB
	continueB: LD &1
	ST tmpB
	LD (tmpB)


	ouB: ADD &0
	OUT 0x14
	LD &1
	SUB #0x1
	ST &1
	LD &0
	SUB #0x10
	ST &0
	BPL spinloopB
	;327
	
	SWAP
	POP
	SWAP
	POP
	SWAP
	POP
	RET







clearNum: WORD 0x8B
clearOutput: CLA
	PUSH
	LD #0x9
	ST &0
out1: IN 0x15
	AND #0x40
	BEQ out1
	LD clearNum
	OUT 0x14
	SUB #0x10
	ST clearNum
	LOOP &0
	JUMP out1
	SWAP
	POP
	LD #0x8B
	ST clearNum
	RET

checkInput: LD &1
SUB #0xA
BEQ minus 
ADD #0xA
SUB #0xB
BEQ plus
ADD #0xB
SUB #0xF
BEQ equals
ADD #0xF
JUMP endd

minus: SUB #0x3
JUMP endd
plus: SUB #0x2
JUMP endd
equals: SUB #0x1
endd: SWAP
ST &1
SWAP
SWAP
POP
RET
