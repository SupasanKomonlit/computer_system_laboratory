# find gcd by algorithm of Dijkstra

.data

	first_number	: .word		1890
	second_number	: .word		3315

	string_problem	: .asciiz	"gcd of 1890 and 3315 is "
	newline			: .asciiz	"\n";

.text

.globl main #call in system spim

gcd_function_case_01: # for case m == n
	add		$v0 , $a0 , $0
	addu	$sp , $s8 , $0
	lw		$ra , 4($sp)
	lw		$a0 , 8($sp)
	lw		$a1 , 12($sp)
	addiu	$sp , $sp , 16
	jr		$ra				# jump to return address

gcd_function_case_02: # for case m > n
	sub		$a0 , $a0 , $a1 # m = m-n
	jal		gcd_condition

gcd_function:
	addiu	$sp , $sp , -16 # we reserve mem for s8 address a0 a1 (4*4 = 16)
	sw		$a1 , 12($sp)	# save argument a1 to offset top sp + 12
	sw		$a0 , 8($sp)	# save argument a0 to offset top sp + 8
	sw		$ra , 4($sp)	# save argument ra (return address) to sp + 4
	addu	$s8 , $sp , $0	# save argument s8 (old frame point) to sp + 0
			# all step save point form rule to use in the subject
gcd_condition:
	beq		$a0 , $a1 , gcd_function_case_01 # if m == n jump
	slt		$t0 , $a0 , $a1 # if a0 < a1 -> t0 = 1
	beq		$t0 , $0  , gcd_function_case_02 # if n < m jump
	sub		$a1 , $a1 , $a0 # because if send on this line m < n
	jal		gcd_condition

main:
	lw		$t0 , first_number
	lw		$t1 , second_number
	add		$a0 , $t0 , $0
	add		$a1 , $t1 , $0
	jal		gcd_function		

	add		$t0 , $v0 , $0	# collect answer
	li		$v0 , 4			# 4 is code for print string
	la		$a0 , string_problem
	syscall
	li		$v0 , 1
	move	$a0 , $t0
	syscall
	li		$v0 , 4
	la		$a0 , newline
	syscall 
end:
	ori		$v0 , $0 , 10
	syscall
