#	FILE	: insertion_sort_recursive.asm
#	Name	: Supasan Komonlit
#	ID		: 5910503871	
#	Create	: 2019, FEB 07

.data
	problem		: .word 132470, 324545, 73245, 93245, 80324542, 244, 2, 66, 236, 327, 236, 21544
	size_problem: .word 12
	temp_data	: .space 1024 # reserve word array max 256 element < 4 * 256 = 1024 >

.text

# I Will write pattern of C when pass array to function will send address to
.globl main

main:
	la		$t0 , problem			# save address problem to register t0
	lw		$t1 , size_problem		# save size of array problem to register t1
	
	addiu	$sp , $sp , -8			# Reserve 2 argument to function 2 word = 8 byte
	sw		$t1 , 4($sp)
	sw		$t0 , 0($sp)

end:
	ori		$v0 , $0 , 10
	syscall
