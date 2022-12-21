# Mars bot
.eqv HEADING 0xffff8010  	# Integer: An angle between 0 and 359
 				# 0 : North (up)
				# 90: East (right)
 				# 180: South (down)
 				# 270: West (left)
.eqv MOVING 0xffff8050  	#Boolean: whether or not to move
.eqv LEAVETRACK 0xffff8020 	# Boolean (0 or non-0):
 				# whether or not to leave a track
.eqv WHEREX 0xffff8030 		# Integer: Current x-location of MarsBot
.eqv WHEREY 0xffff8040		# Integer: Current y-location of MarsBot
# Key matrix
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014
.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012

.data
# postscript-DCE => numpad 0
# (rotate,time,0=untrack | 1=track;)
pscript1: .asciiz "90,200,0;180,200,0;180,540,1;80,48,1;70,48,1;60,48,1;50,48,1;40,48,1;30,48,1;20,48,1;10,48,1;0,48,1;350,48,1;340,48,1;330,48,1;320,48,1;310,48,1;300,48,1;290,48,1;280,48,1;90,800,0;270,50,1;260,50,1;250,50,1;240,50,1;230,50,1;220,50,1;210,50,1;200,50,1;190,50,1;180,50,1;170,50,1;160,50,1;150,50,1;140,50,1;130,50,1;120,50,1;110,50,1;100,50,1;90,100,1;90,500,0;270,200,1;0,540,1;90,200,1;180,270,0;270,200,1;90,300,0;"
# postscript-BAO => numpad 4
pscript2: .asciiz "90,1000,0;180,3000,0;180,5790,1;80,250,1;70,250,1;60,250,1;50,250,1;40,250,1;30,250,1;20,250,1;10,250,1;0,250,1;350,250,1;340,250,1;330,250,1;320,250,1;310,250,1;300,250,1;290,250,1;280,250,1;80,250,1;70,250,1;60,250,1;50,250,1;40,250,1;30,250,1;20,250,1;10,250,1;0,250,1;350,250,1;340,250,1;330,250,1;320,250,1;310,250,1;300,250,1;290,250,1;280,250,1;90,5000,0;210,6200,1;30,6200,0;150,6200,1;330,3800,0;270,2400,1;30,2400,0;90,8000,0;90,250,1;100,500,1;110,500,1;120,500,1;130,500,1;140,500,1;150,500,1;160,500,1;170,500,1;180,500,1;190,500,1;200,500,1;210,500,1;220,500,1;230,500,1;240,500,1;250,500,1;260,500,1;270,500,1;280,500,1;290,500,1;300,500,1;310,500,1;320,500,1;330,500,1;340,500,1;350,500,1;0,500,1;10,500,1;20,500,1;30,500,1;40,500,1;50,500,1;60,500,1;70,500,1;80,500,1;90,250,1;"
# postscript-flag => numpad 8
pscript3: .asciiz "90,300,0;180,300,0;180,500,1;90,900,1;0,500,1;270,900,1;90,450,0;180,100,0;210,100,1;270,130,1;127,140,1;210,100,1;64,130,1;127,130,1;345,100,1;50,140,1;270,140,1;330,100,1;0,2000,0;"
.text
# <--xu ly tren keymatrix-->
	li $t3, IN_ADRESS_HEXA_KEYBOARD		#t3 = IN_KEYBROAD
	li $t4, OUT_ADRESS_HEXA_KEYBOARD	#t4 = OUT_KEYBROAD
#<-- check iput from Digital lab sim -->
polling: 
	li $t5, 0x01 # row-1 of key matrix
	sb $t5, 0($t3) 
	lb $a0, 0($t4) 
	bne $a0, 0x11, NOT_NUMPAD_0 #neu khong phai 0
	la $a1, pscript1
	j START
	
	NOT_NUMPAD_0:
	li $t5, 0x02 # row-2 of key matrix
	sb $t5, 0($t3)
	lb $a0, 0($t4)
	bne $a0, 0x12, NOT_NUMPAD_4 #neu khong phai 4
	la $a1, pscript2
	j START
	NOT_NUMPAD_4:
	li $t5, 0X04 # row-3 of key matrix
	sb $t5, 0($t3)
	lb $a0, 0($t4)
	bne $a0, 0x14, COME_BACK # neu khong phai 8
	la $a1, pscript3
	j START
