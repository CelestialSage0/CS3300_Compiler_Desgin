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
	la $s2, Caller_call
	sw $s2, 0($s0)
	sw $s0, 0($s1)
	move $s0, $s1
	lw $s1, 0($s0)
	lw $t9, 0($s1)
	move $s1, $t9
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
	la $s4, SuperType_value
	sw $s4, 0($s2)
	sw $s2, 0($s3)
	move $s2, $s3
	move $a0, $s0
	move $a1, $s2
	jalr $s1
	move $s0, $v0
	li $s1, 4
	add $v1, $s1, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s1, $v0
	li $s2, 4
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	la $s3, Caller_call
	sw $s3, 0($s1)
	sw $s1, 0($s2)
	move $s1, $s2
	lw $s2, 0($s1)
	lw $t9, 0($s2)
	move $s2, $t9
	li $s3, 4
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	li $s4, 4
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, SubType_value
	sw $s5, 0($s3)
	sw $s3, 0($s4)
	move $s3, $s4
	move $a0, $s1
	move $a1, $s3
	jalr $s2
	move $s1, $v0
	add $v1, $s0, $s1
	move $t9, $v1
	move $s0, $t9
	move $a0, $s0
	jal _print
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	j $ra

	.text
	.globl SuperType_value
SuperType_value:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	move $s0, $a0
	li $s1, 10
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addu $sp, $sp, 16
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl SubType_value
SubType_value:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	move $s0, $a0
	li $s1, 20
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addu $sp, $sp, 16
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Caller_call
Caller_call:
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
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 0($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
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
