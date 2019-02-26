# FILE		:	l_hailstone.s
# AUTHOR	:	Supasan Komonlit
# ID		:	5910503871
# Date		:	2019 , FEB 26

start_file: # label for first line
	beq		$0 , $0 , init_program

call_modulation:			# We will collect first , second argument to t0 ,t1
							# show operate --> first % second
	lw		$t0 , 0($sp)
	lw		$t1 , 4($sp)
	addiu	$t2 , $0 , 1
start_loop_in_modulation:
	slt		$t3 , $t0 , $t1 #  s0 < s1 ? s2 = 1  , 0
	beq		$t3 , $t2 , exit_loop_in_modulation
	subu	$t0 , $t0 , $t1
	j		start_loop_in_modulation	
exit_loop_in_modulation:
	addu	$v1 , $t0 , $0		# move answer to $v0
	jr		$ra

call_l_hailstone:
	addiu	$t9 , $0 , 4
	subu	$sp , $sp , $t9
	sw		$ra , 0($sp)
	lw		$s2 , 4($sp)
	addu	$s0 , $0 , $0
	addiu	$s1 , $0 , 1
start_loop_in_l_hailstone:
	beq		$s2 , $s1 , exit_loop_in_l_hailstone
	addu	$s0 , $s0 , $s1
	addiu	$t9 , $0 , 8
	subu	$sp , $sp , $t9
	addiu	$t9 , $0 , 2
	sw		$t9 , 4($sp)
	sw		$s2 , 0($sp)
	jal		call_modulation
	addiu	$t9 , $0 , 8
	addu	$sp , $sp , $t9
	bne		$v1 , $0 , condition_two_in_l_hailstone
	srl		$s2 , $s2 , 1
	j		start_loop_in_l_hailstone
condition_two_in_l_hailstone:
	sll		$s3 , $s2 , 1
	addu	$s2 , $s2 , $s3
	addiu	$s2 , $s2 , 1
	j		start_loop_in_l_hailstone
exit_loop_in_l_hailstone:
	addu	$v0 , $s0 , $0
	lw		$ra , 0($sp)
	addiu	$t9 , $0 , 4
	addu	$sp , $sp , $t9
	jr		$ra
	

init_program: # label for set program & reset value of register
	addiu	$sp , $0 , 32767
	addiu	$sp , $sp , 32767
	addiu	$sp , $sp , 2
	addu	$ra , $0 , $0

main_program:
	addiu	$t9 , $0 , 4
	subu	$sp , $sp , $t9
	addiu	$t6 , $0 , 5 
	sw		$t6 , 0($sp)
	jal		call_l_hailstone
	addiu	$t9 , $0 , 4
	addu	$sp , $sp , $t9
	addu	$t7 , $v0 , $0
