# find gcd by algorithm of Dijkstra v_2

.data
	first_number		: .word 1890
	second_number		: .word 3315

	string_problem	: .asciiz	"gcd of 1890 and 3315 is "
	newline			: .asciiz	"\n";

.text

.globl main

terminate_gcd_function:
	lw		$v0 , 12($fp)
	lw		$ra , 4($fp)
	lw		$fp , 0($fp)
	addi	$sp , $sp , 8
	jr		$ra

gcd_function:
	addiu	$sp , $sp , -8	# reserve area for collect $ra and $fp
	sw		$ra , 4($sp)	# store ra
	sw		$fp , 0($sp)	# store fp
	move	$fp , $sp
	lw		$t0 , 8($fp)	# load m
	lw		$t1 , 12($fp)	# load n

	beq		$t0 , $t1 , terminate_gcd_function # if m == n jump
	
	slt		$t3 , $t0 , $t1 # if a1 < a0 -> t0 = 1
	bne		$t3 , $0 , case_n_less_than_m # if n < m jump
	addiu	$sp , $sp ,-8
	sub		$t0 , $t0 , $t1
	sw		$t1 , 4($sp)
	sw		$t0 , 0($sp)
	jal		gcd_function
	addiu	$sp , $sp , 8
	lw		$ra , 4($fp)
	lw		$fp , 0($fp)
	addi	$sp , $sp , 8
	jr		$ra

case_n_less_than_m :	
	addiu	$sp , $sp ,-8
	sub		$t1 , $t1 , $t0
	sw		$t1 , 4($sp)
	sw		$t0 , 0($sp)
	jal		gcd_function
	addiu	$sp , $sp , 8
	lw		$ra , 4($fp)
	lw		$fp , 0($fp)
	addiu	$sp , $sp , 8
	jr		$ra

	
main:
	lw		$t0 , first_number
	lw		$t1 , second_number

	addiu	$sp , $sp , -8
	sw		$t1 , 4($sp)	# save to topstack	n
	sw		$t0 , 0($sp)	# save to bottom stack m
	jal		gcd_function
	addi	$sp , $sp , 8

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
