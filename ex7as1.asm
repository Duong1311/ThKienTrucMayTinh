main:
	addi $s0, $zero, 13	#load value 
	addi $s1, $zero, -11
	addi $s2, $zero, 2001
	addi $s3, $zero, -3
	addi $s4, $zero, 3
	addi $s5, $zero, 1996
	addi $s6, $zero, 5
	addi $s7, $zero, 17
	
	addi $t1, $zero, 1	#load default value
	addi $t2, $zero, 1
	addi $t3, $zero, 1
	jal init
	nop
	addi $t4, $zero, 9
	sub $a0, $t4, $t2 	#a0 = t4 -t2
	sub $a1, $t4, $t3 	#ai = t4 -t3
	j end
	nop
endmain:
init:
	add $v0, $s7, $zero
	add $v1, $s7, $zero
push:
	addi $sp, $sp, -32	#push turn value of $s0 -> $s7 into stack
	sw $s0, 28($sp)
	sw $s1, 24($sp)
	sw $s2, 20($sp)
	sw $s3, 16($sp)
	sw $s4, 12($sp)
	sw $s5, 8($sp)
	sw $s6, 4($sp)
	sw $s7, 0($sp)
pop:
	addi $sp, $sp, 4	#pop out of stack
	lw $a1, 0($sp)
	addi $t1, $t1, 1
	sub $t0, $a1, $v0
	bltz $t0, case1		#branch if less than zero (t1 < 0)
	nop 
	add $v0, $a1, $zero
	add $t2, $t1, $zero
case1:
	sub $t0, $a1, $v1 
	bgtz $t0, case2 
	nop
	add $v1, $a1, $zero
	add $t3, $t1, $zero
case2:	
	bne $a1, $s0, pop 	# branch ì not equal
	nop
done:
	jr $ra 
				#Largest: $v0, $a0
				# Smallest: $v1, $a1
end: