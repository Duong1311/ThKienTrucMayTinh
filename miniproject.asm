.data
	A: 	.word 7,3,4,5,6
	Aend: 	.word
	B: 	.word 
.text
main: 	la 	$a0,A
	la	$a1,Aend
	addi	$a1,$a1,-4
	j sort
	
	
sort: 	beq 	$a0,$a1,end
	j 	max




deletet:	
	beq 	$s0,$a1,reset
	#addi 	$s0,$t0,-4	#dia chi gia tri c?n xóa 
	lw 	$s1,4($s0)	#lay gia tri cua phan tu sau nó
	sw 	$s1,0($s0)	#ghi gia tri sau no vao gia tri can xoa
	addi	$s0,$s0,4
	j	deletet

deletes:	
	beq 	$s2,$a1,reset
	#addi 	$s0,$t0,-4	#dia chi gia tri c?n xóa 
	lw 	$s3,4($s2)	#lay gia tri cua phan tu sau nó
	sw 	$s3,0($s2)	#ghi gia tri sau no vao gia tri can xoa
	addi	$s2,$s2,4
	j	deletes

reset:
	addi 	$t0,$a0,0
	sw 	$zero,0($a1)
	addi 	$a1,$a1,-4		#vi da xoa di 1 phan tu 
	
max:	
	addi 	$t0,$a0,0	#con tro next
loop:
	beq 	$t0,$a1,end #if next=last, return
	#addi 	$v0,$a0,0 	#dia tri so i
	lw 	$v1,0($t0)	#gia tri i
	lw 	$k1,4($t0)	#gia tri i+1
	addi 	$t0,$t0,4	#cat nhat con tro
	slt 	$t2,$v1,$k1
	bne 	$t2,$zero,loop
	
	addi 	$s2,$t0,0	#dia chi gia tri sau can xoa 
	addi 	$s0,$t0,-4	#dia chi gia tri truoc can xoa 
	addi 	$t6,$t6,1
	beq 	$t6,2,sai1
	j  	deletet
	
end:	
	addi 	$s6,$s6,1
 	
sai1:	
	li	$s6,-1
	j	restore
restore: 
	
	
		
	