COME_BACK: j polling # khi cac so 0,4,8 khong duoc chon -> quay lai doc tiep
# <!--end-->

# <--xu li mars bot -->
START:
	jal GO 
	nop
READ_PSCRIPT: 
	addi $t0, $zero, 0 # luu gia tri rotate
	addi $t1, $zero, 0 # luu gia tri time
	
 	READ_ROTATE:
 	add $t7, $a1, $t6 # dich bit
	lb $t5, 0($t7)  # doc cac ki tu cua pscript
	beq $t5, 0, END  # ket thuc pscript 
 	beq $t5, 44, READ_TIME # gap ki tu ',' 44 = ','
 	mul $t0, $t0, 10 
 	addi $t5, $t5, -48 # So 0 co thu tu 48 trong bang ascii.
 	add $t0, $t0, $t5  # cong cac chu so lai voi nhau.
 	addi $t6, $t6, 1 # tang so bit can dich chuyen len 1
 	j READ_ROTATE # quay lai doc tiep den khi gap dau ','
 	
 	READ_TIME: # doc thoi gian chuyen dong.
 	add $a0, $t0, $zero
	jal ROTATE 
	nop
 	addi $t6, $t6, 1
 	add $t7, $a1, $t6 # ($a1 luu dia chi cua pscript)
	lb $t5, 0($t7) 
	beq $t5, 44, READ_TRACK # gap ki tu ','
	mul $t1, $t1, 10
 	addi $t5, $t5, -48
 	add $t1, $t1, $t5
 	j READ_TIME # quay lai doc tiep den khi gap dau ','
 	
 READ_TRACK:
 	addi $v0,$zero,32 # Keep mars bot running by sleeping with time=$t1
 	add $a0, $zero, $t1
 	addi $t6, $t6, 1 
 	add $t7, $a1, $t6
	lb $t5, 0($t7) 
 	addi $t5, $t5, -48
 	beq $t5, $zero, CHECK_UNTRACK # 1=track | 0=untrack
 	jal UNTRACK
 	nop
	jal TRACK
	nop
	j INCREAMENT
	
CHECK_UNTRACK:
	jal UNTRACK
	nop
INCREAMENT:
	syscall
 	addi $t6, $t6, 2 # bo qua dau ';'
 	j READ_PSCRIPT
#-----------------------------------------------------------
# GO procedure, to start running
# param[in] none
#-----------------------------------------------------------
GO: 
 	li $at, MOVING 		# change MOVING port
 	addi $k0, $zero,1 	# to logic 1,
 	sb $k0, 0($at) 		# to start running
 	nop
 	jr $ra
 	nop
#-----------------------------------------------------------
# STOP procedure, to stop running
# param[in] none
#-----------------------------------------------------------

STOP: 
	li $at, MOVING 		#change MOVING port to 0
 	sb $zero, 0($at)	# to stop	
 	nop
 	jr $ra
	nop
#-----------------------------------------------------------
# TRACK procedure, to start drawing line 
# param[in] none
#-----------------------------------------------------------
TRACK: 
	li $at, LEAVETRACK 	#change LEAVETRACK port
 	addi $k0, $zero,1 	# to logic 1
	sb $k0, 0($at) 		# to start tracking
	nop
 	jr $ra
	nop
#-----------------------------------------------------------
# UNTRACK procedure, to stop drawing line
# param[in] none
#-----------------------------------------------------------
UNTRACK:
	li $at, LEAVETRACK  #change LEAVETRACK port to 0
 	sb $zero, 0($at) # to stop drawing tail
	nop
 	jr $ra
	nop
	#-----------------------------------------------------------
# ROTATE procedure, to rotate the robot
# param[in] $a0, An angle between 0 and 359
# 0 : North (up)
# 90: East (right)
# 180: South (down)
# 270: West (left)
#-----------------------------------------------------------
ROTATE: 
	li $at, HEADING # change HEADING port
 	sw $a0, 0($at) 	# to rotate robot
 	nop
 	jr $ra
 	nop
END:
	jal STOP
	li $v0, 10
	syscall
	j polling
# <!--end-->
