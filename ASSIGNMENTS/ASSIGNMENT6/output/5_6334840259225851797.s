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
	sw $s1, 0($s0)
	la $s2, Wrapper$call
	sw $s2, 0($s1)
	la $s2, Wrapper$foo
	sw $s2, 4($s1)
	li $s1, 0
	sw $s1, 4($s0)
	move $s1, $s0
	lw $t9, 0($s1)
	move $s1, $t9
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
	.globl Wrapper$call
Wrapper$call:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	move $s0, $a0
	move $s1, $s0
	li $s2, 0
	li $s2, 5
	sw $s2, 4($s1)
	li $s2, 10
	move $s2, $s1
	move $s3, $s2
	lw $t9, 0($s3)
	move $s3, $t9
	lw $t9, 4($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	lw $s2, 4($s1)
	li $s3, 2
	mul $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	sw $s2, 4($s1)
	lw $t9, 4($s1)
	move $s1, $t9
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
	.globl Wrapper$foo
Wrapper$foo:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	move $s0, $a0
	move $s1, $s0
	lw $s2, 4($s1)
	lw $s3, 4($s1)
	mul $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	sw $s2, 4($s1)
	lw $t9, 4($s1)
	move $s1, $t9
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
