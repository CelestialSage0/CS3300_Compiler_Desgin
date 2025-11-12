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
	li $s1, 4
	add $v1, $s1, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s1, $v0
	la $s2, test_Less_Equal
	sw $s2, 0($s0)
	la $s2, test_dos
	sw $s2, 4($s0)
	sw $s0, 0($s1)
	move $s0, $s1
	lw $s1, 0($s0)
	lw $t9, 0($s1)
	move $s1, $t9
	li $s2, 5
	li $s3, 10
	move $a0, $s0
	move $a1, $s2
	move $a2, $s3
	jalr $s1
	move $s0, $v0
	move $a0, $s0
	jal _print
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	j $ra

	.text
	.globl test_Less_Equal
test_Less_Equal:
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
	move $s2, $a2
	li $s3, 0
	li $s4, 8
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
	la $s6, test_Less_Equal
	sw $s6, 0($s4)
	la $s6, test_dos
	sw $s6, 4($s4)
	sw $s4, 0($s5)
	move $s4, $s5
	li $s5, 16
	add $v1, $s5, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s5, $v0
	la $s6, _LAMBDA_1
	sw $s6, 0($s5)
	sw $s0, 4($s5)
	sw $s4, 8($s5)
	sw $s3, 12($s5)
	move $s3, $s5
	lw $s4, 0($s3)
	li $s5, 2
	move $a0, $s3
	move $a1, $s5
	jalr $s4
	move $s3, $v0
	move $v0, $s3
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
	.globl test_dos
test_dos:
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
	move $s2, $s1
	lw $s3, 0($s2)
	li $s4, 1
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
	addu $sp, $sp, 28
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
	lw $s2, 8($s0)
	lw $s3, 0($s2)
	lw $t9, 4($s3)
	move $s3, $t9
	li $s4, 16
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, _LAMBDA_0
	sw $s5, 0($s4)
	lw $s5, 4($s0)
	sw $s5, 4($s4)
	move $s5, $s1
	sw $s5, 8($s4)
	lw $s5, 12($s0)
	sw $s5, 12($s4)
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	add $v1, $s2, $s1
	move $t9, $v1
	move $s2, $t9
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
	.globl _LAMBDA_0
_LAMBDA_0:
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
	lw $s2, 8($s0)
	add $v1, $s1, $s2
	move $t9, $v1
	move $s2, $t9
	lw $s3, 12($s0)
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
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
