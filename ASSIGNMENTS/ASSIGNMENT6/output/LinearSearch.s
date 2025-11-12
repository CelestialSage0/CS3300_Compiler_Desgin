	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $s0, 16
	add $v1, $s0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s0, $v0
	li $s1, 12
	add $v1, $s1, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s1, $v0
	la $s2, LS_Print
	sw $s2, 0($s0)
	la $s2, LS_Init
	sw $s2, 4($s0)
	la $s2, LS_Start
	sw $s2, 8($s0)
	la $s2, LS_Search
	sw $s2, 12($s0)
	li $s2, 0
	sw $s2, 4($s1)
	li $s2, 0
	sw $s2, 8($s1)
	sw $s0, 0($s1)
	move $s0, $s1
	lw $s1, 0($s0)
	lw $t9, 8($s1)
	move $s1, $t9
	li $s2, 10
	move $a0, $s0
	move $a1, $s2
	jalr $s1
	move $s0, $v0
	move $a0, $s0
	jal _print
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	j $ra

	.text
	.globl LS_Start
LS_Start:
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
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 4($s3)
	move $s3, $t9
	move $a0, $s2
	move $a1, $s1
	jalr $s3
	move $s2, $v0
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 0($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	li $s2, 9999
	move $a0, $s2
	jal _print
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 12($s3)
	move $s3, $t9
	li $s4, 8
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $a0, $s2
	jal _print
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 12($s3)
	move $s3, $t9
	li $s4, 12
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $a0, $s2
	jal _print
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 12($s3)
	move $s3, $t9
	li $s4, 17
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $a0, $s2
	jal _print
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 12($s3)
	move $s3, $t9
	li $s4, 50
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $a0, $s2
	jal _print
	li $s2, 55
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
	.globl LS_Print
LS_Print:
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
	li $s1, 1
L0:
	lw $s3, 8($s0)
	li $s4, 1
	sub $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	sle $v1, $s1, $s3
	move $t9, $v1
	move $s3, $t9
	beqz $s3 L1
	lw $s3, 4($s0)
	move $s4, $s1
	lw $s5, 0($s3)
	sle $v1, $s4, $s5
	move $t9, $v1
	move $s5, $t9
	beqz $s5 L2
	li $s2, 4
	li $s5, 1
	add $v1, $s5, $s4
	move $t9, $v1
	move $s4, $t9
	mul $v1, $s2, $s4
	move $t9, $v1
	move $s2, $t9
	add $v1, $s3, $s2
	move $t9, $v1
	move $s2, $t9
	lw $t9, 0($s2)
	move $s2, $t9
	b L3
L2:
L3:
	nop
	move $s3, $s2
	move $a0, $s3
	jal _print
	li $s3, 1
	add $v1, $s1, $s3
	move $t9, $v1
	move $s1, $t9
	b L0
L1:
	nop
	li $s1, 0
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
	.globl LS_Search
LS_Search:
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
	li $s2, 1
	li $s3, 0
	li $s3, 0
L4:
	lw $s5, 8($s0)
	li $s6, 1
	sub $v1, $s5, $s6
	move $t9, $v1
	move $s5, $t9
	sle $v1, $s2, $s5
	move $t9, $v1
	move $s5, $t9
	beqz $s5 L5
	lw $s5, 4($s0)
	move $s6, $s2
	lw $s7, 0($s5)
	sle $v1, $s6, $s7
	move $t9, $v1
	move $s7, $t9
	beqz $s7 L6
	li $s4, 4
	li $s7, 1
	add $v1, $s7, $s6
	move $t9, $v1
	move $s6, $t9
	mul $v1, $s4, $s6
	move $t9, $v1
	move $s4, $t9
	add $v1, $s5, $s4
	move $t9, $v1
	move $s4, $t9
	lw $t9, 0($s4)
	move $s4, $t9
	b L7
L6:
L7:
	nop
	move $s5, $s4
	li $s6, 1
	add $v1, $s1, $s6
	move $t9, $v1
	move $s6, $t9
	sle $v1, $s5, $s1
	move $t9, $v1
	move $s7, $t9
	beqz $s7 L10
	sne $v1, $s5, $s1
	move $t9, $v1
	move $s7, $t9
	b L11
L10:
	li $s7, 0
L11:
	nop
	beqz $s7 L8
	li $s5, 0
	b L9
L8:
	li $s7, 1
	li $t0, 1
	sub $v1, $s6, $t0
	move $t9, $v1
	move $s6, $t9
	sle $v1, $s5, $s6
	move $t9, $v1
	move $s5, $t9
	sne $v1, $s7, $s5
	move $t9, $v1
	move $s5, $t9
	beqz $s5 L12
	li $s5, 0
	b L13
L12:
	li $s2, 1
	move $s3, $s2
	li $s2, 1
	move $s3, $s2
	lw $s2, 8($s0)
L13:
	nop
L9:
	nop
	li $s5, 1
	add $v1, $s2, $s5
	move $t9, $v1
	move $s2, $t9
	b L4
L5:
	nop
	move $s2, $s3
	move $v0, $s2
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
	.globl LS_Init
LS_Init:
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
	sw $s1, 8($s0)
	move $s2, $s1
	li $s3, 1
	add $v1, $s2, $s3
	move $t9, $v1
	move $s3, $t9
	li $s4, 4
	mul $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	sw $s2, 0($s3)
	li $s4, 1
L14:
	li $s5, 1
	sub $v1, $s2, $s5
	move $t9, $v1
	move $s5, $t9
	sle $v1, $s4, $s5
	move $t9, $v1
	move $s5, $t9
	beqz $s5 L15
	li $s5, 4
	mul $v1, $s5, $s4
	move $t9, $v1
	move $s5, $t9
	add $v1, $s5, $s3
	move $t9, $v1
	move $s5, $t9
	li $s6, 0
	sw $s6, 0($s5)
	li $s5, 1
	add $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	b L14
L15:
	nop
	move $s2, $s3
	sw $s2, 4($s0)
	li $s2, 1
	lw $s3, 8($s0)
	li $s4, 1
	add $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
L16:
	lw $s4, 8($s0)
	li $s5, 1
	sub $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	sle $v1, $s2, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L17
	li $s4, 2
	mul $v1, $s4, $s2
	move $t9, $v1
	move $s4, $t9
	li $s5, 3
	sub $v1, $s3, $s5
	move $t9, $v1
	move $s5, $t9
	lw $s6, 4($s0)
	move $s7, $s2
	lw $t0, 0($s6)
	sle $v1, $s7, $t0
	move $t9, $v1
	move $t0, $t9
	beqz $t0 L18
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
	add $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	sw $s4, 0($s6)
	b L19
L18:
L19:
	nop
	li $s4, 1
	add $v1, $s2, $s4
	move $t9, $v1
	move $s2, $t9
	li $s4, 1
	sub $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	b L16
L17:
	nop
	li $s2, 0
	move $v0, $s2
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
