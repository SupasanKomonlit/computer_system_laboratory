#	FILE	: insertion_sort_recursive.asm
#	Name	: Supasan Komonlit
#	ID		: 5910503871	
#	Create	: 2019, FEB 07

.data
	problem		: .word 132470, 324545, 73245, 93245, 80324542, 244, 2, 66, 236, 327, 236, 21544
	size_problem: .word 12
	temp_data	: .space 1024 # reserve word array max 256 element < 4 * 256 = 1024 >

	single_space: .asciiz " "
	new_line	: .asciiz "\n"

.text

.globl main # I Will write pattern of C when pass array to function will send address to

insertionSortRecursive_0:			# We have to use s0 and s1 to collect argument received
	addiu	$sp , $sp , -16			# Reserve 4 word for s0 s1 ra and olf fp
	sw		$s1 , 12($sp)			# save old value of s1
	sw		$s0 , 8($sp)			# save old value of s0
	sw		$ra , 4($sp)			# store ra what address I will jump after finish
	sw		$fp	, 0($sp)			# store old frame point
	move	$fp , $sp				# assign new frame point is current frame point
	lw		$s0 , 16($fp)			# load first argument
	lw		$s1 , 20($fp)			# load second argument
	slti	$t0 , $s1 , 2			# if s1 <= 1 or s1 < 2 --> t0 = 1
	beq		$t0 , $0 , insertionSortRecursive_1
	lw		$s1 , 12($fp)			# return old s1
	lw		$s0 , 8($fp)			# return old s0
	lw		$ra , 4($fp)			# get address for jump return
	lw		$fp , 0($fp)			# return old frame
	addiu	$sp , $sp , 16
	jr		$ra
insertionSortRecursive_1: # assign t0 == last, t1 == j 
	addi	$t2 , $s1 , -2			# n-2 want -1 but have -2 because start at 0
	sll		$t3 , $t2 , 2			# size *4
	add		$t3 , $t3 , $s0			# plus offset get position
	lw		$t0 , ($t3)				# load word to last
	addi	$t1 , $t2 , -1			# n-3 want -2 but have -3 because start at 0
insertionSortRecursive_2:

print_word_array:
	addiu	$sp , $sp , -8			# Reserve 2 argument to save return address and old fp
	sw		$ra , 4($sp)			# store ra
	sw		$fp , 0($sp)			# store old frame point
	move	$fp , $sp				# assign new frame point is current frame point
	lw		$t0 , 8($fp)			# load address of array point
	lw		$t1 , 12($fp)			# load length of address
	add		$t2 , $0 , $0			# count order array
loop_print_word_array:
	sll		$t3 , $t2 , 2			# for plus offset to get value
	li		$v0 , 1					# load code for print integer
	add		$t3 , $t3 , $t0			# plus offset to final address
	lw		$a0 , ($t3)				# load data of in address by t3
	syscall
	li		$v0 , 4				
	la		$a0 , single_space
	syscall
	addi	$t2 , $t2 , 1
	slt		$t4 , $t2 , $t1			# if t2 < t1 --> t4 = 1
	bne		$t4 , $0 , loop_print_word_array 
	la		$a0 , new_line
	syscall
	lw		$ra , 4($fp)
	lw		$fp , 0($fp)
	addiu	$sp , $sp , 8
	jr		$ra

main:
	la		$t0 , problem			# save address problem to register t0
	lw		$t1 , size_problem		# save size of array problem to register t1	
	addiu	$sp , $sp , -8			# Reserve 2 argument to function 2 word = 8 byte
	sw		$t1 , 4($sp)
	sw		$t0 , 0($sp)
	jal		print_word_array		# Jump to function print_word_array
	addiu	$sp , $sp , 8			# Return stack point

end:
	ori		$v0 , $0 , 10
	syscall
