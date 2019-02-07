#	File		: CountingSort.asm
#	Author		: Supasan Komonlit 
#	Student ID	: 5910503871

.data # declares variavle names used in program and will allocated in main memmory (RAM)

	test	:	.asciiz "abcdefg" 

	count_char		:	.space 1024 # allocate for int32 * 256 element
									 # 1 int32 is 4 bytes so have to allcate 256*4

	string_output	:	.space 1000 # allocate 1000 bytes 
									# so could be used as a 1000-element character
	
						# .asciiz is string terminated by the \0
	print_data		:	.word 0

	string_problem	:	.asciiz "cadljgarhtoxAHdgdsJKhYEasduwBRLsdgHoptxnaseurh" 
	space			:	.asciiz " "
	new_line		:	.asciiz "\n"
	all_member		:	.asciiz "List member : "

.text

.globl main # When start program will run by that label

# Rule in this pattern we will use register number 24 or t8 to for count in element
#					and will use register number 25 or t9 to for + offset to access data
#					and will use register number 25 or t9 to collect about result to jump

main:
	add		$t8 , $0 , $0	

set_member_zero:
	sll		$t9, $t8 , 2			# word have size 4 byte so shift 2 is multi 4

	sw		$0 , count_char($t9)	# save value 0 to member of count_char
	addi	$t8 , $t8 , 1			# t9++
	slti	$t9, $t8 , 257			# first will one if < third and will zero otherwise
	bne		$t9, $0 , set_member_zero # SUM if i < 257 will jump to set_member_zero		

	lw		$t9 , print_data
	add		$t8 , $0 , $0
	beq		$t9 , $0 , count_ASCII # if print_data is zero will jump to count_ASCII

	add		$t8 , $0 , $0
	li		$v0 , 4					# load system call code for type address of string in memory
	la		$a0 , all_member		# load all_member to register waiting print operation
	syscall							# interrupt to print
	la		$a0 , space
	syscall

print_all_member:
	sll		$t9 , $t8 , 2
	li		$v0 , 1				
	lw		$a0 , count_char($t9)
	syscall
	li		$v0 , 4					
	la		$a0 , space
	syscall
	addi	$t8 , $t8 , 1
	slti	$t9 , $t8 , 257
	bne		$t9 , $0 , print_all_member
	li		$v0 , 4					
	la		$a0 , new_line
	syscall
	
	add		$t8 , $0 , $0
count_ASCII:
	lb		$t9 , string_problem($t8) # No shift because 1 byte equal 1 char
	sll		$t6 , $t9 , 2			# Shift bacause size of word
	lw		$t7 , count_char($t6)
	addi	$t7 , $t7 , 1 # count_char[]++
	sw		$t7 , count_char($t6)
	addi	$t8 , $t8 , 1
	bne		$t9 , $0 , count_ASCII

	lw		$t9 , print_data
	addi	$t8 , $0 , 1	# setstart value is 1
	add		$t7 , $0 , $0	# will get t0 to collect previous order
	beq		$t9 , $0 , plus_previous # if print_data is zero will jump to algorithm

	add		$t8 , $0 , $0
	li		$v0 , 4					
	la		$a0 , all_member		
	syscall							
	la		$a0 , space
	syscall
print_after_count:
	sll		$t9 , $t8 , 2
	li		$v0 , 1				
	lw		$a0 , count_char($t9)
	syscall
	li		$v0 , 4					
	la		$a0 , space
	syscall
	addi	$t8 , $t8 , 1
	slti	$t9 , $t8 , 257
	bne		$t9 , $0 , print_after_count
	li		$v0 , 4					
	la		$a0 , new_line
	syscall

	addi	$t8 , $0 , 1	# setstart value is 1
	add		$t7 , $0 , $0	# will get t0 to collect previous order
plus_previous:
	sll		$t6 , $t8 , 2	# shift for change to position of array by current
	sll		$t5 , $t7 , 2	# shift for change to position of array by previous
	lw		$t4 , count_char($t6) # load current value
	lw		$t3 , count_char($t5) # load previous value
	add		$t4 , $t4 , $t3 # result is current_value + previous_value
	sw		$t4 , count_char($t6) # save to current value
	addi	$t8 , $t8 , 1
	addi	$t7 , $t7 , 1
	slti	$t9 , $t8 , 257 # result one is real 0 is false
	bne		$t9 , $0 , plus_previous
	
	lw		$t9 , print_data
	add		$t8 , $0 , $0
	beq		$t9 , $0 , pre_output # if print_data is zero will jump to pre_output

	add		$t8 , $0 , $0
	li		$v0 , 4					
	la		$a0 , all_member		
	syscall							
	la		$a0 , space
	syscall
print_after_sum:
	sll		$t9 , $t8 , 2
	li		$v0 , 1				
	lw		$a0 , count_char($t9)
	syscall
	li		$v0 , 4					
	la		$a0 , space
	syscall
	addi	$t8 , $t8 , 1
	slti	$t9 , $t8 , 257
	bne		$t9 , $0 , print_after_sum
	li		$v0 , 4					
	la		$a0 , new_line
	syscall

	add		$t8 , $0 , $0
pre_output:
	lb		$t9 , string_problem($t8)
	sll		$t7 , $t9 , 2 
	lw		$t6 , count_char($t7)
	addi	$t6 , $t6 , -1
	sb		$t9 , string_output($t6)
	sw		$t6 , count_char($t7)		
	addi	$t8 , $t8 , 1	
	bne		$t9 , $0 , pre_output

	add		$t8 , $0 , $0
output:
	lb		$t9 , string_problem($t8)
	lb		$t7 , string_output($t8)
	addi	$t6 , $t8 , -1
	sb		$t7 , string_problem($t6)
	addi	$t8 , $t8 , 1
	bne		$t9 , $0 , output

	li		$v0 , 4					
	la		$a0 , string_problem
	syscall
	la		$a0 , new_line
	syscall

end:
	ori		$v0 , $0 , 10
	syscall
