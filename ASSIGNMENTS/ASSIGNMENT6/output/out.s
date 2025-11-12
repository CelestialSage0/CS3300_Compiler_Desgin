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
	la $s2, TV_Start
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
	.globl TV_Start
TV_Start:
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
	li $s1, 84
	add $v1, $s1, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s1, $v0
	li $s2, 28
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	la $s3, Tree_Delete
	sw $s3, 0($s1)
	la $s3, Tree_SetHas_Left
	sw $s3, 4($s1)
	la $s3, Tree_RemoveLeft
	sw $s3, 8($s1)
	la $s3, Tree_GetKey
	sw $s3, 12($s1)
	la $s3, Tree_SetRight
	sw $s3, 16($s1)
	la $s3, Tree_GetLeft
	sw $s3, 20($s1)
	la $s3, Tree_GetRight
	sw $s3, 24($s1)
	la $s3, Tree_Remove
	sw $s3, 28($s1)
	la $s3, Tree_SetLeft
	sw $s3, 32($s1)
	la $s3, Tree_Insert
	sw $s3, 36($s1)
	la $s3, Tree_accept
	sw $s3, 40($s1)
	la $s3, Tree_Print
	sw $s3, 44($s1)
	la $s3, Tree_Init
	sw $s3, 48($s1)
	la $s3, Tree_GetHas_Right
	sw $s3, 52($s1)
	la $s3, Tree_GetHas_Left
	sw $s3, 56($s1)
	la $s3, Tree_RemoveRight
	sw $s3, 60($s1)
	la $s3, Tree_Search
	sw $s3, 64($s1)
	la $s3, Tree_SetKey
	sw $s3, 68($s1)
	la $s3, Tree_Compare
	sw $s3, 72($s1)
	la $s3, Tree_SetHas_Right
	sw $s3, 76($s1)
	la $s3, Tree_RecPrint
	sw $s3, 80($s1)
	li $s3, 0
	sw $s3, 4($s2)
	li $s3, 0
	sw $s3, 8($s2)
	li $s3, 0
	sw $s3, 12($s2)
	li $s3, 0
	sw $s3, 16($s2)
	li $s3, 0
	sw $s3, 20($s2)
	li $s3, 0
	sw $s3, 24($s2)
	sw $s1, 0($s2)
	move $s1, $s2
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 48($s3)
	move $s3, $t9
	li $s4, 16
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 44($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	li $s2, 100000000
	move $a0, $s2
	jal _print
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 36($s3)
	move $s3, $t9
	li $s4, 8
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 36($s3)
	move $s3, $t9
	li $s4, 24
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 36($s3)
	move $s3, $t9
	li $s4, 4
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 36($s3)
	move $s3, $t9
	li $s4, 12
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 36($s3)
	move $s3, $t9
	li $s4, 20
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 36($s3)
	move $s3, $t9
	li $s4, 28
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 36($s3)
	move $s3, $t9
	li $s4, 14
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 44($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	li $s2, 100000000
	move $a0, $s2
	jal _print
	li $s2, 4
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	li $s3, 12
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	la $s4, MyVisitor_visit
	sw $s4, 0($s2)
	li $s4, 0
	sw $s4, 4($s3)
	li $s4, 0
	sw $s4, 8($s3)
	sw $s2, 0($s3)
	move $s2, $s3
	li $s3, 50000000
	move $a0, $s3
	jal _print
	move $s3, $s1
	lw $s4, 0($s3)
	lw $t9, 40($s4)
	move $s4, $t9
	move $a0, $s3
	move $a1, $s2
	jalr $s4
	move $s2, $v0
	li $s2, 100000000
	move $a0, $s2
	jal _print
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 64($s3)
	move $s3, $t9
	li $s4, 24
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $a0, $s2
	jal _print
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 64($s3)
	move $s3, $t9
	li $s4, 12
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $a0, $s2
	jal _print
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 64($s3)
	move $s3, $t9
	li $s4, 16
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $a0, $s2
	jal _print
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 64($s3)
	move $s3, $t9
	li $s4, 50
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $a0, $s2
	jal _print
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 64($s3)
	move $s3, $t9
	li $s4, 12
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $a0, $s2
	jal _print
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 0($s3)
	move $s3, $t9
	li $s4, 12
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 44($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	lw $s2, 0($s1)
	lw $t9, 64($s2)
	move $s2, $t9
	li $s3, 12
	move $a0, $s1
	move $a1, $s3
	jalr $s2
	move $s1, $v0
	move $a0, $s1
	jal _print
	li $s1, 0
	move $v0, $s1
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
	.globl Tree_Init
Tree_Init:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	sw $s1, 24($s0)
	li $s2, 0
	sw $s2, 20($s0)
	li $s2, 0
	sw $s2, 8($s0)
	li $s2, 1
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Tree_SetRight
Tree_SetRight:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	sw $s1, 16($s0)
	li $s2, 1
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Tree_SetLeft
Tree_SetLeft:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	sw $s1, 4($s0)
	li $s2, 1
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Tree_GetRight
Tree_GetRight:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	move $s0, $a0
	lw $s1, 16($s0)
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addu $sp, $sp, 16
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Tree_GetLeft
Tree_GetLeft:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	move $s0, $a0
	lw $s1, 4($s0)
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addu $sp, $sp, 16
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Tree_GetKey
Tree_GetKey:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	move $s0, $a0
	lw $s1, 24($s0)
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addu $sp, $sp, 16
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Tree_SetKey
Tree_SetKey:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	sw $s1, 24($s0)
	li $s2, 1
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Tree_GetHas_Right
Tree_GetHas_Right:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	move $s0, $a0
	lw $s1, 8($s0)
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addu $sp, $sp, 16
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Tree_GetHas_Left
Tree_GetHas_Left:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	move $s0, $a0
	lw $s1, 20($s0)
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addu $sp, $sp, 16
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Tree_SetHas_Left
Tree_SetHas_Left:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	sw $s1, 20($s0)
	li $s2, 1
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Tree_SetHas_Right
Tree_SetHas_Right:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	sw $s1, 8($s0)
	li $s2, 1
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Tree_Compare
Tree_Compare:
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
	sle $v1, $s1, $s2
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L2
	sne $v1, $s1, $s2
	move $t9, $v1
	move $s4, $t9
	b L3
L2:
	li $s4, 0
L3:
	nop
	beqz $s4 L0
	li $s3, 0
	b L1
L0:
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
	beqz $s3 L4
	li $s3, 0
	b L5
L4:
	li $s3, 1
L5:
	nop
L1:
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
	.globl Tree_Insert
Tree_Insert:
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
	li $s2, 84
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	li $s3, 28
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	la $s4, Tree_Delete
	sw $s4, 0($s2)
	la $s4, Tree_SetHas_Left
	sw $s4, 4($s2)
	la $s4, Tree_RemoveLeft
	sw $s4, 8($s2)
	la $s4, Tree_GetKey
	sw $s4, 12($s2)
	la $s4, Tree_SetRight
	sw $s4, 16($s2)
	la $s4, Tree_GetLeft
	sw $s4, 20($s2)
	la $s4, Tree_GetRight
	sw $s4, 24($s2)
	la $s4, Tree_Remove
	sw $s4, 28($s2)
	la $s4, Tree_SetLeft
	sw $s4, 32($s2)
	la $s4, Tree_Insert
	sw $s4, 36($s2)
	la $s4, Tree_accept
	sw $s4, 40($s2)
	la $s4, Tree_Print
	sw $s4, 44($s2)
	la $s4, Tree_Init
	sw $s4, 48($s2)
	la $s4, Tree_GetHas_Right
	sw $s4, 52($s2)
	la $s4, Tree_GetHas_Left
	sw $s4, 56($s2)
	la $s4, Tree_RemoveRight
	sw $s4, 60($s2)
	la $s4, Tree_Search
	sw $s4, 64($s2)
	la $s4, Tree_SetKey
	sw $s4, 68($s2)
	la $s4, Tree_Compare
	sw $s4, 72($s2)
	la $s4, Tree_SetHas_Right
	sw $s4, 76($s2)
	la $s4, Tree_RecPrint
	sw $s4, 80($s2)
	li $s4, 0
	sw $s4, 4($s3)
	li $s4, 0
	sw $s4, 8($s3)
	li $s4, 0
	sw $s4, 12($s3)
	li $s4, 0
	sw $s4, 16($s3)
	li $s4, 0
	sw $s4, 20($s3)
	li $s4, 0
	sw $s4, 24($s3)
	sw $s2, 0($s3)
	move $s2, $s3
	move $s3, $s2
	lw $s4, 0($s3)
	lw $t9, 48($s4)
	move $s4, $t9
	move $a0, $s3
	move $a1, $s1
	jalr $s4
	move $s3, $v0
	move $s5, $s3
	move $s4, $s0
	li $s3, 1
L6:
	beqz $s3 L7
	move $s5, $s4
	lw $s6, 0($s5)
	lw $t9, 12($s6)
	move $s6, $t9
	move $a0, $s5
	jalr $s6
	move $s5, $v0
	li $s6, 1
	sub $v1, $s5, $s6
	move $t9, $v1
	move $s5, $t9
	sle $v1, $s1, $s5
	move $t9, $v1
	move $s5, $t9
	beqz $s5 L8
	move $s5, $s4
	lw $s6, 0($s5)
	lw $t9, 56($s6)
	move $s6, $t9
	move $a0, $s5
	jalr $s6
	move $s5, $v0
	beqz $s5 L10
	lw $s5, 0($s4)
	lw $t9, 20($s5)
	move $s5, $t9
	move $a0, $s4
	jalr $s5
	move $s4, $v0
	b L11
L10:
	li $s3, 0
	move $s5, $s4
	lw $s6, 0($s5)
	lw $t9, 4($s6)
	move $s6, $t9
	li $s7, 1
	move $a0, $s5
	move $a1, $s7
	jalr $s6
	move $s5, $v0
	move $s5, $s4
	lw $s6, 0($s5)
	lw $t9, 32($s6)
	move $s6, $t9
	move $a0, $s5
	move $a1, $s2
	jalr $s6
	move $s5, $v0
L11:
	nop
	b L9
L8:
	move $s5, $s4
	lw $s6, 0($s5)
	lw $t9, 52($s6)
	move $s6, $t9
	move $a0, $s5
	jalr $s6
	move $s5, $v0
	beqz $s5 L12
	lw $s5, 0($s4)
	lw $t9, 24($s5)
	move $s5, $t9
	move $a0, $s4
	jalr $s5
	move $s4, $v0
	b L13
L12:
	li $s3, 0
	move $s5, $s4
	lw $s6, 0($s5)
	lw $t9, 76($s6)
	move $s6, $t9
	li $s7, 1
	move $a0, $s5
	move $a1, $s7
	jalr $s6
	move $s5, $v0
	move $s5, $s4
	lw $s6, 0($s5)
	lw $t9, 16($s6)
	move $s6, $t9
	move $a0, $s5
	move $a1, $s2
	jalr $s6
	move $s5, $v0
L13:
	nop
L9:
	nop
	b L6
L7:
	nop
	li $s2, 1
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
	.globl Tree_Delete
Tree_Delete:
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
	move $s1, $a1
	move $s3, $s0
	move $s2, $s0
	li $s4, 1
	move $s5, $s4
	li $s4, 0
	li $s6, 1
L14:
	beqz $s5 L15
	move $s7, $s3
	lw $t0, 0($s7)
	lw $t9, 12($t0)
	move $t0, $t9
	move $v1, $t0
	sw $v1, 32($sp)
	move $a0, $s7
	lw $v1, 32($sp)
	jalr $v1
	move $s7, $v0
	li $t0, 1
	sub $v1, $s7, $t0
	move $t9, $v1
	move $t0, $t9
	sle $v1, $s1, $t0
	move $t9, $v1
	move $t0, $t9
	beqz $t0 L16
	move $s6, $s3
	lw $s7, 0($s6)
	lw $t9, 56($s7)
	move $s7, $t9
	move $a0, $s6
	jalr $s7
	move $s6, $v0
	beqz $s6 L18
	move $s2, $s3
	lw $s6, 0($s3)
	lw $t9, 20($s6)
	move $s6, $t9
	move $a0, $s3
	jalr $s6
	move $s3, $v0
	b L19
L18:
	li $s5, 0
L19:
	nop
	b L17
L16:
	sle $v1, $s7, $s1
	move $t9, $v1
	move $t0, $t9
	beqz $t0 L22
	sne $v1, $s7, $s1
	move $t9, $v1
	move $s7, $t9
	b L23
L22:
	li $s7, 0
L23:
	nop
	beqz $s7 L20
	move $s6, $s3
	lw $s7, 0($s6)
	lw $t9, 52($s7)
	move $s7, $t9
	move $a0, $s6
	jalr $s7
	move $s6, $v0
	beqz $s6 L24
	move $s2, $s3
	lw $s6, 0($s3)
	lw $t9, 24($s6)
	move $s6, $t9
	move $a0, $s3
	jalr $s6
	move $s3, $v0
	b L25
L24:
	li $s5, 0
L25:
	nop
	b L21
L20:
	beqz $s6 L26
	li $s4, 1
	move $s5, $s3
	lw $s6, 0($s5)
	lw $t9, 52($s6)
	move $s6, $t9
	move $a0, $s5
	jalr $s6
	move $s5, $v0
	sne $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L30
	li $s4, 1
	move $s5, $s3
	lw $s6, 0($s5)
	lw $t9, 56($s6)
	move $s6, $t9
	move $a0, $s5
	jalr $s6
	move $s5, $v0
	sne $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	b L31
L30:
	li $s4, 0
L31:
	nop
	beqz $s4 L28
	li $s4, 1
	b L29
L28:
	move $s4, $s0
	lw $s5, 0($s4)
	lw $t9, 28($s5)
	move $s5, $t9
	move $a0, $s4
	move $a1, $s2
	move $a2, $s3
	jalr $s5
	move $s4, $v0
L29:
	nop
	b L27
L26:
	move $s4, $s0
	lw $s5, 0($s4)
	lw $t9, 28($s5)
	move $s5, $t9
	move $a0, $s4
	move $a1, $s2
	move $a2, $s3
	jalr $s5
	move $s4, $v0
L27:
	nop
	li $s4, 1
	li $s5, 0
L21:
	nop
L17:
	nop
	li $s6, 0
	b L14
L15:
	nop
	move $s2, $s4
	move $v0, $s2
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
	.globl Tree_Remove
Tree_Remove:
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
	move $s2, $a2
	move $s3, $s2
	lw $s4, 0($s3)
	lw $t9, 56($s4)
	move $s4, $t9
	move $a0, $s3
	jalr $s4
	move $s3, $v0
	beqz $s3 L32
	move $s3, $s0
	lw $s4, 0($s3)
	lw $t9, 8($s4)
	move $s4, $t9
	move $a0, $s3
	move $a1, $s1
	move $a2, $s2
	jalr $s4
	move $s3, $v0
	b L33
L32:
	move $s3, $s2
	lw $s4, 0($s3)
	lw $t9, 52($s4)
	move $s4, $t9
	move $a0, $s3
	jalr $s4
	move $s3, $v0
	beqz $s3 L34
	move $s3, $s0
	lw $s4, 0($s3)
	lw $t9, 60($s4)
	move $s4, $t9
	move $a0, $s3
	move $a1, $s1
	move $a2, $s2
	jalr $s4
	move $s3, $v0
	b L35
L34:
	move $s3, $s2
	lw $s4, 0($s3)
	lw $t9, 12($s4)
	move $s4, $t9
	move $a0, $s3
	jalr $s4
	move $s3, $v0
	move $s4, $s1
	lw $s5, 0($s4)
	lw $t9, 20($s5)
	move $s5, $t9
	move $a0, $s4
	jalr $s5
	move $s4, $v0
	lw $s5, 0($s4)
	lw $t9, 12($s5)
	move $s5, $t9
	move $a0, $s4
	jalr $s5
	move $s4, $v0
	move $s5, $s0
	lw $s6, 0($s5)
	lw $t9, 72($s6)
	move $s6, $t9
	move $a0, $s5
	move $a1, $s3
	move $a2, $s4
	jalr $s6
	move $s3, $v0
	beqz $s3 L36
	move $s3, $s1
	lw $s4, 0($s3)
	lw $t9, 32($s4)
	move $s4, $t9
	lw $s5, 12($s0)
	move $a0, $s3
	move $a1, $s5
	jalr $s4
	move $s3, $v0
	move $s3, $s1
	lw $s4, 0($s3)
	lw $t9, 4($s4)
	move $s4, $t9
	li $s5, 0
	move $a0, $s3
	move $a1, $s5
	jalr $s4
	move $s3, $v0
	b L37
L36:
	move $s3, $s1
	lw $s4, 0($s3)
	lw $t9, 16($s4)
	move $s4, $t9
	lw $s5, 12($s0)
	move $a0, $s3
	move $a1, $s5
	jalr $s4
	move $s3, $v0
	move $s3, $s1
	lw $s4, 0($s3)
	lw $t9, 76($s4)
	move $s4, $t9
	li $s5, 0
	move $a0, $s3
	move $a1, $s5
	jalr $s4
	move $s3, $v0
L37:
	nop
L35:
	nop
L33:
	nop
	li $s3, 1
	move $v0, $s3
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
	.globl Tree_RemoveRight
Tree_RemoveRight:
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
	move $s2, $a2
L38:
	move $s3, $s2
	lw $s4, 0($s3)
	lw $t9, 52($s4)
	move $s4, $t9
	move $a0, $s3
	jalr $s4
	move $s3, $v0
	beqz $s3 L39
	move $s3, $s2
	lw $s4, 0($s3)
	lw $t9, 68($s4)
	move $s4, $t9
	move $s5, $s2
	lw $s6, 0($s5)
	lw $t9, 24($s6)
	move $s6, $t9
	move $a0, $s5
	jalr $s6
	move $s5, $v0
	lw $s6, 0($s5)
	lw $t9, 12($s6)
	move $s6, $t9
	move $a0, $s5
	jalr $s6
	move $s5, $v0
	move $a0, $s3
	move $a1, $s5
	jalr $s4
	move $s3, $v0
	move $s1, $s2
	move $s3, $s2
	lw $s4, 0($s3)
	lw $t9, 24($s4)
	move $s4, $t9
	move $a0, $s3
	jalr $s4
	move $s3, $v0
	move $s2, $s3
	b L38
L39:
	nop
	move $s3, $s1
	lw $s4, 0($s3)
	lw $t9, 16($s4)
	move $s4, $t9
	lw $s5, 12($s0)
	move $a0, $s3
	move $a1, $s5
	jalr $s4
	move $s3, $v0
	move $s3, $s1
	lw $s4, 0($s3)
	lw $t9, 76($s4)
	move $s4, $t9
	li $s5, 0
	move $a0, $s3
	move $a1, $s5
	jalr $s4
	move $s3, $v0
	li $s3, 1
	move $v0, $s3
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
	.globl Tree_RemoveLeft
Tree_RemoveLeft:
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
	move $s2, $a2
L40:
	move $s3, $s2
	lw $s4, 0($s3)
	lw $t9, 56($s4)
	move $s4, $t9
	move $a0, $s3
	jalr $s4
	move $s3, $v0
	beqz $s3 L41
	move $s3, $s2
	lw $s4, 0($s3)
	lw $t9, 68($s4)
	move $s4, $t9
	move $s5, $s2
	lw $s6, 0($s5)
	lw $t9, 20($s6)
	move $s6, $t9
	move $a0, $s5
	jalr $s6
	move $s5, $v0
	lw $s6, 0($s5)
	lw $t9, 12($s6)
	move $s6, $t9
	move $a0, $s5
	jalr $s6
	move $s5, $v0
	move $a0, $s3
	move $a1, $s5
	jalr $s4
	move $s3, $v0
	move $s1, $s2
	move $s3, $s2
	lw $s4, 0($s3)
	lw $t9, 20($s4)
	move $s4, $t9
	move $a0, $s3
	jalr $s4
	move $s3, $v0
	move $s2, $s3
	b L40
L41:
	nop
	move $s3, $s1
	lw $s4, 0($s3)
	lw $t9, 32($s4)
	move $s4, $t9
	lw $s5, 12($s0)
	move $a0, $s3
	move $a1, $s5
	jalr $s4
	move $s3, $v0
	move $s3, $s1
	lw $s4, 0($s3)
	lw $t9, 4($s4)
	move $s4, $t9
	li $s5, 0
	move $a0, $s3
	move $a1, $s5
	jalr $s4
	move $s3, $v0
	li $s3, 1
	move $v0, $s3
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
	.globl Tree_Search
Tree_Search:
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
	move $s4, $s0
	li $s2, 1
	move $s3, $s2
	li $s2, 0
L42:
	beqz $s3 L43
	move $s5, $s4
	lw $s6, 0($s5)
	lw $t9, 12($s6)
	move $s6, $t9
	move $a0, $s5
	jalr $s6
	move $s5, $v0
	li $s6, 1
	sub $v1, $s5, $s6
	move $t9, $v1
	move $s6, $t9
	sle $v1, $s1, $s6
	move $t9, $v1
	move $s6, $t9
	beqz $s6 L44
	move $s5, $s4
	lw $s6, 0($s5)
	lw $t9, 56($s6)
	move $s6, $t9
	move $a0, $s5
	jalr $s6
	move $s5, $v0
	beqz $s5 L46
	lw $s5, 0($s4)
	lw $t9, 20($s5)
	move $s5, $t9
	move $a0, $s4
	jalr $s5
	move $s4, $v0
	b L47
L46:
	li $s3, 0
L47:
	nop
	b L45
L44:
	li $s6, 1
	sub $v1, $s1, $s6
	move $t9, $v1
	move $s6, $t9
	sle $v1, $s5, $s6
	move $t9, $v1
	move $s5, $t9
	beqz $s5 L48
	move $s5, $s4
	lw $s6, 0($s5)
	lw $t9, 52($s6)
	move $s6, $t9
	move $a0, $s5
	jalr $s6
	move $s5, $v0
	beqz $s5 L50
	lw $s5, 0($s4)
	lw $t9, 24($s5)
	move $s5, $t9
	move $a0, $s4
	jalr $s5
	move $s4, $v0
	b L51
L50:
	li $s3, 0
L51:
	nop
	b L49
L48:
	li $s2, 1
	li $s3, 0
L49:
	nop
L45:
	nop
	b L42
L43:
	nop
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
	.globl Tree_Print
Tree_Print:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	move $s0, $a0
	move $s1, $s0
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 80($s3)
	move $s3, $t9
	move $a0, $s2
	move $a1, $s1
	jalr $s3
	move $s1, $v0
	li $s1, 1
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	addu $sp, $sp, 24
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Tree_RecPrint
Tree_RecPrint:
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
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 56($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	beqz $s2 L52
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 80($s3)
	move $s3, $t9
	move $s4, $s1
	lw $s5, 0($s4)
	lw $t9, 20($s5)
	move $s5, $t9
	move $a0, $s4
	jalr $s5
	move $s4, $v0
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	b L53
L52:
	li $s2, 1
L53:
	nop
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 12($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	move $a0, $s2
	jal _print
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 52($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	beqz $s2 L54
	move $s2, $s0
	lw $s3, 0($s2)
	lw $t9, 80($s3)
	move $s3, $t9
	move $s4, $s1
	lw $s5, 0($s4)
	lw $t9, 24($s5)
	move $s5, $t9
	move $a0, $s4
	jalr $s5
	move $s4, $v0
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	move $s2, $v0
	b L55
L54:
	li $s2, 1
L55:
	nop
	li $s2, 1
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
	.globl Tree_accept
Tree_accept:
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
	li $s2, 333
	move $a0, $s2
	jal _print
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 0($s3)
	move $s3, $t9
	move $a0, $s2
	move $a1, $s0
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
	.globl Visitor_visit
Visitor_visit:
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
	lw $t9, 52($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	beqz $s2 L56
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 24($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	sw $s2, 4($s0)
	lw $s2, 4($s0)
	lw $s3, 0($s2)
	lw $t9, 40($s3)
	move $s3, $t9
	move $a0, $s2
	move $a1, $s0
	jalr $s3
	move $s2, $v0
	b L57
L56:
	li $s2, 0
L57:
	nop
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 56($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	beqz $s2 L58
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 20($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	sw $s2, 8($s0)
	lw $s2, 8($s0)
	lw $s3, 0($s2)
	lw $t9, 40($s3)
	move $s3, $t9
	move $a0, $s2
	move $a1, $s0
	jalr $s3
	move $s2, $v0
	b L59
L58:
	li $s2, 0
L59:
	nop
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
	.globl MyVisitor_visit
MyVisitor_visit:
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
	lw $t9, 52($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	beqz $s2 L60
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 24($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	sw $s2, 4($s0)
	lw $s2, 4($s0)
	lw $s3, 0($s2)
	lw $t9, 40($s3)
	move $s3, $t9
	move $a0, $s2
	move $a1, $s0
	jalr $s3
	move $s2, $v0
	b L61
L60:
	li $s2, 0
L61:
	nop
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 12($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	move $a0, $s2
	jal _print
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 56($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	beqz $s2 L62
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 20($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	sw $s2, 8($s0)
	lw $s2, 8($s0)
	lw $s3, 0($s2)
	lw $t9, 40($s3)
	move $s3, $t9
	move $a0, $s2
	move $a1, $s0
	jalr $s3
	move $s2, $v0
	b L63
L62:
	li $s2, 0
L63:
	nop
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
