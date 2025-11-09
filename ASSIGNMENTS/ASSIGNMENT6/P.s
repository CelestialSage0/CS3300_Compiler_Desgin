	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 14
	move $v1, 4
	move $s0, $v1
	move $a0, $s0
	jal _halloc
	move $s0, $v0
	move $s0, $s0
	move $v1, 4
	move $s1, $v1
	move $a0, $s1
	jal _halloc
	move $s1, $v0
	move $s1, $s1
	move $s2, Fac_ComputeFac
	sw $s2, 0($s0)
	sw $s0, 0($s1)
	move $s1, $s1
	$lw $s0, 0($s1)
	$lw $s0, 0($s0)
	move $v1, 10
	move $s2, $v1
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	sw $t4, 16($sp)
	sw $t5, 20($sp)
	sw $t6, 24($sp)
	sw $t7, 28($sp)
	sw $t8, 32($sp)
	sw $t9, 36($sp)
	move $a0, $s1
	move $a1, $s2
	jalr $s0
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	lw $t3, 12($sp)
	lw $t4, 16($sp)
	lw $t5, 20($sp)
	lw $t6, 24($sp)
	lw $t7, 28($sp)
	lw $t8, 32($sp)
	lw $t9, 36($sp)
	move $s2, $v0
	move $a0 $s2
	jal _print
	addu $sp, $sp, 14
	lw $ra, -4($fp)
	j $ra

	.text
	.globl Fac_ComputeFac
Fac_ComputeFac:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 26
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
	move $v1, 0
	move $s2, $v1
	sle $v1, $s1, $s2
	move $s2, $v1
	beqz $s2 L2
	move $v1, 1
	move $s0, $v1
	move $s0, $s0
	b L3
L2:
	move $s2, $s0
	$lw $s3, 0($s2)
	$lw $s3, 0($s3)
	move $v1, 1
	move $s4, $v1
	sub $v1, $s1, $s4
	move $s4, $v1
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	sw $t8, 64($sp)
	sw $t9, 68($sp)
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	lw $t0, 32($sp)
	lw $t1, 36($sp)
	lw $t2, 40($sp)
	lw $t3, 44($sp)
	lw $t4, 48($sp)
	lw $t5, 52($sp)
	lw $t6, 56($sp)
	lw $t7, 60($sp)
	lw $t8, 64($sp)
	lw $t9, 68($sp)
	move $s4, $v0
	mul $v1, $s1, $s4
	move $s4, $v1
	move $s0, $s4
L3:
	nop
	move $v0, $s0
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	addu $sp, $sp, 26
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
