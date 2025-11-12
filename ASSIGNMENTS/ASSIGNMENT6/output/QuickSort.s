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
	la $s2, QS_Print
	sw $s2, 0($s0)
	la $s2, QS_Init
	sw $s2, 4($s0)
	la $s2, QS_Start
	sw $s2, 8($s0)
	la $s2, QS_Sort
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
	.globl QS_Start
QS_Start:
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
	lw $s2, 8($s0)
	li $s3, 1
	sub $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	move $s3, $s0
	lw $s4, 0($s3)
	lw $t9, 12($s4)
	move $s4, $t9
	li $s5, 0
	move $a0, $s3
	move $a1, $s5
	move $a2, $s2
	jalr $s4
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
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	addu $sp, $sp, 32
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl QS_Sort
QS_Sort:
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
	move $s2, $a2
	li $s6, 0
	sle $v1, $s1, $s2
	move $t9, $v1
	move $t3, $t9
	beqz $t3 L2
	sne $v1, $s1, $s2
	move $t9, $v1
	move $t3, $t9
	b L3
L2:
	li $t3, 0
L3:
	nop
	beqz $t3 L0
	lw $t3, 4($s0)
	move $t4, $s2
	lw $t5, 0($t3)
	sle $v1, $t4, $t5
	move $t9, $v1
	move $t5, $t9
	beqz $t5 L4
	li $s3, 4
	li $t5, 1
	add $v1, $t5, $t4
	move $t9, $v1
	move $t4, $t9
	mul $v1, $s3, $t4
	move $t9, $v1
	move $s3, $t9
	add $v1, $t3, $s3
	move $t9, $v1
	move $s3, $t9
	lw $t9, 0($s3)
	move $s3, $t9
	b L5
L4:
L5:
	nop
	move $t3, $s3
	li $s3, 1
	sub $v1, $s1, $s3
	move $t9, $v1
	move $s3, $t9
	move $t4, $s2
	li $t5, 1
L6:
	beqz $t5 L7
	li $s6, 1
L8:
	beqz $s6 L9
	li $s6, 1
	add $v1, $s3, $s6
	move $t9, $v1
	move $s3, $t9
	lw $s6, 4($s0)
	move $t5, $s3
	lw $t6, 0($s6)
	sle $v1, $t5, $t6
	move $t9, $v1
	move $t6, $t9
	beqz $t6 L10
	li $s7, 4
	li $t6, 1
	add $v1, $t6, $t5
	move $t9, $v1
	move $t5, $t9
	mul $v1, $s7, $t5
	move $t9, $v1
	move $s7, $t9
	add $v1, $s6, $s7
	move $t9, $v1
	move $s6, $t9
	lw $s7, 0($s6)
	b L11
L10:
L11:
	nop
	move $s6, $s7
	li $t5, 1
	li $t6, 1
	sub $v1, $t3, $t6
	move $t9, $v1
	move $t6, $t9
	sle $v1, $s6, $t6
	move $t9, $v1
	move $s6, $t9
	sne $v1, $t5, $s6
	move $t9, $v1
	move $s6, $t9
	beqz $s6 L12
	li $s6, 0
	b L13
L12:
	li $s6, 1
L13:
	nop
	b L8
L9:
	nop
	li $s6, 1
L14:
	beqz $s6 L15
	li $s6, 1
	sub $v1, $t4, $s6
	move $t9, $v1
	move $s6, $t9
	move $t4, $s6
	lw $s6, 4($s0)
	move $t5, $t4
	lw $t6, 0($s6)
	sle $v1, $t5, $t6
	move $t9, $v1
	move $t6, $t9
	beqz $t6 L16
	li $t0, 4
	li $t6, 1
	add $v1, $t6, $t5
	move $t9, $v1
	move $t5, $t9
	mul $v1, $t0, $t5
	move $t9, $v1
	move $t0, $t9
	add $v1, $s6, $t0
	move $t9, $v1
	move $s6, $t9
	lw $t0, 0($s6)
	b L17
L16:
L17:
	nop
	move $s6, $t0
	li $t5, 1
	li $t6, 1
	sub $v1, $s6, $t6
	move $t9, $v1
	move $s6, $t9
	sle $v1, $t3, $s6
	move $t9, $v1
	move $s6, $t9
	sne $v1, $t5, $s6
	move $t9, $v1
	move $s6, $t9
	beqz $s6 L18
	li $s6, 0
	b L19
