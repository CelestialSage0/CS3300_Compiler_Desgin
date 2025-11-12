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
	la $s2, RunnerA_run
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
	.globl RunnerA_run
RunnerA_run:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 68
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	li $s3, 4
	li $t1, 1
	add $v1, $s3, $t1
	move $t9, $v1
	move $t1, $t9
	li $t2, 4
	mul $v1, $t1, $t2
	move $t9, $v1
	move $t1, $t9
	add $v1, $t1, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t1, $v0
	sw $s3, 0($t1)
	li $t2, 1
L0:
	li $t3, 1
	sub $v1, $s3, $t3
	move $t9, $v1
	move $t3, $t9
	sle $v1, $t2, $t3
	move $t9, $v1
	move $t3, $t9
	beqz $t3 L1
	li $t3, 4
	mul $v1, $t3, $t2
	move $t9, $v1
	move $t3, $t9
	add $v1, $t3, $t1
	move $t9, $v1
	move $t3, $t9
	li $t4, 0
	sw $t4, 0($t3)
	li $t3, 1
	add $v1, $t2, $t3
	move $t9, $v1
	move $t2, $t9
	b L0
L1:
	nop
	move $s3, $t1
	move $t1, $s3
	li $t2, 0
	lw $t3, 0($t1)
	sle $v1, $t2, $t3
	move $t9, $v1
	move $t3, $t9
	beqz $t3 L2
	li $t3, 4
	li $t4, 1
	add $v1, $t4, $t2
	move $t9, $v1
	move $t2, $t9
	mul $v1, $t3, $t2
	move $t9, $v1
	move $t2, $t9
	add $v1, $t1, $t2
	move $t9, $v1
	move $t1, $t9
	li $t2, 20
	sw $t2, 0($t1)
	b L3
L2:
L3:
	nop
	move $t1, $s3
	li $t2, 1
	lw $t3, 0($t1)
	sle $v1, $t2, $t3
	move $t9, $v1
	move $t3, $t9
	beqz $t3 L4
	li $t3, 4
	li $t4, 1
	add $v1, $t4, $t2
	move $t9, $v1
	move $t2, $t9
	mul $v1, $t3, $t2
	move $t9, $v1
	move $t2, $t9
	add $v1, $t1, $t2
	move $t9, $v1
	move $t1, $t9
	li $t2, 5
	sw $t2, 0($t1)
	b L5
L4:
L5:
	nop
	move $t1, $s3
	li $t2, 0
	lw $t3, 0($t1)
	sle $v1, $t2, $t3
	move $t9, $v1
	move $t3, $t9
	beqz $t3 L6
	li $s5, 4
	li $t3, 1
	add $v1, $t3, $t2
	move $t9, $v1
	move $t2, $t9
	mul $v1, $s5, $t2
	move $t9, $v1
	move $s5, $t9
	add $v1, $t1, $s5
	move $t9, $v1
	move $s5, $t9
	lw $t9, 0($s5)
	move $s5, $t9
	b L7
L6:
L7:
	nop
	move $t1, $s3
	li $t2, 1
	lw $t3, 0($t1)
	sle $v1, $t2, $t3
	move $t9, $v1
	move $t3, $t9
	beqz $t3 L8
	li $t0, 4
	li $t3, 1
	add $v1, $t3, $t2
	move $t9, $v1
	move $t2, $t9
	mul $v1, $t0, $t2
	move $t9, $v1
	move $t0, $t9
	add $v1, $t1, $t0
	move $t9, $v1
	move $t0, $t9
	lw $t9, 0($t0)
	move $t0, $t9
	b L9
L8:
L9:
	nop
	move $v1, $t0
	sw $v1, 56($sp)
	lw $v1, 56($sp)
	sub $v1, $s5, $v1
	move $t9, $v1
	move $t0, $t9
	move $v1, $t0
	sw $v1, 32($sp)
	li $t0, 2
	lw $v1, 56($sp)
	add $v1, $v1, $t0
	move $t9, $v1
	move $t0, $t9
	mul $v1, $s5, $t0
	move $t9, $v1
	move $t0, $t9
	li $t1, 1
	lw $v1, 56($sp)
	sub $v1, $v1, $t1
	move $t9, $v1
	move $t1, $t9
	div $v1, $t0, $t1
	move $t9, $v1
	move $t0, $t9
	move $v1, $t0
	sw $v1, 48($sp)
	li $t0, 8
	add $v1, $t0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t0, $v0
	la $t1, _LAMBDA_0
	sw $t1, 0($t0)
	sw $s0, 4($t0)
	move $t1, $s3
	li $t2, 2
	lw $t3, 0($t1)
	sle $v1, $t2, $t3
	move $t9, $v1
	move $t3, $t9
	beqz $t3 L10
	li $t3, 4
	li $t4, 1
	add $v1, $t4, $t2
	move $t9, $v1
	move $t2, $t9
	mul $v1, $t3, $t2
	move $t9, $v1
	move $t2, $t9
	add $v1, $t1, $t2
	move $t9, $v1
	move $t1, $t9
	move $v1, $t1
	sw $v1, 36($sp)
	move $v1, $t0
	sw $v1, 52($sp)
	lw $v1, 52($sp)
	lw $t0, 0($v1)
	move $v1, $t0
	sw $v1, 40($sp)
	lw $v1, 52($sp)
	move $a0, $v1
	lw $v1, 48($sp)
	move $a1, $v1
	lw $v1, 40($sp)
	jalr $v1
	move $v1, $v0
	sw $v1, 44($sp)
	lw $v1, 36($sp)
	move $v0, $v1
	lw $v1, 44($sp)
	sw $v1, 0($v0)
	b L11
