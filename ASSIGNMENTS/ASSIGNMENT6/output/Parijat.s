	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $s0, 20
	add $v1, $s0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s0, $v0
	li $s1, 20
	add $v1, $s1, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s1, $v0
	la $s2, Wrapper_call
	sw $s2, 0($s0)
	la $s2, Wrapper_identity_class1
	sw $s2, 4($s0)
	la $s2, Wrapper_identity_class2
	sw $s2, 8($s0)
	la $s2, Wrapper_nest
	sw $s2, 12($s0)
	la $s2, Wrapper_identity_int
	sw $s2, 16($s0)
	li $s2, 0
	sw $s2, 4($s1)
	li $s2, 0
	sw $s2, 8($s1)
	li $s2, 0
	sw $s2, 12($s1)
	li $s2, 0
	sw $s2, 16($s1)
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
	.globl Wrapper_call
Wrapper_call:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 44
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	li $s1, 5
	sw $s1, 4($s0)
	li $s1, 12
	move $s3, $s1
	li $s1, 12
	add $v1, $s1, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s1, $v0
	la $s2, _LAMBDA_2
	sw $s2, 0($s1)
	sw $s0, 4($s1)
	move $s2, $s3
	sw $s2, 8($s1)
	move $s4, $s1
	li $s1, 1
	sw $s1, 4($s0)
	move $s1, $s4
	lw $s2, 0($s1)
	li $s5, 1
	move $a0, $s1
	move $a1, $s5
	jalr $s2
	move $s1, $v0
	move $a0, $s1
	jal _print
	move $s2, $s0
	lw $s5, 0($s2)
	lw $t9, 12($s5)
	move $s5, $t9
	li $s6, 16
	add $v1, $s6, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s6, $v0
	la $s7, _LAMBDA_6
	sw $s7, 0($s6)
	sw $s0, 4($s6)
	move $s7, $s4
	sw $s7, 8($s6)
	move $s7, $s3
	sw $s7, 12($s6)
	li $s7, 16
	add $v1, $s7, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s7, $v0
	la $t0, _LAMBDA_10
	sw $t0, 0($s7)
	sw $s0, 4($s7)
	move $t0, $s4
	sw $t0, 8($s7)
	move $t0, $s3
	sw $t0, 12($s7)
	li $v1, 1
	sw $v1, 32($sp)
	move $a0, $s2
	move $a1, $s6
	move $a2, $s7
	lw $v1, 32($sp)
	move $a3, $v1
	jalr $s5
	move $s2, $v0
	move $a0, $s2
	jal _print
	move $s5, $s0
	lw $s6, 0($s5)
	lw $t9, 12($s6)
	move $s6, $t9
	li $s7, 16
	add $v1, $s7, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s7, $v0
	la $t0, _LAMBDA_14
	sw $t0, 0($s7)
	sw $s0, 4($s7)
	move $t0, $s4
	sw $t0, 8($s7)
	move $t0, $s3
	sw $t0, 12($s7)
	li $t0, 16
	add $v1, $t0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t0, $v0
	la $t1, _LAMBDA_18
	sw $t1, 0($t0)
	sw $s0, 4($t0)
	sw $s4, 8($t0)
	sw $s3, 12($t0)
	move $s3, $t0
	li $s4, 1
	move $a0, $s5
	move $a1, $s7
	move $a2, $s3
	move $a3, $s4
	jalr $s6
	move $s3, $v0
	move $a0, $s3
	jal _print
	li $s4, 8
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	li $s5, 8
	add $v1, $s5, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s5, $v0
	la $s6, A_init
	sw $s6, 0($s4)
	la $s6, A_get
	sw $s6, 4($s4)
	li $s6, 0
	sw $s6, 4($s5)
	sw $s4, 0($s5)
	move $s4, $s5
	sw $s4, 8($s0)
	lw $s4, 8($s0)
	lw $s5, 0($s4)
	lw $t9, 0($s5)
	move $s5, $t9
	li $s6, 8
	move $a0, $s4
	move $a1, $s6
	jalr $s5
	move $s4, $v0
	sw $s4, 16($s0)
	li $s4, 8
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	li $s5, 8
	add $v1, $s5, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s5, $v0
	la $s6, B_init
	sw $s6, 0($s4)
	la $s6, B_get
	sw $s6, 4($s4)
	li $s6, 0
	sw $s6, 4($s5)
	sw $s4, 0($s5)
	move $s4, $s5
	move $s5, $s4
	lw $s6, 0($s5)
	lw $t9, 0($s6)
	move $s6, $t9
	li $s7, 9
	move $a0, $s5
	move $a1, $s7
	jalr $s6
	move $s5, $v0
	sw $s5, 16($s0)
	move $s5, $s0
	lw $s6, 0($s5)
	lw $t9, 4($s6)
	move $s6, $t9
	li $s7, 12
	add $v1, $s7, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s7, $v0
	la $t0, _LAMBDA_19
	sw $t0, 0($s7)
	sw $s0, 4($s7)
	move $t0, $s4
	sw $t0, 8($s7)
	move $a0, $s5
	move $a1, $s7
	jalr $s6
	move $s5, $v0
	lw $s6, 0($s5)
	lw $s7, 8($s0)
	move $a0, $s5
	move $a1, $s7
	jalr $s6
	move $s5, $v0
	sw $s5, 12($s0)
	move $s5, $s0
	lw $s6, 0($s5)
	lw $t9, 8($s6)
	move $s6, $t9
	li $s7, 8
	add $v1, $s7, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s7, $v0
	la $t0, _LAMBDA_20
	sw $t0, 0($s7)
	sw $s0, 4($s7)
	move $a0, $s5
	move $a1, $s7
	jalr $s6
	move $s5, $v0
	lw $s6, 0($s5)
	move $a0, $s5
	move $a1, $s4
	jalr $s6
	move $s4, $v0
	lw $s5, 0($s4)
	lw $t9, 4($s5)
	move $s5, $t9
	move $a0, $s4
	jalr $s5
	move $s4, $v0
	li $s5, 10
	mul $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	lw $s5, 12($s0)
	lw $s6, 0($s5)
	lw $t9, 4($s6)
	move $s6, $t9
	move $a0, $s5
	jalr $s6
	move $s5, $v0
	add $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	move $a0, $s4
	jal _print
	div $v1, $s3, $s2
	move $t9, $v1
	move $s2, $t9
	mul $v1, $s2, $s4
	move $t9, $v1
	move $s2, $t9
	add $v1, $s1, $s2
	move $t9, $v1
	move $s1, $t9
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	addu $sp, $sp, 44
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Wrapper_identity_int
Wrapper_identity_int:
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
	.globl Wrapper_nest
