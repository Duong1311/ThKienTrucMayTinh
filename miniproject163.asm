.data
	A: 	.word 1,5,2,3,4,5
	Aend: 	.word
	Message: .asciiz "Ket qua:"
	Address1: .asciiz " TRUE"
	Address2: .asciiz " FALSE"
.text
main: 	la 	$a0,A
	la	$a1,Aend
	addi	$a1,$a1,-4
	
	addi 	$s7,$s7,1	#do dai mang
	addi 	$s6,$0,0	#count = 0
	addi 	$s5,$0,-1	#index = -1
	

	
sort: 	beq 	$a0,$a1,end
			
	addi 	$t0,$a0,0
demdodai:beq 	$t0,$a1,ret
	addi 	$s7,$s7,1
	addi 	$t0,$t0,4
	j	demdodai

ret:	addi 	$s1, $0, 1    # i = 1

FOR:	slt 	$t0, $s1, $s7  # $t0 = i < n?
	beq 	$t0, $0, ENDFOR   # if !(i < n) goto END
	
	add 	$t1,$s1,$s1 #put 2i in $t1
	add 	$t1,$t1,$t1 #put 4i in $t1
	add 	$t2,$t1,$a0 #put 4i+A (address of A[i]) in $t2
	lw 	$v0,0($t2)	#gia tri i
	lw 	$v1,-4($t2)	#gia tri i-1
	blt 	$v1,$v0,koup 
	addi 	$s6,$s6,1	#count
	addi 	$s5,$s1,0	#index = i
	koup:
	addi 	$s1, $s1, 1   # i = i + 1
	j 	FOR


ENDFOR:	ble 	$s6,1,continue
	j 	false
	continue:	
	bnez 	$s6,continue2
	j 	true
	continue2:
	
	addi 	$k0,$s7,-1
	beq 	$s5,$k0,true
	beq 	$s5,1,true
	
	addi 	$s4,$s5,0
	add 	$t1,$s4,$s4
	add 	$t1,$t1,$t1
	add 	$s3,$a0,$t1
	
	lw  	$v0,-4($s3)	#index -1
	lw  	$v1,4($s3)	#index +1
	bge 	$v0,$v1,continue3  
	j 	true
	continue3:
	
	addi 	$k1,$s5,-2
	bltz 	$k1,continue4  
	
	lw  	$v0,-8($s3) #index -2
	lw  	$v1,0($s3)	#index 
	bge 	$v0,$v1,continue4
	j	true
	continue4:
	
	bltz 	$s5,true 
	j false

true:	li 	$v0, 59
	la 	$a0, Message
	la 	$a1, Address1
	syscall
	j end
	
false:	li $v0, 59
	la $a0, Message
	la $a1, Address2
	syscall
end:


	