L18:
	li $s6, 1
L19:
	nop
	b L14
L15:
	nop
	lw $s6, 4($s0)
	move $t5, $s3
	lw $t6, 0($s6)
	sle $v1, $t5, $t6
	move $t9, $v1
	move $t6, $t9
	beqz $t6 L20
	li $t1, 4
	li $t6, 1
	add $v1, $t6, $t5
	move $t9, $v1
	move $t5, $t9
	mul $v1, $t1, $t5
	move $t9, $v1
	move $t1, $t9
	add $v1, $s6, $t1
	move $t9, $v1
	move $s6, $t9
	lw $t1, 0($s6)
	b L21
L20:
L21:
	nop
	move $s6, $t1
	lw $t5, 4($s0)
	move $t6, $s3
	lw $t7, 0($t5)
	sle $v1, $t6, $t7
	move $t9, $v1
	move $t7, $t9
	beqz $t7 L22
	li $t7, 4
	li $t8, 1
	add $v1, $t8, $t6
	move $t9, $v1
	move $t6, $t9
	mul $v1, $t7, $t6
	move $t9, $v1
	move $t6, $t9
	add $v1, $t5, $t6
	move $t9, $v1
	move $t5, $t9
	lw $t6, 4($s0)
	move $t7, $t4
	lw $t8, 0($t6)
	sle $v1, $t7, $t8
	move $t9, $v1
	move $t8, $t9
	beqz $t8 L24
	li $t2, 4
	li $t8, 1
	add $v1, $t8, $t7
	move $t9, $v1
	move $t7, $t9
	mul $v1, $t2, $t7
	move $t9, $v1
	move $t2, $t9
	add $v1, $t6, $t2
	move $t9, $v1
	move $t2, $t9
	lw $t9, 0($t2)
	move $t2, $t9
	b L25
L24:
L25:
	nop
	move $t6, $t2
	sw $t6, 0($t5)
	b L23
L22:
L23:
	nop
	lw $t5, 4($s0)
	move $t6, $t4
	lw $t7, 0($t5)
	sle $v1, $t6, $t7
	move $t9, $v1
	move $t7, $t9
	beqz $t7 L26
	li $t7, 4
	li $t8, 1
	add $v1, $t8, $t6
	move $t9, $v1
	move $t6, $t9
	mul $v1, $t7, $t6
	move $t9, $v1
	move $t6, $t9
	add $v1, $t5, $t6
	move $t9, $v1
	move $t5, $t9
	sw $s6, 0($t5)
	b L27
L26:
L27:
	nop
	sle $v1, $t4, $s3
	move $t9, $v1
	move $t5, $t9
	beqz $t5 L28
	li $t5, 0
	b L29
L28:
	li $t5, 1
L29:
	nop
	b L6
L7:
	nop
	lw $s7, 4($s0)
	move $t0, $t4
	lw $t1, 0($s7)
	sle $v1, $t0, $t1
	move $t9, $v1
	move $t1, $t9
	beqz $t1 L30
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
	lw $t0, 4($s0)
	move $t1, $s3
	lw $t2, 0($t0)
	sle $v1, $t1, $t2
	move $t9, $v1
	move $t2, $t9
	beqz $t2 L32
	li $s5, 4
	li $t2, 1
	add $v1, $t2, $t1
	move $t9, $v1
	move $t1, $t9
	mul $v1, $s5, $t1
	move $t9, $v1
	move $s5, $t9
	add $v1, $t0, $s5
	move $t9, $v1
	move $s5, $t9
	lw $t9, 0($s5)
	move $s5, $t9
	b L33
L32:
L33:
	nop
	sw $s5, 0($s7)
	b L31
L30:
L31:
	nop
	lw $s5, 4($s0)
	move $s7, $s3
	lw $t0, 0($s5)
	sle $v1, $s7, $t0
	move $t9, $v1
	move $t0, $t9
	beqz $t0 L34
	li $t0, 4
	li $t1, 1
	add $v1, $t1, $s7
	move $t9, $v1
	move $s7, $t9
	mul $v1, $t0, $s7
	move $t9, $v1
	move $s7, $t9
	add $v1, $s5, $s7
	move $t9, $v1
	move $s5, $t9
	lw $s7, 4($s0)
	move $t0, $s2
	lw $t1, 0($s7)
	sle $v1, $t0, $t1
	move $t9, $v1
	move $t1, $t9
	beqz $t1 L36
	li $s4, 4
	li $t1, 1
	add $v1, $t1, $t0
	move $t9, $v1
	move $t0, $t9
	mul $v1, $s4, $t0
	move $t9, $v1
	move $s4, $t9
	add $v1, $s7, $s4
	move $t9, $v1
	move $s4, $t9
	lw $t9, 0($s4)
	move $s4, $t9
	b L37
