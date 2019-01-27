# Add number in array
# command of slti can study on http://www.mrc.uidaho.edu/mrc/people/jff/digital/MIPSir.html
.data

sum :	.word 0
i :		.word 0
array_a:.word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19

array_b:.word 0x7fffffff, 0x7ffffffe, 0x7ffffffd, 0x7ffffffc, 0x7ffffffb, 0x7ffffffa, 0x7ffffff9 ,0x7ffffff8 ,0x7ffffff7, 0x7ffffff6


sum_a :	.asciiz "Sum a = "
sum_b : .asciiz "Sum b = "
new_line : .asciiz "\n"

.text

.globl main #call main by SPIM

main:
	# $0 is always zero because struct of register
	lw		$9 , i	 # assign $9 is i
	lw		$10, sum # assign $10 is sum 

loop1:
	lw		$11, array_a($9)			# load data of a[$9] to $11
	add		$10, $10 , $11		# $10 = $10 + $11 ( $10 is sum)
	addi	$9 , $9 , 4			# $9++ ( $9 is i) 
								#	plus 4 because one each mem is 4 byte
	slti	$12, $9 , 80		# use command if $9 = 20 it make $12 = 1 else $12 = 0
	bne		$12 , $0 , loop1	# $0 will always have value equal 0
	
	li		$2 , 4				# $2 in register is $v0 and 4 is code for print string 
								#	this code will print value in $a0 is $4
	la		$4 , sum_a
	syscall

	li		$2 , 1
	move	$4 , $10
	syscall

	li		$2 , 4
	la		$4 , new_line
	syscall

	lw		$9 , i
	lw		$10 , sum

loop2:
	lw		$11, array_b($9)			# load data of a[$9] to $11
	addu	$10, $10 , $11		# $10 = $10 + $11 ( $10 is sum)
	addi	$9 , $9 , 4			# $9+=4 ( $9 is i) 
								#	plus 4 because one each mem is 4 byte
	slti	$12, $9 , 40		# use command if $9 = 20 it make $12 = 1 else $12 = 0
	bne		$12 , $0 , loop2	# $0 will always have value equal 0
	
	li		$2 , 4				# $2 in register is $v0 and 4 is code for print string 
								#	this code will print value in $a0 is $4
	la		$4 , sum_b
	syscall

	li		$2 , 1
	move	$4 , $10
	syscall

	li		$2 , 4
	la		$4 , new_line
	syscall
	
	

end:
