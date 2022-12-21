.data
	A: 	.word 7,3,4,5,6
	Aend: 	.word
.text
main: 	la 	$a0,A
	la	$a1,Aend
	addi	$a1,$a1,-4
	
	addi $s7,$s7,1	#do dai mang
	
	addi $t9,$0,1	#dung de so sanh
	
	
	j sort
	
	
sort: 	beq 	$a0,$a1,end
	j 	max

	
max:		
	addi $t0,$a0,0
demdodai:
	beq $t0,$a1,ret
	addi $s7,$s7,1
	addi $t0,$t0,4
	j	demdodai

ret:
	addi $s6,$0,1	#dem so looix
	#addi $s0, $0, 1000 # n = 1000
	addi $s4, $0, 1    # i = 1
FOR:
	slt 	$t0, $s4, $s7  # $t0 = i < n?
	bne 	$t0, $0, END   # if !(i < n) goto END
	
	add 	$s5,$s4,$s4 #put 2i in $s5
	add 	$s5,$s5,$s5 #put 4i in $s5
	add 	$t3,$t2,$a0 #put 4i+A (address of A[i]) in $t3
	lw 	$v1,0($t3)	#gia tri i
	lw 	$k1,-4($t3)	#gia tri i-1
	slt 	$t2,$v1,$k1	#i<=i-1
	bne 	$t2,$zero,sum	#neu i<=i-1 thi tang loi
	j	FOR		
sum:	
	addi 	$s6,$s6,1	
	
	slt 	$t2,$t9,$s6	#1<so loi $s6
	bne 	$t2,$zero,false
false:
	addi	$t8,$0,1	#xuat ket qua
	
	lw 	$v0,-8($t3)	#gia tri i-2
	lw 	$k0,4($t3)	#gia tri i+1
	slt 	$t2,$v1,$v0
	slt 	$t4,$k0,$k1
	add	$t5,$t2,$t4
	beq 	$t5,2,false2

false2:
	addi	$t8,$0,1
	
	
	
	
	
	
	
	
	addi $s4, $s4, 1   # i = i + 1
	j	 FOR
END:	
		

end:	