Wrapper_nest:
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
	move $s2, $a2
	move $s3, $a3
	move $s4, $s1
	lw $s5, 0($s4)
	move $s6, $s2
	lw $s7, 0($s6)
	move $a0, $s6
	move $a1, $s3
	jalr $s7
	move $s6, $v0
	move $a0, $s4
	move $a1, $s6
	jalr $s5
	move $s4, $v0
	move $v0, $s4
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
	.globl Wrapper_identity_class1
Wrapper_identity_class1:
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
	.globl Wrapper_identity_class2
Wrapper_identity_class2:
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
	.globl A_init
A_init:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	sw $s1, 4($s0)
	lw $s2, 4($s0)
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl A_get
A_get:
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
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	sw $s1, 4($s0)
	lw $s2, 4($s0)
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_get
B_get:
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
	.globl _LAMBDA_3
_LAMBDA_3:
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
	lw $s2, 8($s0)
	lw $s3, 12($s0)
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	lw $s3, 16($s0)
	add $v1, $s1, $s3
	move $t9, $v1
	move $s3, $t9
	lw $s4, 4($s0)
	lw $t9, 4($s4)
	move $s4, $t9
	mul $v1, $s3, $s4
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
	addu $sp, $sp, 28
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_13
_LAMBDA_13:
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
	lw $s2, 4($s0)
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 16
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, _LAMBDA_12
	sw $s5, 0($s4)
	lw $s5, 4($s0)
	sw $s5, 4($s4)
	move $s5, $s1
	sw $s5, 8($s4)
	lw $s5, 8($s0)
	sw $s5, 12($s4)
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	lw $s3, 0($s2)
	li $s4, 10
	mul $v1, $s1, $s4
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
	addu $sp, $sp, 32
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_4
_LAMBDA_4:
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
	lw $s2, 4($s0)
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 20
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, _LAMBDA_3
	sw $s5, 0($s4)
	lw $s5, 4($s0)
	sw $s5, 4($s4)
	lw $s5, 8($s0)
	sw $s5, 8($s4)
	move $s5, $s1
	sw $s5, 12($s4)
	lw $s5, 12($s0)
	sw $s5, 16($s4)
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	lw $s3, 0($s2)
	li $s4, 100
	mul $v1, $s1, $s4
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
	addu $sp, $sp, 32
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_12
_LAMBDA_12:
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
	lw $s2, 4($s0)
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 20
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, _LAMBDA_11
	sw $s5, 0($s4)
	lw $s5, 4($s0)
	sw $s5, 4($s4)
	lw $s5, 8($s0)
	sw $s5, 8($s4)
	move $s5, $s1
	sw $s5, 12($s4)
	lw $s5, 12($s0)
	sw $s5, 16($s4)
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	lw $s3, 0($s2)
	li $s4, 100
	mul $v1, $s1, $s4
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
	addu $sp, $sp, 32
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_1
_LAMBDA_1:
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
	lw $s2, 4($s0)
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 20
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, _LAMBDA_0
	sw $s5, 0($s4)
	lw $s5, 4($s0)
	sw $s5, 4($s4)
	lw $s5, 8($s0)
	sw $s5, 8($s4)
	move $s5, $s1
	sw $s5, 12($s4)
	lw $s5, 12($s0)
	sw $s5, 16($s4)
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	lw $s3, 0($s2)
	li $s4, 100
	mul $v1, $s1, $s4
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
	addu $sp, $sp, 32
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_11
_LAMBDA_11:
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
	lw $s2, 8($s0)
	lw $s3, 12($s0)
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	lw $s3, 16($s0)
	add $v1, $s1, $s3
	move $t9, $v1
	move $s3, $t9
	lw $s4, 4($s0)
	lw $t9, 4($s4)
	move $s4, $t9
	mul $v1, $s3, $s4
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
	addu $sp, $sp, 28
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_2
_LAMBDA_2:
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
	lw $s2, 4($s0)
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 16
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, _LAMBDA_1
	sw $s5, 0($s4)
	lw $s5, 4($s0)
	sw $s5, 4($s4)
	move $s5, $s1
	sw $s5, 8($s4)
	lw $s5, 8($s0)
	sw $s5, 12($s4)
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	lw $s3, 0($s2)
	li $s4, 10
	mul $v1, $s1, $s4
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
	addu $sp, $sp, 32
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_10
_LAMBDA_10:
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
	lw $s2, 8($s0)
	lw $s3, 0($s2)
	move $a0, $s2
	move $a1, $s1
	jalr $s3
	move $s2, $v0
	lw $s3, 4($s0)
	lw $s4, 0($s3)
	lw $t9, 16($s4)
	move $s4, $t9
	li $s5, 12
	add $v1, $s5, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s5, $v0
	la $s6, _LAMBDA_9
	sw $s6, 0($s5)
	lw $s6, 4($s0)
	sw $s6, 4($s5)
	lw $s6, 12($s0)
	sw $s6, 8($s5)
	move $a0, $s3
	move $a1, $s5
	jalr $s4
	move $s3, $v0
	lw $s4, 0($s3)
	move $a0, $s3
	move $a1, $s1
	jalr $s4
	move $s3, $v0
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
	addu $sp, $sp, 36
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_7
_LAMBDA_7:
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
	lw $s2, 8($s0)
	lw $s3, 12($s0)
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	lw $s3, 16($s0)
	add $v1, $s1, $s3
	move $t9, $v1
	move $s3, $t9
	lw $s4, 4($s0)
	lw $t9, 4($s4)
	move $s4, $t9
	mul $v1, $s3, $s4
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
	addu $sp, $sp, 28
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_17
_LAMBDA_17:
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
	lw $s2, 4($s0)
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 16
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, _LAMBDA_16
	sw $s5, 0($s4)
	lw $s5, 4($s0)
	sw $s5, 4($s4)
	move $s5, $s1
	sw $s5, 8($s4)
	lw $s5, 8($s0)
	sw $s5, 12($s4)
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	lw $s3, 0($s2)
	li $s4, 10
	mul $v1, $s1, $s4
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
	addu $sp, $sp, 32
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
	lw $s2, 4($s0)
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 20
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, _LAMBDA_7
	sw $s5, 0($s4)
	lw $s5, 4($s0)
	sw $s5, 4($s4)
	lw $s5, 8($s0)
	sw $s5, 8($s4)
	move $s5, $s1
	sw $s5, 12($s4)
	lw $s5, 12($s0)
	sw $s5, 16($s4)
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	lw $s3, 0($s2)
	li $s4, 100
	mul $v1, $s1, $s4
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
	addu $sp, $sp, 32
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_16
_LAMBDA_16:
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
	lw $s2, 4($s0)
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 20
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, _LAMBDA_15
	sw $s5, 0($s4)
	lw $s5, 4($s0)
	sw $s5, 4($s4)
	lw $s5, 8($s0)
	sw $s5, 8($s4)
	move $s5, $s1
	sw $s5, 12($s4)
	lw $s5, 12($s0)
	sw $s5, 16($s4)
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	lw $s3, 0($s2)
	li $s4, 100
	mul $v1, $s1, $s4
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
	subu $sp, $sp, 32
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	move $s0, $a0
	move $s1, $a1
	lw $s2, 4($s0)
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 16
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
	lw $s5, 8($s0)
	sw $s5, 12($s4)
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	lw $s3, 0($s2)
	li $s4, 10
	mul $v1, $s1, $s4
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
	addu $sp, $sp, 32
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_15
_LAMBDA_15:
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
	lw $s2, 8($s0)
	lw $s3, 12($s0)
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	lw $s3, 16($s0)
	add $v1, $s1, $s3
	move $t9, $v1
	move $s3, $t9
	lw $s4, 4($s0)
	lw $t9, 4($s4)
	move $s4, $t9
	mul $v1, $s3, $s4
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
	addu $sp, $sp, 28
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
	lw $s2, 8($s0)
	lw $s3, 0($s2)
	move $a0, $s2
	move $a1, $s1
	jalr $s3
	move $s2, $v0
	lw $s3, 4($s0)
	lw $s4, 0($s3)
	lw $t9, 16($s4)
	move $s4, $t9
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
	lw $s6, 12($s0)
	sw $s6, 8($s5)
	move $a0, $s3
	move $a1, $s5
	jalr $s4
	move $s3, $v0
	lw $s4, 0($s3)
	move $a0, $s3
	move $a1, $s1
	jalr $s4
	move $s3, $v0
	mul $v1, $s2, $s3
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
	.globl _LAMBDA_14
