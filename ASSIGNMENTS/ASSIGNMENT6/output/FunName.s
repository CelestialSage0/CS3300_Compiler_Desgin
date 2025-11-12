	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 128
	li $s0, 0
	li $s1, 1729
	move $a0, $s0
	move $a1, $s0
	move $a2, $s0
	move $a3, $s0
	sw $s0, 0($sp)
	sw $s0, 4($sp)
	sw $s0, 8($sp)
	sw $s0, 12($sp)
	sw $s0, 16($sp)
	sw $s0, 20($sp)
	sw $s0, 24($sp)
	sw $s0, 28($sp)
	sw $s0, 32($sp)
	sw $s0, 36($sp)
	sw $s0, 40($sp)
	sw $s0, 44($sp)
	sw $s0, 48($sp)
	sw $s0, 52($sp)
	sw $s1, 56($sp)
	jalr TEST
	move $s0, $v0
	addu $sp, $sp, 128
	lw $ra, -4($fp)
	j $ra

	.text
	.globl TEST
TEST:
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
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3
	lw $s4, 0($fp)
	lw $s5, 4($fp)
	lw $s6, 8($fp)
	lw $s7, 12($fp)
	lw $t0, 16($fp)
	lw $t1, 20($fp)
	lw $t2, 24($fp)
	lw $t3, 28($fp)
	lw $t4, 32($fp)
	lw $t5, 36($fp)
	lw $t6, 40($fp)
	lw $t7, 44($fp)
	lw $t8, 48($fp)
	lw $v1, 52($fp)
	sw $v1, 36($sp)
	lw $v1, 56($fp)
	sw $v1, 32($sp)
	move $a0, $s0
	jal _print
	move $a0, $s1
	jal _print
	move $a0, $s2
	jal _print
	move $a0, $s3
	jal _print
	move $a0, $s4
	jal _print
	move $a0, $s5
	jal _print
	move $a0, $s6
	jal _print
	move $a0, $s7
	jal _print
	move $a0, $t0
	jal _print
	move $a0, $t1
	jal _print
	move $a0, $t2
	jal _print
	move $a0, $t3
	jal _print
	move $a0, $t4
	jal _print
	move $a0, $t5
	jal _print
	move $a0, $t6
	jal _print
	move $a0, $t7
	jal _print
	move $a0, $t8
	jal _print
	lw $v1, 36($sp)
	move $a0, $v1
	jal _print
	move $a0, $s0
	jal _print
	nop
	nop
	nop
	li $v1, 20
	sw $v1, 32($sp)
	lw $v1, 32($sp)
	move $a0, $v1
	jal _print
	li $s4, 1729
	move $v0, $s4
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
