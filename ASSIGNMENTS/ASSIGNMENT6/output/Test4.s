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
	la $s2, T_start
	sw $s2, 0($s0)
	sw $s0, 0($s1)
	move $s0, $s1
	lw $s1, 0($s0)
	lw $t9, 0($s1)
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
	.globl T_start
T_start:
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
	li $s2, 1
	beqz $s2 L2
	li $s2, 1
	b L3
L2:
	li $s2, 4
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	li $s3, 4
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	la $s4, A_foo
	sw $s4, 0($s2)
	sw $s2, 0($s3)
	move $s2, $s3
	lw $s3, 0($s2)
	lw $t9, 0($s3)
	move $s3, $t9
	li $s4, 1
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
L3:
	nop
	beqz $s2 L0
	li $s2, 5
	move $a0, $s2
	jal _print
	b L1
L0:
	li $s2, 9
	move $a0, $s2
	jal _print
L1:
	nop
	li $s2, 0
	beqz $s2 L6
	li $s2, 4
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	li $s3, 4
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	la $s4, A_foo
	sw $s4, 0($s2)
	sw $s2, 0($s3)
	move $s2, $s3
	lw $s3, 0($s2)
	lw $t9, 0($s3)
	move $s3, $t9
	li $s4, 2
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	b L7
L6:
	li $s2, 0
L7:
	nop
	beqz $s2 L4
	li $s2, 6
	move $a0, $s2
	jal _print
	b L5
L4:
	li $s2, 10
	move $a0, $s2
	jal _print
L5:
	nop
	li $s2, 1
	beqz $s2 L10
	li $s2, 4
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	li $s3, 4
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	la $s4, A_foo
	sw $s4, 0($s2)
	sw $s2, 0($s3)
	move $s2, $s3
	lw $s3, 0($s2)
	lw $t9, 0($s3)
	move $s3, $t9
	li $s4, 3
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	b L11
L10:
	li $s2, 0
L11:
	nop
	beqz $s2 L8
	li $s2, 7
	move $a0, $s2
	jal _print
	b L9
L8:
	li $s2, 11
	move $a0, $s2
	jal _print
L9:
	nop
	li $s2, 0
	beqz $s2 L14
	li $s2, 1
	b L15
L14:
	li $s2, 4
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	li $s3, 4
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	la $s4, A_foo
	sw $s4, 0($s2)
	sw $s2, 0($s3)
	move $s2, $s3
	lw $s3, 0($s2)
	lw $t9, 0($s3)
	move $s3, $t9
	li $s4, 4
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
L15:
	nop
	beqz $s2 L12
	li $s2, 8
	move $a0, $s2
	jal _print
	b L13
L12:
	li $s2, 12
	move $a0, $s2
	jal _print
L13:
	nop
	li $s2, 2
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
	.globl A_foo
A_foo:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	move $a0, $s1
	jal _print
	li $s2, 0
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