L36:
L37:
	nop
	sw $s4, 0($s5)
	b L35
L34:
L35:
	nop
	lw $s4, 4($s0)
	move $s5, $s2
	lw $s7, 0($s4)
	sle $v1, $s5, $s7
	move $t9, $v1
	move $s7, $t9
	beqz $s7 L38
	li $s7, 4
	li $t0, 1
	add $v1, $t0, $s5
	move $t9, $v1
	move $s5, $t9
	mul $v1, $s7, $s5
	move $t9, $v1
	move $s5, $t9
	add $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	sw $s6, 0($s4)
	b L39
L38:
L39:
	nop
	move $s4, $s0
	lw $s5, 0($s4)
	lw $t9, 12($s5)
	move $s5, $t9
	li $s6, 1
	sub $v1, $s3, $s6
	move $t9, $v1
	move $s6, $t9
	move $a0, $s4
	move $a1, $s1
	move $a2, $s6
	jalr $s5
	move $s4, $v0
	move $s4, $s0
	lw $s5, 0($s4)
	lw $t9, 12($s5)
	move $s5, $t9
	li $s6, 1
	add $v1, $s3, $s6
	move $t9, $v1
	move $s3, $t9
	move $a0, $s4
	move $a1, $s3
	move $a2, $s2
	jalr $s5
	move $s3, $v0
	move $s4, $s3
	b L1
L0:
	li $s3, 0
	move $s4, $s3
L1:
	nop
	li $s3, 0
	move $v0, $s3
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
	.globl QS_Print
QS_Print:
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
L40:
	lw $s3, 8($s0)
	li $s4, 1
	sub $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	sle $v1, $s1, $s3
	move $t9, $v1
	move $s3, $t9
	beqz $s3 L41
	lw $s3, 4($s0)
	move $s4, $s1
	lw $s5, 0($s3)
	sle $v1, $s4, $s5
	move $t9, $v1
	move $s5, $t9
	beqz $s5 L42
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
	b L43
L42:
L43:
	nop
	move $s3, $s2
	move $a0, $s3
	jal _print
	li $s3, 1
	add $v1, $s1, $s3
	move $t9, $v1
	move $s1, $t9
	b L40
L41:
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
	.globl QS_Init
QS_Init:
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
L44:
	li $s5, 1
	sub $v1, $s2, $s5
	move $t9, $v1
	move $s5, $t9
	sle $v1, $s4, $s5
	move $t9, $v1
	move $s5, $t9
	beqz $s5 L45
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
	b L44
L45:
	nop
	move $s2, $s3
	sw $s2, 4($s0)
	lw $s2, 4($s0)
	li $s3, 0
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L46
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
	b L47
L46:
L47:
	nop
	lw $s2, 4($s0)
	li $s3, 1
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L48
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
	b L49
L48:
L49:
	nop
	lw $s2, 4($s0)
	li $s3, 2
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L50
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
	b L51
L50:
L51:
	nop
	lw $s2, 4($s0)
	li $s3, 3
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L52
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
	b L53
L52:
L53:
	nop
	lw $s2, 4($s0)
	li $s3, 4
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L54
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
	b L55
L54:
L55:
	nop
	lw $s2, 4($s0)
	li $s3, 5
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L56
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
	b L57
L56:
L57:
	nop
	lw $s2, 4($s0)
	li $s3, 6
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L58
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
	b L59
L58:
L59:
	nop
	lw $s2, 4($s0)
	li $s3, 7
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L60
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
	b L61
L60:
L61:
	nop
	lw $s2, 4($s0)
	li $s3, 8
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L62
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
	b L63
L62:
L63:
	nop
	lw $s2, 4($s0)
	li $s3, 9
	lw $s4, 0($s2)
	sle $v1, $s3, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L64
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
	b L65
L64:
L65:
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
