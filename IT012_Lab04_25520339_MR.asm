.data
m1:      .asciiz "Thang "
m2:      .asciiz ": "
mt:      .asciiz "Tong: "
mm:      .asciiz "Thang cao nhat: "
lp:      .asciiz " ("
rp:      .asciiz ")"
mb:      .asciiz "Bac "
nl:      .asciiz "\n"
reading: .word 1000, 1095, 1205, 1345, 1510, 1715, 1955
         .word 2210, 2440, 2625, 2775, 2895, 2995
usage:   .space 48
cnt:     .word 0, 0, 0, 0

.text
.globl main
main:
    la   $s0, reading
    la   $s1, usage
    addi $s2, $zero, 0
    addi $s3, $zero, 12
    addi $s4, $zero, 0
    addi $s5, $zero, -1
    addi $s6, $zero, 0

Loop:
    beq  $s2, $s3, EndLoop1

    sll  $t1, $s2, 2
    add  $t2, $s0, $t1
    lw   $t3, 0($t2)
    lw   $t4, 4($t2)

    sub  $t5, $t4, $t3
    add  $t6, $s1, $t1
    sw   $t5, 0($t6)

    add  $s4, $s4, $t5

    slt  $t7, $s5, $t5
    beq  $t7, $zero, PrintMonth
    add  $s5, $t5, $zero
    addi $s6, $s2, 1

PrintMonth:
    li   $v0, 4
    la   $a0, m1
    syscall

    li   $v0, 1
    addi $a0, $s2, 1
    syscall

    li   $v0, 4
    la   $a0, m2
    syscall

    li   $v0, 1
    add  $a0, $t5, $zero
    syscall

    li   $v0, 4
    la   $a0, nl
    syscall

    addi $s2, $s2, 1
    j    Loop

EndLoop1:
    li   $v0, 4
    la   $a0, mt
    syscall
    li   $v0, 1
    add  $a0, $s4, $zero
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 4
    la   $a0, mm
    syscall
    li   $v0, 1
    add  $a0, $s6, $zero
    syscall
    li   $v0, 4
    la   $a0, lp
    syscall
    li   $v0, 1
    add  $a0, $s5, $zero
    syscall
    li   $v0, 4
    la   $a0, rp
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall

    la   $s7, cnt
    addi $s2, $zero, 0

CountLoop:
    beq  $s2, $s3, PrintCnt

    sll  $t1, $s2, 2
    add  $t2, $s1, $t1
    lw   $t3, 0($t2)

    slti $t0, $t3, 101
    bne  $t0, $zero, SetIdx0

    slti $t0, $t3, 151
    bne  $t0, $zero, SetIdx1

    slti $t0, $t3, 201
    bne  $t0, $zero, SetIdx2

    addi $t4, $zero, 3
    j    UpdateCnt

SetIdx0:
    addi $t4, $zero, 0
    j    UpdateCnt
SetIdx1:
    addi $t4, $zero, 1
    j    UpdateCnt
SetIdx2:
    addi $t4, $zero, 2

UpdateCnt:
    sll  $t5, $t4, 2
    add  $t5, $s7, $t5
    lw   $t6, 0($t5)
    addi $t6, $t6, 1
    sw   $t6, 0($t5)

    addi $s2, $s2, 1
    j    CountLoop

PrintCnt:
    addi $s2, $zero, 0
    addi $t7, $zero, 4

PrintCntLoop:
    beq  $s2, $t7, Done

    li   $v0, 4
    la   $a0, mb
    syscall

    li   $v0, 1
    addi $a0, $s2, 1
    syscall

    li   $v0, 4
    la   $a0, m2
    syscall

    sll  $t1, $s2, 2
    add  $t2, $s7, $t1
    lw   $a0, 0($t2)
    li   $v0, 1
    syscall

    li   $v0, 4
    la   $a0, nl
    syscall

    addi $s2, $s2, 1
    j    PrintCntLoop

Done:
    li   $v0, 10
    syscall