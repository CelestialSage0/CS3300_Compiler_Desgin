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
	la $s2, Runner3_run
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
	.globl Runner3_run
Runner3_run:
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
	li $s3, 3
	li $s4, 1
	add $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	li $s5, 4
	mul $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	sw $s3, 0($s4)
	li $s5, 1
L0:
	li $s6, 1
	sub $v1, $s3, $s6
	move $t9, $v1
	move $s6, $t9
	sle $v1, $s5, $s6
	move $t9, $v1
	move $s6, $t9
	beqz $s6 L1
	li $s6, 4
	mul $v1, $s6, $s5
	move $t9, $v1
	move $s6, $t9
	add $v1, $s6, $s4
	move $t9, $v1
	move $s6, $t9
	li $t0, 0
	sw $t0, 0($s6)
	li $s6, 1
	add $v1, $s5, $s6
	move $t9, $v1
	move $s5, $t9
	b L0
L1:
	nop
	move $s3, $s4
	move $s4, $s3
	li $s5, 0
	lw $s6, 0($s4)
	sle $v1, $s5, $s6
	move $t9, $v1
	move $s6, $t9
	beqz $s6 L2
	li $s6, 4
	li $t0, 1
	add $v1, $t0, $s5
	move $t9, $v1
	move $s5, $t9
	mul $v1, $s6, $s5
	move $t9, $v1
	move $s5, $t9
	add $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	li $s5, 7
	sw $s5, 0($s4)
	b L3
L2:
L3:
	nop
	li $s4, 8
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, _LAMBDA_0
	sw $s5, 0($s4)
	sw $s0, 4($s4)
	li $s5, 4
	add $v1, $s5, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s5, $v0
	li $s6, 4
	add $v1, $s6, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s6, $v0
	la $t0, Second_level_value
	sw $t0, 0($s5)
	sw $s5, 0($s6)
	move $s5, $s6
	lw $s6, 0($s5)
	lw $t9, 0($s6)
	move $s6, $t9
	move $t0, $s3
	li $t1, 0
	lw $t2, 0($t0)
	sle $v1, $t1, $t2
	move $t9, $v1
	move $t2, $t9
	beqz $t2 L4
	li $s7, 4
	li $t2, 1
	add $v1, $t2, $t1
	move $t9, $v1
	move $t1, $t9
	mul $v1, $s7, $t1
	move $t9, $v1
	move $s7, $t9
	add $v1, $t0, $s7
	move $t9, $v1
	move $s7, $t9
	lw $t9, 0($s7)
	move $s7, $t9
	b L5
L4:
L5:
	nop
	move $a0, $s5
	move $a1, $s7
	jalr $s6
	move $s5, $v0
	move $a0, $s5
	jal _print
	li $s5, 4
	add $v1, $s5, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s5, $v0
	li $s6, 4
	add $v1, $s6, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s6, $v0
	la $s7, First_level_value
	sw $s7, 0($s5)
	sw $s5, 0($s6)
	move $s5, $s6
	lw $s6, 0($s5)
	lw $t9, 0($s6)
	move $s6, $t9
	move $s7, $s3
	li $t0, 0
	lw $t1, 0($s7)
	sle $v1, $t0, $t1
	move $t9, $v1
	move $t1, $t9
	beqz $t1 L6
	li $s2, 4
	li $t1, 1
	add $v1, $t1, $t0
	move $t9, $v1
	move $t0, $t9
	mul $v1, $s2, $t0
	move $t9, $v1
	move $s2, $t9
	add $v1, $s7, $s2
	move $t9, $v1
	move $s2, $t9
	lw $t9, 0($s2)
	move $s2, $t9
	b L7
L6:
L7:
	nop
	move $a0, $s5
	move $a1, $s2
	jalr $s6
	move $s2, $v0
	move $a0, $s2
	jal _print
	move $s2, $s4
	lw $s4, 0($s2)
	li $s5, 0
	lw $s6, 0($s3)
	sle $v1, $s5, $s6
	move $t9, $v1
	move $s6, $t9
	beqz $s6 L8
	li $s1, 4
	li $s6, 1
	add $v1, $s6, $s5
	move $t9, $v1
	move $s5, $t9
	mul $v1, $s1, $s5
	move $t9, $v1
	move $s1, $t9
	add $v1, $s3, $s1
	move $t9, $v1
	move $s1, $t9
	lw $t9, 0($s1)
	move $s1, $t9
	b L9
L8:
L9:
	nop
	move $a0, $s2
	move $a1, $s1
	jalr $s4
	move $s1, $v0
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
	.globl Parent_value
Parent_value:
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
	.globl First_level_value
First_level_value:
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
	.globl Second_level_value
Second_level_value:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	li $s2, 100
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