L10:
L11:
	nop
	move $t0, $s3
	li $t1, 3
	lw $t2, 0($t0)
	sle $v1, $t1, $t2
	move $t9, $v1
	move $t2, $t9
	beqz $t2 L12
	li $t2, 4
	li $t3, 1
	add $v1, $t3, $t1
	move $t9, $v1
	move $t1, $t9
	mul $v1, $t2, $t1
	move $t9, $v1
	move $t1, $t9
	add $v1, $t0, $t1
	move $t9, $v1
	move $t0, $t9
	move $t1, $s3
	li $t2, 0
	lw $t3, 0($t1)
	sle $v1, $t2, $t3
	move $t9, $v1
	move $t3, $t9
	beqz $t3 L14
	li $s7, 4
	li $t3, 1
	add $v1, $t3, $t2
	move $t9, $v1
	move $t2, $t9
	mul $v1, $s7, $t2
	move $t9, $v1
	move $s7, $t9
	add $v1, $t1, $s7
	move $t9, $v1
	move $s7, $t9
	lw $t9, 0($s7)
	move $s7, $t9
	b L15
L14:
L15:
	nop
	move $t1, $s3
	li $t2, 1
	lw $t3, 0($t1)
	sle $v1, $t2, $t3
	move $t9, $v1
	move $t3, $t9
	beqz $t3 L16
	li $s6, 4
	li $t3, 1
	add $v1, $t3, $t2
	move $t9, $v1
	move $t2, $t9
	mul $v1, $s6, $t2
	move $t9, $v1
	move $s6, $t9
	add $v1, $t1, $s6
	move $t9, $v1
	move $s6, $t9
	lw $t9, 0($s6)
	move $s6, $t9
	b L17
L16:
L17:
	nop
	div $v1, $s7, $s6
	move $t9, $v1
	move $s6, $t9
	move $s7, $s3
	li $t1, 2
	lw $t2, 0($s7)
	sle $v1, $t1, $t2
	move $t9, $v1
	move $t2, $t9
	beqz $t2 L18
	li $s4, 4
	li $t2, 1
	add $v1, $t2, $t1
	move $t9, $v1
	move $t1, $t9
	mul $v1, $s4, $t1
	move $t9, $v1
	move $s4, $t9
	add $v1, $s7, $s4
	move $t9, $v1
	move $s4, $t9
	lw $t9, 0($s4)
	move $s4, $t9
	b L19
L18:
L19:
	nop
	lw $v1, 32($sp)
	sub $v1, $s4, $v1
	move $t9, $v1
	move $s4, $t9
	add $v1, $s6, $s4
	move $t9, $v1
	move $s4, $t9
	sw $s4, 0($t0)
	b L13
L12:
L13:
	nop
	li $s4, 5
	lw $v1, 56($sp)
	mul $v1, $v1, $s4
	move $t9, $v1
	move $s4, $t9
	sle $v1, $s5, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L20
	li $s4, 1
	add $v1, $s5, $s4
	move $t9, $v1
	move $s4, $t9
	move $s5, $s4
	b L21
L20:
	li $s4, 1
	sub $v1, $s5, $s4
	move $t9, $v1
	move $s4, $t9
	move $s5, $s4
L21:
	nop
	li $s4, 1
	li $s6, 21
	sne $v1, $s5, $s6
	move $t9, $v1
	move $s6, $t9
	sne $v1, $s4, $s6
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L23
	li $s4, 1
	b L24
L23:
	li $s4, 0
	lw $v1, 56($sp)
	sle $v1, $v1, $s4
	move $t9, $v1
	move $s4, $t9
L24:
	nop
	beqz $s4 L22
	li $s4, 0
	lw $v1, 56($sp)
	add $v1, $v1, $s4
	move $t9, $v1
	move $s4, $t9
	move $v1, $s4
	sw $v1, 56($sp)
L22:
	nop
	move $s4, $s3
	li $s6, 3
	lw $s7, 0($s4)
	sle $v1, $s6, $s7
	move $t9, $v1
	move $s7, $t9
	beqz $s7 L25
	li $s2, 4
	li $s7, 1
	add $v1, $s7, $s6
	move $t9, $v1
	move $s6, $t9
	mul $v1, $s2, $s6
	move $t9, $v1
	move $s2, $t9
	add $v1, $s4, $s2
	move $t9, $v1
	move $s2, $t9
	lw $t9, 0($s2)
	move $s2, $t9
	b L26
L25:
L26:
	nop
	lw $v1, 32($sp)
	add $v1, $s2, $v1
	move $t9, $v1
	move $s2, $t9
	li $s4, 2
	lw $s6, 0($s3)
	sle $v1, $s4, $s6
	move $t9, $v1
	move $s6, $t9
	beqz $s6 L27
	li $s1, 4
	li $s6, 1
	add $v1, $s6, $s4
	move $t9, $v1
	move $s4, $t9
	mul $v1, $s1, $s4
	move $t9, $v1
	move $s1, $t9
	add $v1, $s3, $s1
	move $t9, $v1
	move $s1, $t9
	lw $t9, 0($s1)
	move $s1, $t9
	b L28
L27:
L28:
	nop
	add $v1, $s2, $s1
	move $t9, $v1
	move $s1, $t9
	sub $v1, $s1, $s5
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
	addu $sp, $sp, 68
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
