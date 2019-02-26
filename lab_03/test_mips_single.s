# FILE		:	test_mips_single.s
# AUTHOR	:	Supasan Komonlit
# ID		:	5910503871
# Date		:	2019 , FEB 25

# First time for run file we will reset sp for reserve and ra
init_program:
	beq		$0 , $0 , start

set_zero_t:
	addu	$t0 , $0 , $0
	addu	$t1 , $0 , $0
	addu	$t2 , $0 , $0
	addu	$t3 , $0 , $0
	addu	$t4 , $0 , $0
	addu	$t5 , $0 , $0
	addu	$t6 , $0 , $0
	addu	$t7 , $0 , $0
	addu	$t8 , $0 , $0
	addu	$t9 , $0 , $0
	jr		$ra

start:
	addiu	$sp , $0 , 32767
	addiu	$sp , $sp , 32767
	addiu	$sp , $sp , 2
# Try to reserve array of int (fullword) 2^4 2^8 2^12 2^16
# label is first_array start at mem zero
	addiu	$sp , $sp , -16
	addiu	$t1 , $0 , 1
	sll		$t1 , $t1 , 4
	sw		$t1 , 0($sp)
	addiu	$t2 , $0 , 4
	sllv	$t1 , $t1 , $t2
	sw		$t1 , 4($sp)
	sllv	$t1 , $t1 , $t2
	sw		$t1 , 8($sp)
	lui		$t1 , 1
	sw		$t1 , 12($sp)
	lw		$t1 , 0($sp)
	lw		$t2 , 4($sp)
	lw		$t3 , 8($sp)
	lw		$t4 , 12($sp)
# This above code will testing about load and save word and shift left
# Next I will test about shift right by first time we will move one to bit 31
	lui		$t0 , 1
	sll		$t0 , $t0 , 15
	sra		$t1 , $t0 , 31 
	srl		$t2 , $t0 , 31
	lw		$t3 , 4($sp)
	lw		$t4 , 0($sp)
	subu	$t3 , $t3 , $t4
# Now I will test about and or xor nor
# By reserve t0 for -1 in 32 bit and reserve t1 for all 1 and t2 & t3 for testing
	and		$t4 , $t3 , $t1
	nor		$t5 , $t3 , $t1  
	or		$t6 , $t3 , $t2
	xor		$t7 , $t1 , $t3
	bne		$t5 , $t4 , test_operator_logic_imm
	j		start

test_operator_logic_imm:
	andi	$t4 , $t3 , 0
	ori		$t6 , $t2 , 0xffff
	xori	$t7 , $t1 , 0x00ff
	jal		set_zero_t

# Next we will test about compare operator
	lw		$t0 , 4($sp)
	slti	$t1 , $t0 , 1
	sltiu	$t2 , $t0 , -1
	slti	$t3 , $t0 , -1
	addiu	$t1 , $0 , 1
	sll		$t1 , $t1 , 31
	slt		$t3 , $t1 , $t2
	sltu	$t4 , $t1 , $t2

# The Last will check about save load byte
	jal		set_zero_t
	lui		$t0 , 0xffff
	addiu	$t0 , $t0 , 0xf
	addiu	$sp , $sp , -4
	sb		$t0 , 0($sp)
	sb		$t0 , 2($sp)
	lw		$t1 , 2($sp)
	lw		$t2 , 0($sp)
	

# When program close we will j for get pc to zero
	j		init_program
