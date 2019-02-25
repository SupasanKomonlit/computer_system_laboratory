# FILE		:	test_mips_single.s
# AUTHOR	:	Supasan Komonlit
# Date		:	2019 , FEB 25

# First time for run file we will reset sp for reserve and ra
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


# When program close we will j for get pc to zero
	j		start
