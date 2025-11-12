	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $s0, 8
	add $v1, $s0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s0, $v0
	li $s1, 8
	add $v1, $s1, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s1, $v0
	la $s2, T_init
	sw $s2, 0($s0)
	la $s2, T_start
	sw $s2, 4($s0)
	li $s2, 0
	sw $s2, 4($s1)
	sw $s0, 0($s1)
	move $s0, $s1
	lw $s1, 0($s0)
	lw $t9, 4($s1)
	move $s1, $t9
	move $a0, $s0
	jalr $s1
	move $s0, $v0
	move $a0, $s0
	jal _print
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	j $ra

	.text
	.globl T_start
T_start:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 40
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	move $s1, $s0
	lw $s2, 0($s1)
	lw $t9, 0($s2)
	move $s2, $t9
	move $a0, $s1
	jalr $s2
	move $s1, $v0
	move $s1, $s0
	lw $s2, 0($s1)
	lw $t9, 0($s2)
	move $s2, $t9
	move $a0, $s1
	jalr $s2
	move $s1, $v0
	lw $s2, 0($s1)
	li $s3, 8
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	li $s4, 8
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, A_init
	sw $s5, 0($s3)
	la $s5, A_getX
	sw $s5, 4($s3)
	li $s5, 0
	sw $s5, 4($s4)
	sw $s3, 0($s4)
	move $s3, $s4
	lw $s4, 0($s3)
	lw $t9, 0($s4)
	move $s4, $t9
	li $s5, 5
	li $s6, 8
	add $v1, $s6, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s6, $v0
	la $s7, _LAMBDA_0
	sw $s7, 0($s6)
	sw $s0, 4($s6)
	move $a0, $s3
	move $a1, $s5
	move $a2, $s6
	jalr $s4
	move $s3, $v0
	move $a0, $s1
	move $a1, $s3
	jalr $s2
	move $s1, $v0
	lw $s2, 0($s1)
	lw $t9, 4($s2)
	move $s2, $t9
	move $a0, $s1
	jalr $s2
	move $s1, $v0
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	addu $sp, $sp, 40
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl T_init
T_init:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	move $s0, $a0
	li $s1, 10
	li $s1, 8
	add $v1, $s1, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s1, $v0
	li $s2, 8
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	la $s3, A_init
	sw $s3, 0($s1)
	la $s3, A_getX
	sw $s3, 4($s1)
	li $s3, 0
	sw $s3, 4($s2)
	sw $s1, 0($s2)
	move $s1, $s2
	sw $s1, 4($s0)
	li $s1, 8
	add $v1, $s1, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s1, $v0
	la $s2, _LAMBDA_1
	sw $s2, 0($s1)
	sw $s0, 4($s1)
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	addu $sp, $sp, 24
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl A_init
A_init:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 28
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	li $s3, 10
	sw $s3, 4($s0)
	move $s3, $s2
	lw $s4, 0($s3)
	move $a0, $s3
	move $a1, $s0
	jalr $s4
	move $s3, $v0
	lw $s4, 0($s3)
	lw $t9, 4($s4)
	move $s4, $t9
	move $a0, $s3
	jalr $s4
	move $s3, $v0
	add $v1, $s1, $s3
	move $t9, $v1
	move $s3, $t9
	sw $s3, 4($s0)
	move $s3, $s0
	move $v0, $s3
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	addu $sp, $sp, 28
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl A_getX
A_getX:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	move $s0, $a0
	lw $s1, 4($s0)
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addu $sp, $sp, 16
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_init
B_init:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 28
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	move $s0, $a0
	move $s1, $a1
	mul $v1, $s1, $s1
	move $t9, $v1
	move $s2, $t9
	sw $s2, 4($s0)
	li $s2, 8
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	li $s3, 8
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	la $s4, B_init
	sw $s4, 0($s2)
	la $s4, B_getX
	sw $s4, 4($s2)
	li $s4, 0
	sw $s4, 4($s3)
	sw $s2, 0($s3)
	move $s2, $s3
	li $s2, 8
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	li $s3, 8
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	la $s4, A_init
	sw $s4, 0($s2)
	la $s4, A_getX
	sw $s4, 4($s2)
	li $s4, 0
	sw $s4, 4($s3)
	sw $s2, 0($s3)
	move $s2, $s3
	move $s2, $s0
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	addu $sp, $sp, 28
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_getX
B_getX:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	move $s0, $a0
	lw $s1, 4($s0)
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addu $sp, $sp, 16
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_1
_LAMBDA_1:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 36
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	move $s0, $a0
	move $s1, $a1
	li $s2, 8
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	li $s3, 8
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	la $s4, B_init
	sw $s4, 0($s2)
	la $s4, B_getX
	sw $s4, 4($s2)
	li $s4, 0
	sw $s4, 4($s3)
	sw $s2, 0($s3)
	move $s2, $s3
	lw $s3, 0($s2)
	lw $t9, 0($s3)
	move $s3, $t9
	move $s4, $s1
	lw $s5, 0($s4)
	lw $t9, 4($s5)
	move $s5, $t9
	move $a0, $s4
	jalr $s5
	move $s4, $v0
	lw $s5, 4($s0)
	lw $t9, 4($s5)
	move $s5, $t9
	lw $s6, 0($s5)
	lw $t9, 4($s6)
	move $s6, $t9
	move $a0, $s5
	jalr $s6
	move $s5, $v0
	add $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	addu $sp, $sp, 36
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_0
_LAMBDA_0:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	move $s2, $s1
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _halloc

_halloc:
	li $v0, 9
	syscall
	j $ra

	.text
	.globl _print
_print:
	li $v0, 1
	syscall
	la $a0, newl
	li $v0, 4
	syscall
	j $ra

	.data
	.align 0
newl:	.asciiz "\n"
	.data
	.align 0
str_er:	.asciiz "ERROR: abnormal termination\n"
