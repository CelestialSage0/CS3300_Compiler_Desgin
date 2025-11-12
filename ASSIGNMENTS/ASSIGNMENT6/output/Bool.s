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
	la $s2, Wrapper_call
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
	.globl Wrapper_call
Wrapper_call:
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
	li $s1, 1
	move $s2, $s1
	li $s1, 0
	li $s3, 1
	li $s4, 1
	li $s5, 3
	sle $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	sne $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	beqz $s3 L0
	li $s3, 0
	li $s4, 1
	sub $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	move $a0, $s3
	jal _print
L0:
	nop
	li $s3, 1
	li $s4, 5
	li $s5, 5
	sle $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	sne $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	beqz $s3 L1
	li $s3, 0
	li $s4, 1
	sub $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	move $a0, $s3
	jal _print
L1:
	nop
	li $s3, 0
	li $s4, 6
	li $s5, 5
	sle $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	sne $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	beqz $s3 L2
	li $s3, 0
	li $s4, 1
	sub $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	move $a0, $s3
	jal _print
L2:
	nop
	li $s3, 0
	li $s4, 0
	li $s5, 1
	sub $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	li $s5, 0
	li $s6, 2
	sub $v1, $s5, $s6
	move $t9, $v1
	move $s5, $t9
	sle $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	sne $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	beqz $s3 L3
	li $s3, 0
	li $s4, 1
	sub $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	move $a0, $s3
	jal _print
L3:
	nop
	beqz $s2 L4
	li $s3, 1
	move $a0, $s3
	jal _print
L4:
	nop
	beqz $s1 L5
	li $s3, 2
	move $a0, $s3
	jal _print
L5:
	nop
	beqz $s2 L7
	move $s3, $s2
	b L8
L7:
	li $s3, 0
L8:
	nop
	beqz $s3 L6
	li $s3, 3
	move $a0, $s3
	jal _print
L6:
	nop
	beqz $s2 L10
	move $s3, $s1
	b L11
L10:
	li $s3, 0
L11:
	nop
	beqz $s3 L9
	li $s3, 4
	move $a0, $s3
	jal _print
L9:
	nop
	beqz $s1 L13
	move $s3, $s2
	b L14
L13:
	li $s3, 0
L14:
	nop
	beqz $s3 L12
	li $s3, 5
	move $a0, $s3
	jal _print
L12:
	nop
	beqz $s1 L16
	move $s3, $s1
	b L17
L16:
	li $s3, 0
L17:
	nop
	beqz $s3 L15
	li $s3, 6
	move $a0, $s3
	jal _print
L15:
	nop
	beqz $s2 L19
	li $s3, 1
	b L20
L19:
	move $s3, $s2
L20:
	nop
	beqz $s3 L18
	li $s3, 7
	move $a0, $s3
	jal _print
L18:
	nop
	beqz $s2 L22
	li $s3, 1
	b L23
L22:
	move $s3, $s1
L23:
	nop
	beqz $s3 L21
	li $s3, 8
	move $a0, $s3
	jal _print
L21:
	nop
	beqz $s1 L25
	li $s3, 1
	b L26
L25:
	move $s3, $s2
L26:
	nop
	beqz $s3 L24
	li $s3, 9
	move $a0, $s3
	jal _print
L24:
	nop
	beqz $s1 L28
	li $s3, 1
	b L29
L28:
	move $s3, $s1
L29:
	nop
	beqz $s3 L27
	li $s3, 10
	move $a0, $s3
	jal _print
L27:
	nop
	li $s3, 1
	sne $v1, $s3, $s2
	move $t9, $v1
	move $s2, $t9
	beqz $s2 L30
	li $s2, 11
	move $a0, $s2
	jal _print
L30:
	nop
	li $s2, 1
	sne $v1, $s2, $s1
	move $t9, $v1
	move $s1, $t9
	beqz $s1 L31
	li $s1, 12
	move $a0, $s1
	jal _print
L31:
	nop
	li $s1, 13
	move $v0, $s1
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
