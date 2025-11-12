	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $s0, 1
	li $s1, 2
	add $v1, $s0, $s1
	move $t9, $v1
	move $s0, $t9
	li $s1, 3
	mul $v1, $s0, $s1
	move $t9, $v1
	move $s0, $t9
	move $a0, $s0
	jal _print
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	j $ra

	.text
	.globl Testcase_increment
Testcase_increment:
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
	move $s2, $a2
	add $v1, $s1, $s2
	move $t9, $v1
	move $s3, $t9
	move $s1, $s3
	move $s3, $s1
	move $v0, $s3
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	addu $sp, $sp, 24
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Testcase_test
Testcase_test:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 44
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	li $s1, 1
	move $s3, $s1
	move $s1, $s0
	lw $s2, 0($s1)
	lw $t9, 4($s2)
	move $s2, $t9
	move $s4, $s0
	lw $s5, 0($s4)
	lw $t9, 4($s5)
	move $s5, $t9
	move $s6, $s0
	lw $s7, 0($s6)
	lw $t9, 4($s7)
	move $s7, $t9
	li $v1, 1
	sw $v1, 32($sp)
	move $a0, $s6
	move $a1, $s3
	lw $v1, 32($sp)
	move $a2, $v1
	jalr $s7
	move $s3, $v0
	li $s6, 2
	move $a0, $s4
	move $a1, $s3
	move $a2, $s6
	jalr $s5
	move $s3, $v0
	li $s4, 3
	move $a0, $s1
	move $a1, $s3
	move $a2, $s4
	jalr $s2
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
	addu $sp, $sp, 44
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
