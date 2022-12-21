die:
    nor $s0, $0, $0
    jr $ra

man:
    jal die
    or $s0, $0, $0

woman:
    jal die
    lui $t0, 0x0000
    ori $s0, $t0, 0xffff