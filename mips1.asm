
.data
Message1: .asciiz "The sum of "
Message2: .asciiz " and "
Message3: .asciiz " is "
re: .word 0

.text

li $v0, 4
la $a0, Message1
syscall

li $v0, 1
li $a0, 3 
add $s1,$zero,$a0

syscall 

li $v0, 4
la $a0, Message2
syscall

li $v0, 1
li $a0, 4
add $s2,$zero,$a0
syscall

li $v0, 4
la $a0, Message3
syscall 

add $s3,$s1,$s2
sw $s3,re

li $v0, 1
lw $a0, re
syscall 





