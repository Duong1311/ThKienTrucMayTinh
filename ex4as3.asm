#Laboratory Exercise 4, Home Assignment 3
.text 
start:
 	li $s1, -20
 	# abs $s9, s1
 	bgtz $s1, case1
 	sub $s0,$zero, $s1
 case1:
 	# move $s0,s1
 	and $s0,$s1,$s1
 	# not $s0
 	nor $s0,$s0,$s0
 	# ble $s1,s2,L
 	li 	$s2,-10
 	sub 	$s3,$s2,$s1
 	bltz	$s3, case3
 L:
 case3:
 	 