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
	la $s2, RunnerB_run
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
	.globl RunnerB_run
RunnerB_run:
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
	li $s1, 12
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
	la $s3, Bottom_beta
	sw $s3, 4($s1)
	la $s3, Middle_gamma
	sw $s3, 8($s1)
	la $s3, Middle_alpha
	sw $s3, 0($s1)
	sw $s1, 0($s2)
	move $s1, $s2
	move $s3, $s1
	li $s1, 12
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
	la $s4, Bottom_beta
	sw $s4, 4($s1)
	la $s4, Middle_gamma
	sw $s4, 8($s1)
	la $s4, Middle_alpha
	sw $s4, 0($s1)
	sw $s1, 0($s2)
	move $s1, $s2
	li $s2, 12
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	li $s4, 4
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, Bottom_beta
	sw $s5, 4($s2)
	la $s5, Middle_gamma
	sw $s5, 8($s2)
	la $s5, Middle_alpha
	sw $s5, 0($s2)
	sw $s2, 0($s4)
	move $s2, $s4
	lw $s4, 0($s3)
	lw $t9, 0($s4)
	move $s4, $t9
	li $s5, 4
	move $a0, $s3
	move $a1, $s5
	jalr $s4
	move $s3, $v0
	lw $s4, 0($s1)
	lw $t9, 8($s4)
	move $s4, $t9
	li $s5, 5
	move $a0, $s1
	move $a1, $s5
	jalr $s4
	move $s1, $v0
	lw $s4, 0($s2)
	lw $t9, 4($s4)
	move $s4, $t9
	li $s5, 6
	move $a0, $s2
	move $a1, $s5
	jalr $s4
	move $s2, $v0
	add $v1, $s3, $s1
	move $t9, $v1
	move $s1, $t9
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
	addu $sp, $sp, 32
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl TopBase_alpha
TopBase_alpha:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	move $s0, $a0
	move $s1, $a1
	li $s2, 8
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	la $s3, _LAMBDA_0
	sw $s3, 0($s2)
	sw $s0, 4($s2)
	lw $s3, 0($s2)
	move $a0, $s2
	move $a1, $s1
	jalr $s3
	move $s2, $v0
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	addu $sp, $sp, 24
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl TopBase_beta
TopBase_beta:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	li $s2, 2
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
	.globl Middle_alpha
Middle_alpha:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	move $s0, $a0
	move $s1, $a1
	li $s2, 8
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	la $s3, _LAMBDA_1
	sw $s3, 0($s2)
	sw $s0, 4($s2)
	lw $s3, 0($s2)
	move $a0, $s2
	move $a1, $s1
	jalr $s3
	move $s2, $v0
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	addu $sp, $sp, 24
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Middle_gamma
Middle_gamma:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	li $s2, 10
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
	.globl Bottom_beta
Bottom_beta:
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
	li $s2, 2
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
	li $s2, 1
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
