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
	li $s1, 8
	add $v1, $s1, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s1, $v0
	la $s2, Fac_ComputeFac
	sw $s2, 0($s0)
	li $s2, 0
	sw $s2, 4($s1)
	sw $s0, 0($s1)
	move $s0, $s1
	lw $s1, 0($s0)
	lw $t9, 0($s1)
	move $s1, $t9
	li $s2, 10
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
	.globl Fac_ComputeFac
Fac_ComputeFac:
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
	sle $v1, $s1, $s2
	move $t9, $v1
	move $s2, $t9
	beqz $s2 L2
	li $s2, 1
	sne $v1, $s1, $s2
	move $t9, $v1
	move $s2, $t9
	b L3
L2:
	li $s2, 0
L3:
	nop
	beqz $s2 L0
	li $s2, 1
	li $s3, 0
	add $v1, $s2, $s3
	move $t9, $v1
	move $s2, $t9
	b L1
L0:
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 0($s3)
	move $s3, $t9
	li $s4, 1
	sub $v1, $s1, $s4
	move $t9, $v1
	move $s4, $t9
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	mul $v1, $s1, $s2
	move $t9, $v1
	move $s2, $t9
L1:
	nop
	lw $s3, 4($s0)
	mul $v1, $s2, $s3
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
	.globl OtherFac_Thing
OtherFac_Thing:
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
	li $s2, 20
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	li $s3, 8
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	la $s4, OtherFac_foodash
	sw $s4, 12($s2)
	la $s4, Fac_ComputeFac
	sw $s4, 0($s2)
	la $s4, OtherFac_Thing
	sw $s4, 16($s2)
	la $s4, OtherFac_foo
	sw $s4, 4($s2)
	la $s4, OtherFac_foooo
	sw $s4, 8($s2)
	li $s4, 0
	sw $s4, 4($s3)
	sw $s2, 0($s3)
	move $s2, $s3
	li $s2, 5
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
	.globl OtherFac_foo
OtherFac_foo:
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
	lw $t9, 16($s3)
	move $s3, $t9
	move $a0, $s2
	move $a1, $s1
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
	.globl OtherFac_foodash
OtherFac_foodash:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	move $s0, $a0
	move $s1, $s0
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addu $sp, $sp, 16
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl OtherFac_foooo
OtherFac_foooo:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	move $s0, $a0
	li $s1, 5
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addu $sp, $sp, 16
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
