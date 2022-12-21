.data
A: .word 7, -2, 5, 1, 5,6,7,3,6,8,8,59,5
Aend: .word
.text
main:
la $a0,A #$a0 = Address(A[0])
la $a1,Aend
j sort #sort
after_sort:
li $v0, 10#exit
syscall
end_main:
sort:
addi $a1,$a1,-4 #$a1 = Address(A[n-1])
beq $a0,$a1,after_sort#single element list is sorted
addi $t0,$a0,0 #init next pointer to first
loop:
beq $t0,$a1,sort
lw $t1,0($t0) #$t1 = a(i)
lw $t2,4($t0) #$t2 = a(i+1)
slt $t3,$t1,$t2 #(i)<(i+1) ?
beq $t3,$zero,next#if (i+1)<=(i), repeat
sw $t1,4($t0) # a(i+1)= $t1
sw $t2,0($t0) # a(i) = $t2
j loop
next:
addi $t0,$t0,4 #advance to next element
j loop
