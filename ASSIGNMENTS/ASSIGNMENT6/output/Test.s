	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $s0, 4
	add $v1, $s0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s0, $v0
	li $s1, 4
	add $v1, $s1, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s1, $v0
	la $s2, T_start
	sw $s2, 0($s0)
	sw $s0, 0($s1)
	move $s0, $s1
	lw $s1, 0($s0)
	lw $t9, 0($s1)
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
	subu $sp, $sp, 32
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	move $s0, $a0
	li $s1, 4
	add $v1, $s1, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s1, $v0
	li $s2, 4
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	la $s3, C_c
	sw $s3, 0($s1)
	sw $s1, 0($s2)
	move $s1, $s2
	lw $s2, 0($s1)
	lw $t9, 0($s2)
	move $s2, $t9
	li $s3, 8
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	la $s4, _LAMBDA_6
	sw $s4, 0($s3)
	sw $s0, 4($s3)
	li $s4, 8
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, _LAMBDA_7
	sw $s5, 0($s4)
	sw $s0, 4($s4)
	move $a0, $s1
	move $a1, $s3
	move $a2, $s4
	jalr $s2
	move $s1, $v0
	lw $s2, 0($s1)
	li $s3, 5
	move $a0, $s1
	move $a1, $s3
	jalr $s2
	move $s1, $v0
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	addu $sp, $sp, 32
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl C_c
C_c:
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
	li $s3, 16
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	la $s4, _LAMBDA_8
	sw $s4, 0($s3)
	sw $s0, 4($s3)
	move $s4, $s1
	sw $s4, 8($s3)
	move $s4, $s2
	sw $s4, 12($s3)
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
	.globl _LAMBDA_3
_LAMBDA_3:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	lw $s2, 8($s0)
	add $v1, $s1, $s2
	move $t9, $v1
	move $s2, $t9
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_4
_LAMBDA_4:
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
	li $s2, 4
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	li $s3, 4
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	la $s4, C_c
	sw $s4, 0($s2)
	sw $s2, 0($s3)
	move $s2, $s3
	lw $s3, 0($s2)
	lw $t9, 0($s3)
	move $s3, $t9
	li $s4, 16
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, _LAMBDA_2
	sw $s5, 0($s4)
	lw $s5, 4($s0)
	sw $s5, 4($s4)
	move $s5, $s1
	sw $s5, 8($s4)
	lw $s5, 8($s0)
	sw $s5, 12($s4)
	li $s5, 12
	add $v1, $s5, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s5, $v0
	la $s6, _LAMBDA_3
	sw $s6, 0($s5)
	lw $s6, 4($s0)
	sw $s6, 4($s5)
	move $s6, $s1
	sw $s6, 8($s5)
	move $a0, $s2
	move $a1, $s4
	move $a2, $s5
	jalr $s3
	move $s2, $v0
	lw $s3, 0($s2)
	li $s4, 3
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	add $v1, $s1, $s2
	move $t9, $v1
	move $s2, $t9
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
	.globl _LAMBDA_1
_LAMBDA_1:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	lw $s2, 8($s0)
	mul $v1, $s1, $s2
	move $t9, $v1
	move $s2, $t9
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_2
_LAMBDA_2:
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
	move $s1, $a1
	lw $s2, 8($s0)
	mul $v1, $s1, $s2
	move $t9, $v1
	move $s2, $t9
	lw $s3, 12($s0)
	li $s4, 4
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	li $s5, 4
	add $v1, $s5, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s5, $v0
	la $s6, C_c
	sw $s6, 0($s4)
	sw $s4, 0($s5)
	move $s4, $s5
	lw $s5, 0($s4)
	lw $t9, 0($s5)
	move $s5, $t9
	li $s6, 12
	add $v1, $s6, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s6, $v0
	la $s7, _LAMBDA_0
	sw $s7, 0($s6)
	lw $s7, 4($s0)
	sw $s7, 4($s6)
	move $s7, $s1
	sw $s7, 8($s6)
	li $s7, 12
	add $v1, $s7, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s7, $v0
	la $t0, _LAMBDA_1
	sw $t0, 0($s7)
	lw $t0, 4($s0)
	sw $t0, 4($s7)
	lw $t0, 12($s0)
	sw $t0, 8($s7)
	move $a0, $s4
	move $a1, $s6
	move $a2, $s7
	jalr $s5
	move $s4, $v0
	lw $s5, 0($s4)
	li $s6, 10
	move $a0, $s4
	move $a1, $s6
	jalr $s5
	move $s4, $v0
	add $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $v0, $s2
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
	.globl _LAMBDA_7
_LAMBDA_7:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	li $s2, 3
	add $v1, $s1, $s2
	move $t9, $v1
	move $s2, $t9
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_8
_LAMBDA_8:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 32
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	move $s0, $a0
	move $s1, $a1
	lw $s2, 8($s0)
	lw $s3, 0($s2)
	lw $s4, 12($s0)
	lw $s5, 0($s4)
	move $a0, $s4
	move $a1, $s1
	jalr $s5
	move $s4, $v0
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
	addu $sp, $sp, 32
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_5
_LAMBDA_5:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	lw $s2, 8($s0)
	add $v1, $s1, $s2
	move $t9, $v1
	move $s2, $t9
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_6
_LAMBDA_6:
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
	li $s2, 4
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	li $s3, 4
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	la $s4, C_c
	sw $s4, 0($s2)
	sw $s2, 0($s3)
	move $s2, $s3
	lw $s3, 0($s2)
	lw $t9, 0($s3)
	move $s3, $t9
	li $s4, 12
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, _LAMBDA_4
	sw $s5, 0($s4)
	lw $s5, 4($s0)
	sw $s5, 4($s4)
	move $s5, $s1
	sw $s5, 8($s4)
	li $s5, 12
	add $v1, $s5, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s5, $v0
	la $s6, _LAMBDA_5
	sw $s6, 0($s5)
	lw $s6, 4($s0)
	sw $s6, 4($s5)
	move $s6, $s1
	sw $s6, 8($s5)
	move $a0, $s2
	move $a1, $s4
	move $a2, $s5
	jalr $s3
	move $s2, $v0
	lw $s3, 0($s2)
	li $s4, 2
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	add $v1, $s1, $s2
	move $t9, $v1
	move $s2, $t9
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
	lw $s2, 8($s0)
	add $v1, $s1, $s2
	move $t9, $v1
	move $s2, $t9
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
