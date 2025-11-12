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
	la $s2, BBS_Print
	sw $s2, 0($s0)
	la $s2, BBS_Init
	sw $s2, 4($s0)
	la $s2, BBS_Start
	sw $s2, 8($s0)
	la $s2, BBS_Sort
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
	.globl BBS_Start
BBS_Start:
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
	li $s2, 99999
	move $a0, $s2
	jal _print
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 12($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 0($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	li $s2, 0
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
	.globl BBS_Sort
BBS_Sort:
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
	lw $s1, 8($s0)
	li $s6, 1
	sub $v1, $s1, $s6
	move $t9, $v1
	move $s1, $t9
	li $s6, 0
	li $s7, 1
	sub $v1, $s6, $s7
	move $t9, $v1
	move $s6, $t9
L0:
	li $s7, 1
	sub $v1, $s1, $s7
	move $t9, $v1
	move $s7, $t9
	sle $v1, $s6, $s7
	move $t9, $v1
	move $s7, $t9
	beqz $s7 L1
	li $s7, 1
L2:
	sle $v1, $s7, $s1
	move $t9, $v1
	move $t0, $t9
	beqz $t0 L3
	li $t0, 1
	sub $v1, $s7, $t0
	move $t9, $v1
	move $t0, $t9
	move $t1, $t0
	lw $t0, 4($s0)
	lw $t2, 0($t0)
	sle $v1, $t1, $t2
	move $t9, $v1
	move $t2, $t9
	beqz $t2 L4
	li $s2, 4
	li $t2, 1
	add $v1, $t2, $t1
	move $t9, $v1
	move $t1, $t9
	mul $v1, $s2, $t1
	move $t9, $v1
	move $s2, $t9
	add $v1, $t0, $s2
	move $t9, $v1
	move $s2, $t9
	lw $t9, 0($s2)
	move $s2, $t9
	b L5
L4:
L5:
	nop
	move $t0, $s2
	lw $t1, 4($s0)
	move $t2, $s7
	lw $t3, 0($t1)
	sle $v1, $t2, $t3
	move $t9, $v1
	move $t3, $t9
	beqz $t3 L6
	li $s3, 4
	li $t3, 1
	add $v1, $t3, $t2
	move $t9, $v1
	move $t2, $t9
	mul $v1, $s3, $t2
	move $t9, $v1
	move $s3, $t9
	add $v1, $t1, $s3
	move $t9, $v1
	move $s3, $t9
	lw $t9, 0($s3)
	move $s3, $t9
	b L7
L6:
L7:
	nop
	move $t1, $s3
	li $t2, 1
	sub $v1, $t0, $t2
	move $t9, $v1
	move $t0, $t9
	sle $v1, $t1, $t0
	move $t9, $v1
	move $t0, $t9
	beqz $t0 L8
	li $t0, 1
	sub $v1, $s7, $t0
	move $t9, $v1
	move $t0, $t9
	move $t1, $t0
	lw $t0, 4($s0)
	move $t2, $t1
	lw $t3, 0($t0)
	sle $v1, $t2, $t3
	move $t9, $v1
	move $t3, $t9
	beqz $t3 L10
	li $s4, 4
	li $t3, 1
	add $v1, $t3, $t2
	move $t9, $v1
	move $t2, $t9
	mul $v1, $s4, $t2
	move $t9, $v1
	move $s4, $t9
	add $v1, $t0, $s4
	move $t9, $v1
	move $s4, $t9
	lw $t9, 0($s4)
	move $s4, $t9
	b L11
L10:
L11:
	nop
	move $t0, $s4
	lw $t2, 4($s0)
	lw $t3, 0($t2)
	sle $v1, $t1, $t3
	move $t9, $v1
	move $t3, $t9
	beqz $t3 L12
	li $t3, 4
	li $t4, 1
	add $v1, $t4, $t1
	move $t9, $v1
	move $t1, $t9
	mul $v1, $t3, $t1
	move $t9, $v1
	move $t1, $t9
	add $v1, $t2, $t1
	move $t9, $v1
	move $t1, $t9
	lw $t2, 4($s0)
	move $t3, $s7
	lw $t4, 0($t2)
	sle $v1, $t3, $t4
	move $t9, $v1
	move $t4, $t9
	beqz $t4 L14
	li $s5, 4
	li $t4, 1
	add $v1, $t4, $t3
	move $t9, $v1
	move $t3, $t9
	mul $v1, $s5, $t3
	move $t9, $v1
	move $s5, $t9
	add $v1, $t2, $s5
	move $t9, $v1
	move $s5, $t9
	lw $t9, 0($s5)
	move $s5, $t9
	b L15
L14:
L15:
	nop
	move $t2, $s5
	sw $t2, 0($t1)
	b L13
L12:
L13:
	nop
	lw $t1, 4($s0)
	move $t2, $s7
	lw $t3, 0($t1)
	sle $v1, $t2, $t3
	move $t9, $v1
	move $t3, $t9
	beqz $t3 L16
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
	sw $t0, 0($t1)
	b L17
L16:
L17:
	nop
	b L9
L8:
	li $t0, 0
L9:
	nop
	li $t0, 1
	add $v1, $s7, $t0
	move $t9, $v1
	move $s7, $t9
	b L2
L3:
	nop
	li $s7, 1
	sub $v1, $s1, $s7
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
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	addu $sp, $sp, 40
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl BBS_Print
BBS_Print:
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
	li $s1, 0
L18:
	lw $s3, 8($s0)
	li $s4, 1
	sub $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	sle $v1, $s1, $s3
	move $t9, $v1
	move $s3, $t9
	beqz $s3 L19
	lw $s3, 4($s0)
	move $s4, $s1
	lw $s5, 0($s3)
	sle $v1, $s4, $s5
	move $t9, $v1
	move $s5, $t9
	beqz $s5 L20
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
	b L21
L20:
L21:
	nop
	move $s3, $s2
	move $a0, $s3
	jal _print
	li $s3, 1
	add $v1, $s1, $s3
	move $t9, $v1
	move $s1, $t9
	b L18
L19:
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
	.globl BBS_Init
BBS_Init:
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
L22:
	li $s5, 1
	sub $v1, $s2, $s5
	move $t9, $v1
	move $s5, $t9
	sle $v1, $s4, $s5
	move $t9, $v1
	move $s5, $t9
	beqz $s5 L23
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
	b L22
L23:
	nop
	move $s2, $s3
	sw $s2, 4($s0)
	lw $s2, 4($s0)
	li $s3, 0
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L24
	li $s4, 4
	li $s5, 1
	add $v1, $s5, $s3
	move $t9, $v1
	move $s3, $t9
	mul $v1, $s4, $s3
	move $t9, $v1
	move $s3, $t9
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	li $s3, 20
	sw $s3, 0($s2)
	b L25
L24:
L25:
	nop
	lw $s2, 4($s0)
	li $s3, 1
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L26
	li $s4, 4
	li $s5, 1
	add $v1, $s5, $s3
	move $t9, $v1
	move $s3, $t9
	mul $v1, $s4, $s3
	move $t9, $v1
	move $s3, $t9
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	li $s3, 7
	sw $s3, 0($s2)
	b L27
L26:
L27:
	nop
	lw $s2, 4($s0)
	li $s3, 2
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L28
	li $s4, 4
	li $s5, 1
	add $v1, $s5, $s3
	move $t9, $v1
	move $s3, $t9
	mul $v1, $s4, $s3
	move $t9, $v1
	move $s3, $t9
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	li $s3, 12
	sw $s3, 0($s2)
	b L29
L28:
L29:
	nop
	lw $s2, 4($s0)
	li $s3, 3
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L30
	li $s4, 4
	li $s5, 1
	add $v1, $s5, $s3
	move $t9, $v1
	move $s3, $t9
	mul $v1, $s4, $s3
	move $t9, $v1
	move $s3, $t9
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	li $s3, 18
	sw $s3, 0($s2)
	b L31
L30:
L31:
	nop
	lw $s2, 4($s0)
	li $s3, 4
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L32
	li $s4, 4
	li $s5, 1
	add $v1, $s5, $s3
	move $t9, $v1
	move $s3, $t9
	mul $v1, $s4, $s3
	move $t9, $v1
	move $s3, $t9
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	li $s3, 2
	sw $s3, 0($s2)
	b L33
L32:
L33:
	nop
	lw $s2, 4($s0)
	li $s3, 5
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L34
	li $s4, 4
	li $s5, 1
	add $v1, $s5, $s3
	move $t9, $v1
	move $s3, $t9
	mul $v1, $s4, $s3
	move $t9, $v1
	move $s3, $t9
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	li $s3, 11
	sw $s3, 0($s2)
	b L35
L34:
L35:
	nop
	lw $s2, 4($s0)
	li $s3, 6
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L36
	li $s4, 4
	li $s5, 1
	add $v1, $s5, $s3
	move $t9, $v1
	move $s3, $t9
	mul $v1, $s4, $s3
	move $t9, $v1
	move $s3, $t9
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	li $s3, 6
	sw $s3, 0($s2)
	b L37
L36:
L37:
	nop
	lw $s2, 4($s0)
	li $s3, 7
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L38
	li $s4, 4
	li $s5, 1
	add $v1, $s5, $s3
	move $t9, $v1
	move $s3, $t9
	mul $v1, $s4, $s3
	move $t9, $v1
	move $s3, $t9
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	li $s3, 9
	sw $s3, 0($s2)
	b L39
L38:
L39:
	nop
	lw $s2, 4($s0)
	li $s3, 8
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L40
	li $s4, 4
	li $s5, 1
	add $v1, $s5, $s3
	move $t9, $v1
	move $s3, $t9
	mul $v1, $s4, $s3
	move $t9, $v1
	move $s3, $t9
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	li $s3, 19
	sw $s3, 0($s2)
	b L41
L40:
L41:
	nop
	lw $s2, 4($s0)
	li $s3, 9
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L42
	li $s4, 4
	li $s5, 1
	add $v1, $s5, $s3
	move $t9, $v1
	move $s3, $t9
	mul $v1, $s4, $s3
	move $t9, $v1
	move $s3, $t9
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	li $s3, 5
	sw $s3, 0($s2)
	b L43
L42:
L43:
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
	addu $sp, $sp, 36
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
