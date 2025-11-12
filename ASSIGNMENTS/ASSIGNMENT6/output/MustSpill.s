	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	jalr Test35
	move $s0, $v0
	move $a0, $s0
	jal _print
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	j $ra

	.text
	.globl Test35
Test35:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 108
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	li $s0, 0
	li $s1, 1
	li $s2, 2
	li $s3, 3
	li $s4, 4
	li $s5, 5
	li $s6, 6
	li $s7, 7
	li $t0, 8
	li $t1, 9
	li $t2, 10
	li $t3, 11
	li $t4, 12
	li $t5, 13
	li $t6, 14
	li $t7, 15
	li $t8, 16
	li $v1, 17
	sw $v1, 80($sp)
	li $v1, 18
	sw $v1, 72($sp)
	li $v1, 19
	sw $v1, 96($sp)
	li $v1, 20
	sw $v1, 40($sp)
	li $v1, 21
	sw $v1, 32($sp)
	li $v1, 22
	sw $v1, 64($sp)
	li $v1, 23
	sw $v1, 60($sp)
	li $v1, 24
	sw $v1, 56($sp)
	li $v1, 25
	sw $v1, 52($sp)
	li $v1, 26
	sw $v1, 92($sp)
	li $v1, 27
	sw $v1, 88($sp)
	li $v1, 28
	sw $v1, 84($sp)
	li $v1, 29
	sw $v1, 76($sp)
	li $v1, 30
	sw $v1, 48($sp)
	li $v1, 31
	sw $v1, 44($sp)
	li $v1, 32
	sw $v1, 36($sp)
	li $v1, 33
	sw $v1, 68($sp)
	lw $v1, 68($sp)
	move $a0, $v1
	jal _print
	lw $v1, 36($sp)
	move $a0, $v1
	jal _print
	lw $v1, 44($sp)
	move $a0, $v1
	jal _print
	lw $v1, 48($sp)
	move $a0, $v1
	jal _print
	lw $v1, 76($sp)
	move $a0, $v1
	jal _print
	lw $v1, 84($sp)
	move $a0, $v1
	jal _print
	lw $v1, 88($sp)
	move $a0, $v1
	jal _print
	lw $v1, 92($sp)
	move $a0, $v1
	jal _print
	lw $v1, 52($sp)
	move $a0, $v1
	jal _print
	lw $v1, 56($sp)
	move $a0, $v1
	jal _print
	lw $v1, 60($sp)
	move $a0, $v1
	jal _print
	lw $v1, 64($sp)
	move $a0, $v1
	jal _print
	lw $v1, 32($sp)
	move $a0, $v1
	jal _print
	lw $v1, 40($sp)
	move $a0, $v1
	jal _print
	lw $v1, 96($sp)
	move $a0, $v1
	jal _print
	lw $v1, 72($sp)
	move $a0, $v1
	jal _print
	lw $v1, 80($sp)
	move $a0, $v1
	jal _print
	move $a0, $t8
	jal _print
	move $a0, $t7
	jal _print
	move $a0, $t6
	jal _print
	move $a0, $t5
	jal _print
	move $a0, $t4
	jal _print
	move $a0, $t3
	jal _print
	move $a0, $t2
	jal _print
	move $a0, $t1
	jal _print
	move $a0, $t0
	jal _print
	move $a0, $s7
	jal _print
	move $a0, $s6
	jal _print
	move $a0, $s5
	jal _print
	move $a0, $s4
	jal _print
	move $a0, $s3
	jal _print
	move $a0, $s2
	jal _print
	move $a0, $s1
	jal _print
	move $a0, $s0
	jal _print
	move $v0, $s0
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	addu $sp, $sp, 108
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
