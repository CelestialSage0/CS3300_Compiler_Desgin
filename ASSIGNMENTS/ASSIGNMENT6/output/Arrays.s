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
	la $s2, Wrapper_call
	sw $s2, 0($s0)
	la $s2, Wrapper_modify
	sw $s2, 4($s0)
	li $s2, 0
	sw $s2, 4($s1)
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
	li $s3, 10
	li $s5, 1
	add $v1, $s3, $s5
	move $t9, $v1
	move $s5, $t9
	li $s6, 4
	mul $v1, $s5, $s6
	move $t9, $v1
	move $s5, $t9
	add $v1, $s5, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s5, $v0
	sw $s3, 0($s5)
	li $s6, 1
L0:
	li $s7, 1
	sub $v1, $s3, $s7
	move $t9, $v1
	move $s7, $t9
	sle $v1, $s6, $s7
	move $t9, $v1
	move $s7, $t9
	beqz $s7 L1
	li $s7, 4
	mul $v1, $s7, $s6
	move $t9, $v1
	move $s7, $t9
	add $v1, $s7, $s5
	move $t9, $v1
	move $s7, $t9
	li $t0, 0
	sw $t0, 0($s7)
	li $s7, 1
	add $v1, $s6, $s7
	move $t9, $v1
	move $s6, $t9
	b L0
L1:
	nop
	move $s3, $s5
	sw $s3, 4($s0)
	li $s3, 5
	li $s5, 1
	add $v1, $s3, $s5
	move $t9, $v1
	move $s5, $t9
	li $s6, 4
	mul $v1, $s5, $s6
	move $t9, $v1
	move $s5, $t9
	add $v1, $s5, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s5, $v0
	sw $s3, 0($s5)
	li $s6, 1
L2:
	li $s7, 1
	sub $v1, $s3, $s7
	move $t9, $v1
	move $s7, $t9
	sle $v1, $s6, $s7
	move $t9, $v1
	move $s7, $t9
	beqz $s7 L3
	li $s7, 4
	mul $v1, $s7, $s6
	move $t9, $v1
	move $s7, $t9
	add $v1, $s7, $s5
	move $t9, $v1
	move $s7, $t9
	li $t0, 0
	sw $t0, 0($s7)
	li $s7, 1
	add $v1, $s6, $s7
	move $t9, $v1
	move $s6, $t9
	b L2
L3:
	nop
	move $s3, $s5
	li $s5, 0
L4:
	lw $s6, 0($s3)
	li $s7, 1
	sub $v1, $s6, $s7
	move $t9, $v1
	move $s6, $t9
	sle $v1, $s5, $s6
	move $t9, $v1
	move $s6, $t9
	beqz $s6 L5
	move $s6, $s3
	move $s7, $s5
	lw $t0, 0($s6)
	sle $v1, $s7, $t0
	move $t9, $v1
	move $t0, $t9
	beqz $t0 L6
	li $t0, 4
	li $t1, 1
	add $v1, $t1, $s7
	move $t9, $v1
	move $s7, $t9
	mul $v1, $t0, $s7
	move $t9, $v1
	move $s7, $t9
	add $v1, $s6, $s7
	move $t9, $v1
	move $s6, $t9
	li $s7, 1
	add $v1, $s5, $s7
	move $t9, $v1
	move $s7, $t9
	li $t0, 1
	add $v1, $s5, $t0
	move $t9, $v1
	move $t0, $t9
	mul $v1, $s7, $t0
	move $t9, $v1
	move $s7, $t9
	sw $s7, 0($s6)
	b L7
L6:
L7:
	nop
	li $s6, 1
	add $v1, $s5, $s6
	move $t9, $v1
	move $s5, $t9
	b L4
L5:
	nop
	li $s5, 0
L8:
	lw $s6, 4($s0)
	lw $t9, 0($s6)
	move $s6, $t9
	li $s7, 1
	sub $v1, $s6, $s7
	move $t9, $v1
	move $s6, $t9
	sle $v1, $s5, $s6
	move $t9, $v1
	move $s6, $t9
	beqz $s6 L9
	move $s6, $s5
L10:
	li $s7, 1
	lw $t0, 0($s3)
	li $t1, 1
	sub $v1, $t0, $t1
	move $t9, $v1
	move $t0, $t9
	sle $v1, $s6, $t0
	move $t9, $v1
	move $t0, $t9
	sne $v1, $s7, $t0
	move $t9, $v1
	move $s7, $t9
	beqz $s7 L11
	lw $s7, 0($s3)
	sub $v1, $s6, $s7
	move $t9, $v1
	move $s6, $t9
	b L10
L11:
	nop
	lw $s7, 4($s0)
	move $t0, $s5
	lw $t1, 0($s7)
	sle $v1, $t0, $t1
	move $t9, $v1
	move $t1, $t9
	beqz $t1 L12
	li $t1, 4
	li $t2, 1
	add $v1, $t2, $t0
	move $t9, $v1
	move $t0, $t9
	mul $v1, $t1, $t0
	move $t9, $v1
	move $t0, $t9
	add $v1, $s7, $t0
	move $t9, $v1
	move $s7, $t9
	move $t0, $s3
	lw $t1, 0($t0)
	sle $v1, $s6, $t1
	move $t9, $v1
	move $t1, $t9
	beqz $t1 L14
	li $s4, 4
	li $t1, 1
	add $v1, $t1, $s6
	move $t9, $v1
	move $s6, $t9
	mul $v1, $s4, $s6
	move $t9, $v1
	move $s4, $t9
	add $v1, $t0, $s4
	move $t9, $v1
	move $s4, $t9
	lw $t9, 0($s4)
	move $s4, $t9
	b L15
