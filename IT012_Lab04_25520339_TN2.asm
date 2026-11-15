# Ma nguon 5 - phan bac dien nang
.data
prompt: .asciiz "Nhap dien nang (kWh): "
msg:    .asciiz "Bac: "
nl:     .asciiz "\n"

.text
.globl main
main:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    add $s0, $v0, $zero

    slti $t0, $s0, 101
    bne  $t0, $zero, Bac1
    
    slti $t0, $s0, 151
    bne  $t0, $zero, Bac2

    slti $t0, $s0, 201
    bne  $t0, $zero, Bac3

    j    Bac4  
    
Bac1:
    addi $s1, $zero, 1
    j    InKetQua

Bac2:
    addi $s1, $zero, 2
    j    InKetQua

Bac3:
    addi $s1, $zero, 3
    j    InKetQua

Bac4:
    addi $s1, $zero, 4

InKetQua:
    li $v0, 4
    la $a0, msg
    syscall

    li $v0, 1
    add $a0, $s1, $zero
    syscall

    li $v0, 4
    la $a0, nl
    syscall

    li $v0, 10
    syscall