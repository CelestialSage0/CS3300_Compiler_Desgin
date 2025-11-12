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
	la $s2, RunnerC_run
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
	.globl RunnerC_run
RunnerC_run:
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
	li $s2, 2
	li $s3, 1
	add $v1, $s2, $s3
	move $t9, $v1
	move $s3, $t9
	li $s7, 4
	mul $v1, $s3, $s7
	move $t9, $v1
	move $s3, $t9
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	sw $s2, 0($s3)
	li $s7, 1
L0:
	li $t1, 1
	sub $v1, $s2, $t1
	move $t9, $v1
	move $t1, $t9
	sle $v1, $s7, $t1
	move $t9, $v1
	move $t1, $t9
	beqz $t1 L1
	li $t1, 4
	mul $v1, $t1, $s7
	move $t9, $v1
	move $t1, $t9
	add $v1, $t1, $s3
	move $t9, $v1
	move $t1, $t9
	li $t2, 0
	sw $t2, 0($t1)
	li $t1, 1
	add $v1, $s7, $t1
	move $t9, $v1
	move $s7, $t9
	b L0
L1:
	nop
	move $s2, $s3
	move $s3, $s2
	li $s7, 0
	lw $t1, 0($s3)
	sle $v1, $s7, $t1
	move $t9, $v1
	move $t1, $t9
	beqz $t1 L2
	li $t1, 4
	li $t2, 1
	add $v1, $t2, $s7
	move $t9, $v1
	move $s7, $t9
	mul $v1, $t1, $s7
	move $t9, $v1
	move $s7, $t9
	add $v1, $s3, $s7
	move $t9, $v1
	move $s3, $t9
	li $s7, 3
	sw $s7, 0($s3)
	b L3
L2:
L3:
	nop
	move $s3, $s2
	li $s7, 1
	lw $t1, 0($s3)
	sle $v1, $s7, $t1
	move $t9, $v1
	move $t1, $t9
	beqz $t1 L4
	li $t1, 4
	li $t2, 1
	add $v1, $t2, $s7
	move $t9, $v1
	move $s7, $t9
	mul $v1, $t1, $s7
	move $t9, $v1
	move $s7, $t9
	add $v1, $s3, $s7
	move $t9, $v1
	move $s3, $t9
	li $s7, 7
	sw $s7, 0($s3)
	b L5
L4:
L5:
	nop
	lw $s3, 0($s2)
	li $s7, 1
	sub $v1, $s3, $s7
	move $t9, $v1
	move $s3, $t9
	li $s7, 12
	add $v1, $s7, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s7, $v0
	li $t1, 4
	add $v1, $t1, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t1, $v0
	la $t2, GMid_extraMid
	sw $t2, 8($s7)
	la $t2, GBottom_getMul
	sw $t2, 4($s7)
	la $t2, GMid_getAdd
	sw $t2, 0($s7)
	sw $s7, 0($t1)
	move $s7, $t1
	li $t1, 12
	add $v1, $t1, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t1, $v0
	la $t2, _LAMBDA_0
	sw $t2, 0($t1)
	sw $s0, 4($t1)
	move $t2, $s7
	sw $t2, 8($t1)
	move $t2, $s2
	li $t3, 1
	lw $t4, 0($t2)
	sle $v1, $t3, $t4
	move $t9, $v1
	move $t4, $t9
	beqz $t4 L6
	li $t4, 4
	li $t5, 1
	add $v1, $t5, $t3
	move $t9, $v1
	move $t3, $t9
	mul $v1, $t4, $t3
	move $t9, $v1
	move $t3, $t9
	add $v1, $t2, $t3
	move $t9, $v1
	move $t2, $t9
	move $v1, $t2
	sw $v1, 32($sp)
	move $v1, $t1
	sw $v1, 56($sp)
	lw $v1, 56($sp)
	lw $t1, 0($v1)
	move $v1, $t1
	sw $v1, 48($sp)
	move $t1, $s2
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
	sw $v1, 44($sp)
	lw $v1, 56($sp)
	move $a0, $v1
	lw $v1, 44($sp)
	move $a1, $v1
	lw $v1, 48($sp)
	jalr $v1
	move $v1, $v0
	sw $v1, 36($sp)
	lw $v1, 32($sp)
	move $v0, $v1
	lw $v1, 36($sp)
	sw $v1, 0($v0)
	b L7
L6:
L7:
	nop
	move $t0, $s2
	li $t1, 0
	lw $t2, 0($t0)
	sle $v1, $t1, $t2
	move $t9, $v1
	move $t2, $t9
	beqz $t2 L14
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
	lw $v1, 0($t0)
	sw $v1, 40($sp)
	b L15
L14:
L15:
	nop
	lw $v1, 40($sp)
	move $t0, $v1
	move $t1, $s2
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
	sle $v1, $t0, $s6
	move $t9, $v1
	move $s6, $t9
	beqz $s6 L12
	li $s6, 1
	move $t0, $s2
	li $t1, 0
	lw $t2, 0($t0)
	sle $v1, $t1, $t2
	move $t9, $v1
	move $t2, $t9
	beqz $t2 L18
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
	b L19
L18:
L19:
	nop
	li $t0, 3
	sne $v1, $s5, $t0
	move $t9, $v1
	move $s5, $t9
	sne $v1, $s6, $s5
	move $t9, $v1
	move $s5, $t9
	b L13
L12:
	li $s5, 0