_LAMBDA_14:
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
	lw $s2, 8($s0)
	lw $s3, 0($s2)
	move $a0, $s2
	move $a1, $s1
	jalr $s3
	move $s2, $v0
	lw $s3, 4($s0)
	lw $s4, 0($s3)
	lw $t9, 16($s4)
	move $s4, $t9
	li $s5, 12
	add $v1, $s5, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s5, $v0
	la $s6, _LAMBDA_13
	sw $s6, 0($s5)
	lw $s6, 4($s0)
	sw $s6, 4($s5)
	lw $s6, 12($s0)
	sw $s6, 8($s5)
	move $a0, $s3
	move $a1, $s5
	jalr $s4
	move $s3, $v0
	lw $s4, 0($s3)
	move $a0, $s3
	move $a1, $s1
	jalr $s4
	move $s3, $v0
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
	addu $sp, $sp, 36
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_20
_LAMBDA_20:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	lw $s2, 4($s0)
	lw $t9, 8($s2)
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
	.globl _LAMBDA_0
_LAMBDA_0:
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
	lw $s2, 8($s0)
	lw $s3, 12($s0)
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	lw $s3, 16($s0)
	add $v1, $s1, $s3
	move $t9, $v1
	move $s3, $t9
	lw $s4, 4($s0)
	lw $t9, 4($s4)
	move $s4, $t9
	mul $v1, $s3, $s4
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
	addu $sp, $sp, 28
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_9
_LAMBDA_9:
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
	lw $s2, 4($s0)
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 16
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, _LAMBDA_8
	sw $s5, 0($s4)
	lw $s5, 4($s0)
	sw $s5, 4($s4)
	move $s5, $s1
	sw $s5, 8($s4)
	lw $s5, 8($s0)
	sw $s5, 12($s4)
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	lw $s3, 0($s2)
	li $s4, 10
	mul $v1, $s1, $s4
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
	addu $sp, $sp, 32
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_19
_LAMBDA_19:
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
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_18
_LAMBDA_18:
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
	lw $s2, 8($s0)
	lw $s3, 0($s2)
	move $a0, $s2
	move $a1, $s1
	jalr $s3
	move $s2, $v0
	lw $s3, 4($s0)
	lw $s4, 0($s3)
	lw $t9, 16($s4)
	move $s4, $t9
	li $s5, 12
	add $v1, $s5, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s5, $v0
	la $s6, _LAMBDA_17
	sw $s6, 0($s5)
	lw $s6, 4($s0)
	sw $s6, 4($s5)
	lw $s6, 12($s0)
	sw $s6, 8($s5)
	move $a0, $s3
	move $a1, $s5
	jalr $s4
	move $s3, $v0
	lw $s4, 0($s3)
	move $a0, $s3
	move $a1, $s1
	jalr $s4
	move $s3, $v0
	mul $v1, $s2, $s3
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
