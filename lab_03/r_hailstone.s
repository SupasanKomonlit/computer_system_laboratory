# FILE		:	r_hailstone.s
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

abort_r_hailstone:
	lw		$fp , 0($sp)	
	lw		$ra , 4($sp)
	lw		$s0 , 8($sp)
	addiu	$sp , $sp , 12
	jr		$ra

call_r_hailstone:			# colelct first argument to s0
	addiu	$t9 , $0 , 12
	subu	$sp , $sp , $t9	# We only reserve value for s0 , ra and old fp
	sw		$s0 , 8($sp)
	sw		$ra , 4($sp)
	sw		$fp , 0($sp)
	addu	$fp , $sp , $0
	lw		$s0 , 12($fp)	# load first argument to s0
	addiu	$t0 , $0 , 1	
	bne		$s0 , $t0 , condition_two_r_hailstone
	addu	$v0 , $0 , $0
	j		abort_r_hailstone	
condition_two_r_hailstone:
	addiu	$t9 , $0 , 8
	subu	$sp , $sp , $t9	# save argument for send to modulation
	addiu	$t1 , $0 , 2
	sw		$t1 , 4($sp)
	sw		$s0 , 0($sp)
	jal		call_modulation
	addiu	$t9 , $0 , 8
	addu	$sp , $sp , $t9
	bne		$v1 , $0 , last_case_hailstone
	srl		$s0 , $s0 , 1
	addiu	$t9 , $0 , 4
	subu	$sp , $sp , $t9
	sw		$s0 , 0($sp)
	jal		call_r_hailstone
	addiu	$t9 , $0 , 4
	addu	$sp , $sp , $t9
	addiu	$v0 , $v0 , 1
	j		abort_r_hailstone	
last_case_hailstone:
	addiu	$t9 , $0 , 4
	subu	$sp , $sp , $t9
	sll		$s1 , $s0 , 1
	addu	$s1 , $s1 , $s0
	addiu	$s1 , $s1 , 1
	sw		$s1 , 0($sp)
	jal		call_r_hailstone
	addiu	$t9 , $0 , 4
	addu	$sp , $sp , $t9
	addiu	$v0 , $v0 , 1
	j		abort_r_hailstone	
	  
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
	jal		call_r_hailstone
	addiu	$t9 , $0 , 4
	addu	$sp , $sp , $t9
	addu	$t7 , $v0 , $0
