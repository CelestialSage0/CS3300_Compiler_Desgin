	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $s0, 24
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
	la $s2, BS_Div
	sw $s2, 0($s0)
	la $s2, BS_Print
	sw $s2, 4($s0)
	la $s2, BS_Init
	sw $s2, 8($s0)
	la $s2, BS_Start
	sw $s2, 12($s0)
	la $s2, BS_Search
	sw $s2, 16($s0)
	la $s2, BS_Compare
	sw $s2, 20($s0)
	li $s2, 0
	sw $s2, 4($s1)
	li $s2, 0
	sw $s2, 8($s1)
	sw $s0, 0($s1)
	move $s0, $s1
	lw $s1, 0($s0)
	lw $t9, 12($s1)
	move $s1, $t9
	li $s2, 20
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
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
	.globl BS_Start
BS_Start:
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
	lw $t9, 8($s3)
	move $s3, $t9
	move $a0, $s2
	move $a1, $s1
	jalr $s3
	move $s2, $v0
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 4($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 8
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	beqz $s2 L0
	li $s2, 1
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
	b L1
L0:
	li $s2, 0
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
L1:
	nop
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 19
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	beqz $s2 L2
	li $s2, 1
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
	b L3
L2:
	li $s2, 0
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
L3:
	nop
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 20
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	beqz $s2 L4
	li $s2, 1
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
	b L5
L4:
	li $s2, 0
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
L5:
	nop
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 21
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	beqz $s2 L6
	li $s2, 1
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
	b L7
L6:
	li $s2, 0
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
L7:
	nop
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 37
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	beqz $s2 L8
	li $s2, 1
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
	b L9
L8:
	li $s2, 0
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
L9:
	nop
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 38
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	beqz $s2 L10
	li $s2, 1
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
	b L11
L10:
	li $s2, 0
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
L11:
	nop
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 39
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	beqz $s2 L12
	li $s2, 1
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
	b L13
L12:
	li $s2, 0
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
L13:
	nop
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 16($s3)
	move $s3, $t9
	li $s4, 50
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	beqz $s2 L14
	li $s2, 1
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
	b L15
L14:
	li $s2, 0
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
L15:
	nop
	li $s2, 999
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
	.globl BS_Search
BS_Search:
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
	li $s3, 0
	move $s5, $s3
	li $s3, 0
	lw $s3, 4($s0)
	lw $t9, 0($s3)
	move $s3, $t9
	li $s4, 1
	sub $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	li $s4, 0
	li $s6, 1
L16:
	beqz $s6 L17
	add $v1, $s4, $s3
	move $t9, $v1
	move $s5, $t9
	move $s6, $s5
	move $s5, $s0
	lw $s7, 0($s5)
	lw $t9, 0($s7)
	move $s7, $t9
	move $a0, $s5
	move $a1, $s6
	jalr $s7
	move $s5, $v0
	move $s6, $s5
	lw $s5, 4($s0)
	move $s7, $s6
	lw $t0, 0($s5)
	sle $v1, $s7, $t0
	move $t9, $v1
	move $t0, $t9
	beqz $t0 L18
	li $s2, 4
	li $t0, 1
	add $v1, $t0, $s7
	move $t9, $v1
	move $s7, $t9
	mul $v1, $s2, $s7
	move $t9, $v1
	move $s2, $t9
	add $v1, $s5, $s2
	move $t9, $v1
	move $s2, $t9
	lw $t9, 0($s2)
	move $s2, $t9
	b L19
L18:
L19:
	nop
	move $s5, $s2
	li $s7, 1
	sub $v1, $s5, $s7
	move $t9, $v1
	move $s7, $t9
	sle $v1, $s1, $s7
	move $t9, $v1
	move $s7, $t9
	beqz $s7 L20
	li $s3, 1
	sub $v1, $s6, $s3
	move $t9, $v1
	move $s3, $t9
	b L21
L20:
	li $s4, 1
	add $v1, $s6, $s4
	move $t9, $v1
	move $s4, $t9
L21:
	nop
	move $s6, $s0
	lw $s7, 0($s6)
	lw $t9, 20($s7)
	move $s7, $t9
	move $a0, $s6
	move $a1, $s5
	move $a2, $s1
	jalr $s7
	move $s6, $v0
	beqz $s6 L22
	li $s6, 0
	b L23
L22:
	li $s6, 1
L23:
	nop
	li $s7, 1
	sub $v1, $s4, $s7
	move $t9, $v1
	move $s7, $t9
	sle $v1, $s3, $s7
	move $t9, $v1
	move $s7, $t9
	beqz $s7 L24
	li $s6, 0
	b L25
L24:
	li $s7, 0
L25:
	nop
	b L16
L17:
	nop
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 20($s3)
	move $s3, $t9
	move $a0, $s2
	move $a1, $s5
	move $a2, $s1
	jalr $s3
	move $s2, $v0
	beqz $s2 L26
	li $s2, 1
	move $s3, $s2
	b L27
L26:
	li $s2, 0
	move $s3, $s2
L27:
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
	.globl BS_Div
BS_Div:
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
	li $s2, 0
	li $s3, 0
	li $s4, 1
	sub $v1, $s1, $s4
	move $t9, $v1
	move $s4, $t9
L28:
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s5, $t9
	beqz $s5 L30
	sne $v1, $s3, $s4
	move $t9, $v1
	move $s5, $t9
	b L31
L30:
	li $s5, 0
L31:
	nop
	beqz $s5 L29
	li $s5, 1
	add $v1, $s2, $s5
	move $t9, $v1
	move $s2, $t9
	li $s5, 2
	add $v1, $s3, $s5
	move $t9, $v1
	move $s3, $t9
	b L28
L29:
	nop
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
	.globl BS_Compare
BS_Compare:
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
	move $s2, $a2
	li $s3, 0
	li $s3, 1
	add $v1, $s2, $s3
	move $t9, $v1
	move $s3, $t9
	li $s4, 1
	sub $v1, $s2, $s4
	move $t9, $v1
	move $s4, $t9
	sle $v1, $s1, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L32
	li $s3, 0
	b L33
L32:
	li $s4, 1
	li $s5, 1
	sub $v1, $s3, $s5
	move $t9, $v1
	move $s3, $t9
	sle $v1, $s1, $s3
	move $t9, $v1
	move $s3, $t9
	sne $v1, $s4, $s3
	move $t9, $v1
	move $s3, $t9
	beqz $s3 L34
	li $s3, 0
	b L35
L34:
	li $s3, 1
L35:
	nop
L33:
	nop
	move $v0, $s3
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
	.globl BS_Print
BS_Print:
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
L36:
	lw $s3, 8($s0)
	sle $v1, $s1, $s3
	move $t9, $v1
	move $s3, $t9
	beqz $s3 L38
	lw $s3, 8($s0)
	sne $v1, $s1, $s3
	move $t9, $v1
	move $s3, $t9
	b L39
L38:
	li $s3, 0
L39:
	nop
	beqz $s3 L37
	lw $s3, 4($s0)
	move $s4, $s1
	lw $s5, 0($s3)
	sle $v1, $s4, $s5
	move $t9, $v1
	move $s5, $t9
	beqz $s5 L40
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
	b L41
L40:
L41:
	nop
	move $s3, $s2
	move $a0, $s3
	jal _print
	li $s3, 1
	add $v1, $s1, $s3
	move $t9, $v1
	move $s1, $t9
	b L36
L37:
	nop
	li $s1, 9999
	li $s2, 0
	add $v1, $s1, $s2
	move $t9, $v1
	move $s1, $t9
	move $a0, $s1
	jal _print
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
	.globl BS_Init
BS_Init:
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
L42:
	li $s5, 1
	sub $v1, $s2, $s5
	move $t9, $v1
	move $s5, $t9
	sle $v1, $s4, $s5
	move $t9, $v1
	move $s5, $t9
	beqz $s5 L43
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
	b L42
L43:
	nop
	move $s2, $s3
	sw $s2, 4($s0)
	li $s2, 1
	lw $s3, 8($s0)
	li $s4, 1
	add $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
L44:
	lw $s4, 8($s0)
	li $s5, 1
	sub $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	sle $v1, $s2, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L45
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
	beqz $t0 L46
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
	b L47
L46:
L47:
	nop
	li $s4, 1
	add $v1, $s2, $s4
	move $t9, $v1
	move $s2, $t9
	li $s4, 1
	sub $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	b L44
L45:
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
