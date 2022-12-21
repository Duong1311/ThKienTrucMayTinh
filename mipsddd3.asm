baz:
    ori $s0, $0, 0
    jr $ra
bar:
    ori $s0, $0, 1
    jal baz
    slt $s1, $0, $s0
    jr $ra
foo:
    ori $s0, $0, 2
    jal bar
    jr $ra