L14:
L15:
	nop
	move $s6, $s4
	sw $s6, 0($s7)
	b L13
L12:
L13:
	nop
	li $s6, 1
	add $v1, $s5, $s6
	move $t9, $v1
	move $s5, $t9
	b L8
L9:
	nop
	move $s4, $s0
	lw $s5, 0($s4)
	lw $t9, 4($s5)
	move $s5, $t9
	move $a0, $s4
	jalr $s5
	move $s4, $v0
	move $s6, $s4
	li $s4, 0
	move $s5, $s4
L16:
	lw $s4, 4($s0)
	lw $t9, 0($s4)
	move $s4, $t9
	li $s6, 1
	sub $v1, $s4, $s6
	move $t9, $v1
	move $s4, $t9
	sle $v1, $s5, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L17
	lw $s4, 4($s0)
	move $s6, $s5
	lw $s7, 0($s4)
	sle $v1, $s6, $s7
	move $t9, $v1
	move $s7, $t9
	beqz $s7 L18
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
	b L19
L18:
L19:
	nop
	move $s4, $s2
	move $a0, $s4
	jal _print
	li $s4, 1
	add $v1, $s5, $s4
	move $t9, $v1
	move $s4, $t9
	move $s5, $s4
	b L16
L17:
	nop
	li $s2, 0
	move $s6, $s2
L20:
	lw $s2, 0($s3)
	li $s4, 1
	sub $v1, $s2, $s4
	move $t9, $v1
	move $s2, $t9
	sle $v1, $s6, $s2
	move $t9, $v1
	move $s2, $t9
	beqz $s2 L21
	move $s2, $s3
	move $s4, $s6
	lw $s5, 0($s2)
	sle $v1, $s4, $s5
	move $t9, $v1
	move $s5, $t9
	beqz $s5 L22
	li $s1, 4
	li $s5, 1
	add $v1, $s5, $s4
	move $t9, $v1
	move $s4, $t9
	mul $v1, $s1, $s4
	move $t9, $v1
	move $s1, $t9
	add $v1, $s2, $s1
	move $t9, $v1
	move $s1, $t9
	lw $t9, 0($s1)
	move $s1, $t9
	b L23
L22:
L23:
	nop
	move $s2, $s1
	move $a0, $s2
	jal _print
	li $s2, 1
	add $v1, $s6, $s2
	move $t9, $v1
	move $s2, $t9
	move $s6, $s2
	b L20
L21:
	nop
	li $s1, 0
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
	.globl Wrapper_modify
Wrapper_modify:
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
	li $s1, 0
L24:
	lw $s4, 4($s0)
	lw $t9, 0($s4)
	move $s4, $t9
	li $s5, 1
	sub $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	sle $v1, $s1, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L25
	lw $s4, 4($s0)
	move $s5, $s1
	lw $s6, 0($s4)
	sle $v1, $s5, $s6
	move $t9, $v1
	move $s6, $t9
	beqz $s6 L26
	li $s6, 4
	li $s7, 1
	add $v1, $s7, $s5
	move $t9, $v1
	move $s5, $t9
	mul $v1, $s6, $s5
	move $t9, $v1
	move $s5, $t9
	add $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	lw $s5, 4($s0)
	move $s6, $s1
	lw $s7, 0($s5)
	sle $v1, $s6, $s7
	move $t9, $v1
	move $s7, $t9
	beqz $s7 L28
	li $s2, 4
	li $s7, 1
	add $v1, $s7, $s6
	move $t9, $v1
	move $s6, $t9
	mul $v1, $s2, $s6
	move $t9, $v1
	move $s2, $t9
	add $v1, $s5, $s2
	move $t9, $v1
	move $s2, $t9
	lw $t9, 0($s2)
	move $s2, $t9
	b L29
L28:
L29:
	nop
	move $s5, $s2
	lw $s6, 4($s0)
	move $s7, $s1
	lw $t0, 0($s6)
	sle $v1, $s7, $t0
	move $t9, $v1
	move $t0, $t9
	beqz $t0 L30
	li $s3, 4
	li $t0, 1
	add $v1, $t0, $s7
	move $t9, $v1
	move $s7, $t9
	mul $v1, $s3, $s7
	move $t9, $v1
	move $s3, $t9
	add $v1, $s6, $s3
	move $t9, $v1
	move $s3, $t9
	lw $t9, 0($s3)
	move $s3, $t9
	b L31
L30:
L31:
	nop
	move $s6, $s3
	mul $v1, $s5, $s6
	move $t9, $v1
	move $s5, $t9
	sw $s5, 0($s4)
	b L27
L26:
L27:
	nop
	li $s4, 1
	add $v1, $s1, $s4
	move $t9, $v1
	move $s1, $t9
	b L24
L25:
	nop
	li $s1, 0
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