L13:
	nop
	beqz $s5 L10
	move $s5, $s2
	li $s6, 0
	lw $t0, 0($s5)
	sle $v1, $s6, $t0
	move $t9, $v1
	move $t0, $t9
	beqz $t0 L20
	li $t0, 4
	li $t1, 1
	add $v1, $t1, $s6
	move $t9, $v1
	move $s6, $t9
	mul $v1, $t0, $s6
	move $t9, $v1
	move $s6, $t9
	add $v1, $s5, $s6
	move $t9, $v1
	move $s5, $t9
	move $s6, $s2
	li $t0, 0
	lw $t1, 0($s6)
	sle $v1, $t0, $t1
	move $t9, $v1
	move $t1, $t9
	beqz $t1 L22
	li $s4, 4
	li $t1, 1
	add $v1, $t1, $t0
	move $t9, $v1
	move $t0, $t9
	mul $v1, $s4, $t0
	move $t9, $v1
	move $s4, $t9
	add $v1, $s6, $s4
	move $t9, $v1
	move $s4, $t9
	lw $t9, 0($s4)
	move $s4, $t9
	b L23
L22:
L23:
	nop
	move $s6, $s7
	lw $s7, 0($s6)
	lw $t9, 0($s7)
	move $s7, $t9
	li $v1, 4
	sw $v1, 52($sp)
	move $a0, $s6
	lw $v1, 52($sp)
	move $a1, $v1
	jalr $s7
	move $s6, $v0
	add $v1, $s4, $s6
	move $t9, $v1
	move $s4, $t9
	sw $s4, 0($s5)
	b L21
L20:
L21:
	nop
	b L11
L10:
	move $s5, $s2
	li $s6, 0
	lw $s7, 0($s5)
	sle $v1, $s6, $s7
	move $t9, $v1
	move $s7, $t9
	beqz $s7 L24
	li $s7, 4
	li $t0, 1
	add $v1, $t0, $s6
	move $t9, $v1
	move $s6, $t9
	mul $v1, $s7, $s6
	move $t9, $v1
	move $s6, $t9
	add $v1, $s5, $s6
	move $t9, $v1
	move $s5, $t9
	move $s6, $s2
	li $s7, 0
	lw $t0, 0($s6)
	sle $v1, $s7, $t0
	move $t9, $v1
	move $t0, $t9
	beqz $t0 L26
	li $s4, 4
	li $t0, 1
	add $v1, $t0, $s7
	move $t9, $v1
	move $s7, $t9
	mul $v1, $s4, $s7
	move $t9, $v1
	move $s4, $t9
	add $v1, $s6, $s4
	move $t9, $v1
	move $s4, $t9
	lw $t9, 0($s4)
	move $s4, $t9
	b L27
L26:
L27:
	nop
	li $s6, 1
	sub $v1, $s4, $s6
	move $t9, $v1
	move $s4, $t9
	sw $s4, 0($s5)
	b L25
L24:
L25:
	nop
L11:
	nop
	li $s4, 12
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	li $s5, 4
	add $v1, $s5, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s5, $v0
	la $s6, GMid_extraMid
	sw $s6, 8($s4)
	la $s6, GBottom_getMul
	sw $s6, 4($s4)
	la $s6, GMid_getAdd
	sw $s6, 0($s4)
	sw $s4, 0($s5)
	move $s4, $s5
	move $s5, $s4
	li $s4, 12
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	li $s6, 4
	add $v1, $s6, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s6, $v0
	la $s7, GMid_extraMid
	sw $s7, 8($s4)
	la $s7, GBottom_getMul
	sw $s7, 4($s4)
	la $s7, GMid_getAdd
	sw $s7, 0($s4)
	sw $s4, 0($s6)
	move $s4, $s6
	lw $s6, 0($s5)
	lw $t9, 0($s6)
	move $s6, $t9
	li $s7, 1
	move $a0, $s5
	move $a1, $s7
	jalr $s6
	move $s5, $v0
	lw $s6, 0($s4)
	lw $t9, 4($s6)
	move $s6, $t9
	li $s7, 1
	move $a0, $s4
	move $a1, $s7
	jalr $s6
	move $s4, $v0
	add $v1, $s5, $s4
	move $t9, $v1
	move $s4, $t9
	lw $s5, 0($s2)
	sle $v1, $s3, $s5
	move $t9, $v1
	move $s5, $t9
	beqz $s5 L28
	li $s1, 4
	li $s5, 1
	add $v1, $s5, $s3
	move $t9, $v1
	move $s3, $t9
	mul $v1, $s1, $s3
	move $t9, $v1
	move $s1, $t9
	add $v1, $s2, $s1
	move $t9, $v1
	move $s1, $t9
	lw $t9, 0($s1)
	move $s1, $t9
	b L29
L28:
L29:
	nop
	add $v1, $s4, $s1
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
	.globl GBase_getAdd
GBase_getAdd:
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
	.globl GBase_getMul
GBase_getMul:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	li $s2, 0
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
	.globl GMid_getAdd
GMid_getAdd:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	li $s2, 5
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
	.globl GMid_extraMid
GMid_extraMid:
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
	.globl GBottom_getMul
GBottom_getMul:
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
	.globl _LAMBDA_0
_LAMBDA_0:
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
	lw $s2, 8($s0)
	lw $s3, 0($s2)
	lw $t9, 4($s3)
	move $s3, $t9
	li $s4, 2
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	mul $v1, $s1, $s2
	move $t9, $v1
	move $s2, $t9
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
