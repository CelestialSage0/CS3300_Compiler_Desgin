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
	la $s2, LL_Start
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
	.globl Element_Init
Element_Init:
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
	move $s2, $a2
	move $s3, $a3
	sw $s1, 12($s0)
	sw $s2, 4($s0)
	sw $s3, 8($s0)
	li $s4, 1
	move $v0, $s4
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
	.globl Element_GetAge
Element_GetAge:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	move $s0, $a0
	lw $s1, 12($s0)
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addu $sp, $sp, 16
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Element_GetSalary
Element_GetSalary:
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
	.globl Element_GetMarried
Element_GetMarried:
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
	.globl Element_Equal
Element_Equal:
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
	li $s2, 1
	move $s3, $s1
	lw $s4, 0($s3)
	lw $t9, 8($s4)
	move $s4, $t9
	move $a0, $s3
	jalr $s4
	move $s3, $v0
	move $s4, $s3
	li $s3, 1
	move $s5, $s0
	lw $s6, 0($s5)
	lw $t9, 20($s6)
	move $s6, $t9
	lw $s7, 12($s0)
	move $a0, $s5
	move $a1, $s4
	move $a2, $s7
	jalr $s6
	move $s4, $v0
	sne $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	beqz $s3 L0
	li $s2, 0
	b L1
L0:
	move $s3, $s1
	lw $s4, 0($s3)
	lw $t9, 0($s4)
	move $s4, $t9
	move $a0, $s3
	jalr $s4
	move $s3, $v0
	move $s4, $s3
	li $s3, 1
	move $s5, $s0
	lw $s6, 0($s5)
	lw $t9, 20($s6)
	move $s6, $t9
	lw $s7, 4($s0)
	move $a0, $s5
	move $a1, $s4
	move $a2, $s7
	jalr $s6
	move $s4, $v0
	sne $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	beqz $s3 L2
	li $s2, 0
	b L3
L2:
	lw $s3, 8($s0)
	beqz $s3 L4
	li $s3, 1
	move $s4, $s1
	lw $s5, 0($s4)
	lw $t9, 16($s5)
	move $s5, $t9
	move $a0, $s4
	jalr $s5
	move $s4, $v0
	sne $v1, $s3, $s4
	move $t9, $v1
	move $s3, $t9
	beqz $s3 L6
	li $s2, 0
	b L7
L6:
	li $s3, 0
L7:
	nop
	b L5
L4:
	move $s3, $s1
	lw $s4, 0($s3)
	lw $t9, 16($s4)
	move $s4, $t9
	move $a0, $s3
	jalr $s4
	move $s3, $v0
	beqz $s3 L8
	li $s2, 0
	b L9
L8:
	li $s3, 0
L9:
	nop
L5:
	nop
L3:
	nop
L1:
	nop
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
	.globl Element_Compare
Element_Compare:
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
	beqz $s4 L12
	sne $v1, $s1, $s2
	move $t9, $v1
	move $s4, $t9
	b L13
L12:
	li $s4, 0
L13:
	nop
	beqz $s4 L10
	li $s3, 0
	b L11
L10:
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
	beqz $s3 L14
	li $s3, 0
	b L15
L14:
	li $s3, 1
L15:
	nop
L11:
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
	.globl List_Init
List_Init:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	move $s0, $a0
	li $s1, 1
	sw $s1, 12($s0)
	li $s1, 1
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addu $sp, $sp, 16
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl List_InitNew
List_InitNew:
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
	move $s2, $a2
	move $s3, $a3
	sw $s3, 12($s0)
	sw $s1, 4($s0)
	sw $s2, 8($s0)
	li $s4, 1
	move $v0, $s4
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
	.globl List_Insert
List_Insert:
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
	move $s2, $s0
	li $s3, 40
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	li $s4, 16
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, List_Delete
	sw $s5, 0($s3)
	la $s5, List_Print
	sw $s5, 4($s3)
	la $s5, List_Init
	sw $s5, 8($s3)
	la $s5, List_GetElem
	sw $s5, 12($s3)
	la $s5, List_GetNext
	sw $s5, 16($s3)
	la $s5, List_SetNext
	sw $s5, 20($s3)
	la $s5, List_Search
	sw $s5, 24($s3)
	la $s5, List_GetEnd
	sw $s5, 28($s3)
	la $s5, List_InitNew
	sw $s5, 32($s3)
	la $s5, List_Insert
	sw $s5, 36($s3)
	li $s5, 0
	sw $s5, 4($s4)
	li $s5, 0
	sw $s5, 8($s4)
	li $s5, 0
	sw $s5, 12($s4)
	sw $s3, 0($s4)
	move $s3, $s4
	move $s4, $s3
	lw $s5, 0($s4)
	lw $t9, 32($s5)
	move $s5, $t9
	li $s6, 0
	move $a0, $s4
	move $a1, $s1
	move $a2, $s2
	move $a3, $s6
	jalr $s5
	move $s2, $v0
	move $s2, $s3
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
	.globl List_SetNext
List_SetNext:
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
	.globl List_Delete
List_Delete:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 88
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
	move $s4, $s0
	li $s2, 0
	li $s3, 0
	li $s5, 1
	sub $v1, $s3, $s5
	move $t9, $v1
	move $s3, $t9
	move $s7, $s3
	move $s5, $s0
	move $s3, $s0
	lw $s6, 12($s0)
	lw $t0, 4($s0)
	move $v1, $t0
	sw $v1, 48($sp)
L16:
	li $t0, 1
	sne $v1, $t0, $s6
	move $t9, $v1
	move $t0, $t9
	beqz $t0 L18
	li $t0, 1
	sne $v1, $t0, $s2
	move $t9, $v1
	move $t0, $t9
	b L19
L18:
	li $t0, 0
L19:
	nop
	beqz $t0 L17
	move $v1, $s1
	sw $v1, 56($sp)
	lw $v1, 56($sp)
	lw $t0, 0($v1)
	lw $t9, 12($t0)
	move $t0, $t9
	move $v1, $t0
	sw $v1, 72($sp)
	lw $v1, 56($sp)
	move $a0, $v1
	lw $v1, 48($sp)
	move $a1, $v1
	lw $v1, 72($sp)
	jalr $v1
	move $v1, $v0
	sw $v1, 64($sp)
	lw $v1, 64($sp)
	beqz $v1 L20
	li $s2, 1
	li $t0, 0
	sle $v1, $s7, $t0
	move $t9, $v1
	move $t0, $t9
	beqz $t0 L24
	li $t0, 0
	sne $v1, $s7, $t0
	move $t9, $v1
	move $t0, $t9
	b L25
L24:
	li $t0, 0
L25:
	nop
	beqz $t0 L22
	move $s4, $s5
	lw $t0, 0($s4)
	lw $t9, 16($t0)
	move $t0, $t9
	move $v1, $t0
	sw $v1, 44($sp)
	move $a0, $s4
	lw $v1, 44($sp)
	jalr $v1
	move $s4, $v0
	b L23
L22:
	li $t0, 0
	li $t1, 555
	sub $v1, $t0, $t1
	move $t9, $v1
	move $t0, $t9
	move $a0, $t0
	jal _print
	move $v1, $s3
	sw $v1, 52($sp)
	lw $v1, 52($sp)
	lw $t0, 0($v1)
	lw $t9, 20($t0)
	move $t0, $t9
	move $v1, $t0
	sw $v1, 68($sp)
	move $v1, $s5
	sw $v1, 76($sp)
	lw $v1, 76($sp)
	lw $t0, 0($v1)
	lw $t9, 16($t0)
	move $t0, $t9
	move $v1, $t0
	sw $v1, 40($sp)
	lw $v1, 76($sp)
	move $a0, $v1
	lw $v1, 40($sp)
	jalr $v1
	move $v1, $v0
	sw $v1, 32($sp)
	lw $v1, 52($sp)
	move $a0, $v1
	lw $v1, 32($sp)
	move $a1, $v1
	lw $v1, 68($sp)
	jalr $v1
	move $v1, $v0
	sw $v1, 60($sp)
	lw $v1, 60($sp)
	move $t0, $v1
	li $t0, 0
	li $t1, 555
	sub $v1, $t0, $t1
	move $t9, $v1
	move $t0, $t9
	move $a0, $t0
	jal _print
L23:
	nop
	b L21
L20:
	li $t0, 0
L21:
	nop
	li $t0, 1
	sne $v1, $t0, $s2
	move $t9, $v1
	move $t0, $t9
	beqz $t0 L26
	move $s3, $s5
	lw $s6, 0($s5)
	lw $t9, 16($s6)
	move $s6, $t9
	move $a0, $s5
	jalr $s6
	move $s5, $v0
	move $s6, $s5
	lw $s7, 0($s6)
	lw $t9, 28($s7)
	move $s7, $t9
	move $a0, $s6
	jalr $s7
	move $s6, $v0
	move $s7, $s5
	lw $t0, 0($s7)
	lw $t9, 12($t0)
	move $t0, $t9
	move $v1, $t0
	sw $v1, 36($sp)
	move $a0, $s7
	lw $v1, 36($sp)
	jalr $v1
	move $s7, $v0
	move $v1, $s7
	sw $v1, 48($sp)
	li $s7, 1
	b L27
L26:
	li $t0, 0
L27:
	nop
	b L16
L17:
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
	addu $sp, $sp, 88
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl List_Search
List_Search:
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
	li $s2, 0
	move $s3, $s0
	lw $s4, 12($s0)
	lw $s5, 4($s0)
L28:
	li $s6, 1
	sne $v1, $s6, $s4
	move $t9, $v1
	move $s4, $t9
	beqz $s4 L29
	move $s4, $s1
	lw $s6, 0($s4)
	lw $t9, 12($s6)
	move $s6, $t9
	move $a0, $s4
	move $a1, $s5
	jalr $s6
	move $s4, $v0
	beqz $s4 L30
	li $s2, 1
	b L31
L30:
	li $s4, 0
L31:
	nop
	lw $s4, 0($s3)
	lw $t9, 16($s4)
	move $s4, $t9
	move $a0, $s3
	jalr $s4
	move $s3, $v0
	move $s4, $s3
	lw $s5, 0($s4)
	lw $t9, 28($s5)
	move $s5, $t9
	move $a0, $s4
	jalr $s5
	move $s4, $v0
	move $s5, $s3
	lw $s6, 0($s5)
	lw $t9, 12($s6)
	move $s6, $t9
	move $a0, $s5
	jalr $s6
	move $s5, $v0
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
	lw $s6, 24($sp)
	addu $sp, $sp, 36
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl List_GetEnd
List_GetEnd:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	move $s0, $a0
	lw $s1, 12($s0)
	move $v0, $s1
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addu $sp, $sp, 16
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl List_GetElem
List_GetElem:
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
	.globl List_GetNext
List_GetNext:
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
	.globl List_Print
List_Print:
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
	move $s1, $s0
	lw $s2, 12($s0)
	lw $s3, 4($s0)
L32:
	li $s4, 1
	sne $v1, $s4, $s2
	move $t9, $v1
	move $s2, $t9
	beqz $s2 L33
	move $s2, $s3
	lw $s3, 0($s2)
	lw $t9, 8($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	move $a0, $s2
	jal _print
	lw $s2, 0($s1)
	lw $t9, 16($s2)
	move $s2, $t9
	move $a0, $s1
	jalr $s2
	move $s1, $v0
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 28($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	move $s3, $s1
	lw $s4, 0($s3)
	lw $t9, 12($s4)
	move $s4, $t9
	move $a0, $s3
	jalr $s4
	move $s3, $v0
	b L32
L33:
	nop
	li $s1, 1
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
	.globl LL_Start
LL_Start:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 52
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	move $s0, $a0
	li $s1, 40
	add $v1, $s1, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s1, $v0
	li $s2, 16
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	la $s3, List_Delete
	sw $s3, 0($s1)
	la $s3, List_Print
	sw $s3, 4($s1)
	la $s3, List_Init
	sw $s3, 8($s1)
	la $s3, List_GetElem
	sw $s3, 12($s1)
	la $s3, List_GetNext
	sw $s3, 16($s1)
	la $s3, List_SetNext
	sw $s3, 20($s1)
	la $s3, List_Search
	sw $s3, 24($s1)
	la $s3, List_GetEnd
	sw $s3, 28($s1)
	la $s3, List_InitNew
	sw $s3, 32($s1)
	la $s3, List_Insert
	sw $s3, 36($s1)
	li $s3, 0
	sw $s3, 4($s2)
	li $s3, 0
	sw $s3, 8($s2)
	li $s3, 0
	sw $s3, 12($s2)
	sw $s1, 0($s2)
	move $s1, $s2
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 8($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	move $s4, $s2
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 8($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	move $s4, $s2
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 4($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	move $s4, $s2
	li $s2, 24
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	li $s3, 16
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	la $s4, Element_GetSalary
	sw $s4, 0($s2)
	la $s4, Element_Init
	sw $s4, 4($s2)
	la $s4, Element_GetAge
	sw $s4, 8($s2)
	la $s4, Element_Equal
	sw $s4, 12($s2)
	la $s4, Element_GetMarried
	sw $s4, 16($s2)
	la $s4, Element_Compare
	sw $s4, 20($s2)
	li $s4, 0
	sw $s4, 4($s3)
	li $s4, 0
	sw $s4, 8($s3)
	li $s4, 0
	sw $s4, 12($s3)
	sw $s2, 0($s3)
	move $s2, $s3
	move $s3, $s2
	move $s2, $s3
	lw $s4, 0($s2)
	lw $t9, 4($s4)
	move $s4, $t9
	li $s5, 25
	li $s6, 37000
	li $s7, 0
	move $a0, $s2
	move $a1, $s5
	move $a2, $s6
	move $a3, $s7
	jalr $s4
	move $s2, $v0
	move $s4, $s2
	lw $s2, 0($s1)
	lw $t9, 36($s2)
	move $s2, $t9
	move $a0, $s1
	move $a1, $s3
	jalr $s2
	move $s1, $v0
	move $s2, $s1
	lw $s3, 0($s2)
	lw $t9, 4($s3)
	move $s3, $t9
	move $a0, $s2
	jalr $s3
	move $s2, $v0
	move $s4, $s2
	li $s2, 10000000
	move $a0, $s2
	jal _print
	li $s2, 24
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	li $s3, 16
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	la $s4, Element_GetSalary
	sw $s4, 0($s2)
	la $s4, Element_Init
	sw $s4, 4($s2)
	la $s4, Element_GetAge
	sw $s4, 8($s2)
	la $s4, Element_Equal
	sw $s4, 12($s2)
	la $s4, Element_GetMarried
	sw $s4, 16($s2)
	la $s4, Element_Compare
	sw $s4, 20($s2)
	li $s4, 0
	sw $s4, 4($s3)
	li $s4, 0
	sw $s4, 8($s3)
	li $s4, 0
	sw $s4, 12($s3)
	sw $s2, 0($s3)
	move $s2, $s3
	move $s3, $s2
	move $s2, $s3
	lw $s4, 0($s2)
	lw $t9, 4($s4)
	move $s4, $t9
	li $s5, 39
	li $s6, 42000
	li $s7, 1
	move $a0, $s2
	move $a1, $s5
	move $a2, $s6
	move $a3, $s7
	jalr $s4
	move $s2, $v0
	move $s4, $s2
	move $s2, $s3
	lw $s4, 0($s1)
	lw $t9, 36($s4)
	move $s4, $t9
	move $a0, $s1
	move $a1, $s3
	jalr $s4
	move $s1, $v0
	move $s3, $s1
	lw $s4, 0($s3)
	lw $t9, 4($s4)
	move $s4, $t9
	move $a0, $s3
	jalr $s4
	move $s3, $v0
	move $s4, $s3
	li $s3, 10000000
	move $a0, $s3
	jal _print
	li $s3, 24
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	li $s4, 16
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, Element_GetSalary
	sw $s5, 0($s3)
	la $s5, Element_Init
	sw $s5, 4($s3)
	la $s5, Element_GetAge
	sw $s5, 8($s3)
	la $s5, Element_Equal
	sw $s5, 12($s3)
	la $s5, Element_GetMarried
	sw $s5, 16($s3)
	la $s5, Element_Compare
	sw $s5, 20($s3)
	li $s5, 0
	sw $s5, 4($s4)
	li $s5, 0
	sw $s5, 8($s4)
	li $s5, 0
	sw $s5, 12($s4)
	sw $s3, 0($s4)
	move $s3, $s4
	move $s4, $s3
	lw $s5, 0($s4)
	lw $t9, 4($s5)
	move $s5, $t9
	li $s6, 22
	li $s7, 34000
	li $v1, 0
	sw $v1, 36($sp)
	move $a0, $s4
	move $a1, $s6
	move $a2, $s7
	lw $v1, 36($sp)
	move $a3, $v1
	jalr $s5
	move $s4, $v0
	lw $s4, 0($s1)
	lw $t9, 36($s4)
	move $s4, $t9
	move $a0, $s1
	move $a1, $s3
	jalr $s4
	move $s1, $v0
	move $s3, $s1
	lw $s4, 0($s3)
	lw $t9, 4($s4)
	move $s4, $t9
	move $a0, $s3
	jalr $s4
	move $s3, $v0
	move $s4, $s3
	li $s3, 24
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	li $s4, 16
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, Element_GetSalary
	sw $s5, 0($s3)
	la $s5, Element_Init
	sw $s5, 4($s3)
	la $s5, Element_GetAge
	sw $s5, 8($s3)
	la $s5, Element_Equal
	sw $s5, 12($s3)
	la $s5, Element_GetMarried
	sw $s5, 16($s3)
	la $s5, Element_Compare
	sw $s5, 20($s3)
	li $s5, 0
	sw $s5, 4($s4)
	li $s5, 0
	sw $s5, 8($s4)
	li $s5, 0
	sw $s5, 12($s4)
	sw $s3, 0($s4)
	move $s3, $s4
	move $s4, $s3
	lw $s5, 0($s4)
	lw $t9, 4($s5)
	move $s5, $t9
	li $s6, 27
	li $s7, 34000
	li $v1, 0
	sw $v1, 40($sp)
	move $a0, $s4
	move $a1, $s6
	move $a2, $s7
	lw $v1, 40($sp)
	move $a3, $v1
	jalr $s5
	move $s4, $v0
	move $s4, $s1
	lw $s5, 0($s4)
	lw $t9, 24($s5)
	move $s5, $t9
	move $a0, $s4
	move $a1, $s2
	jalr $s5
	move $s4, $v0
	move $a0, $s4
	jal _print
	move $s4, $s1
	lw $s5, 0($s4)
	lw $t9, 24($s5)
	move $s5, $t9
	move $a0, $s4
	move $a1, $s3
	jalr $s5
	move $s3, $v0
	move $a0, $s3
	jal _print
	li $s3, 10000000
	move $a0, $s3
	jal _print
	li $s3, 24
	add $v1, $s3, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s3, $v0
	li $s4, 16
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $s5, Element_GetSalary
	sw $s5, 0($s3)
	la $s5, Element_Init
	sw $s5, 4($s3)
	la $s5, Element_GetAge
	sw $s5, 8($s3)
	la $s5, Element_Equal
	sw $s5, 12($s3)
	la $s5, Element_GetMarried
	sw $s5, 16($s3)
	la $s5, Element_Compare
	sw $s5, 20($s3)
	li $s5, 0
	sw $s5, 4($s4)
	li $s5, 0
	sw $s5, 8($s4)
	li $s5, 0
	sw $s5, 12($s4)
	sw $s3, 0($s4)
	move $s3, $s4
	move $s4, $s3
	lw $s5, 0($s4)
	lw $t9, 4($s5)
	move $s5, $t9
	li $s6, 28
	li $s7, 35000
	li $v1, 0
	sw $v1, 32($sp)
	move $a0, $s4
	move $a1, $s6
	move $a2, $s7
	lw $v1, 32($sp)
	move $a3, $v1
	jalr $s5
	move $s4, $v0
	lw $s4, 0($s1)
	lw $t9, 36($s4)
	move $s4, $t9
	move $a0, $s1
	move $a1, $s3
	jalr $s4
	move $s1, $v0
	move $s4, $s1
	lw $s5, 0($s4)
	lw $t9, 4($s5)
	move $s5, $t9
	move $a0, $s4
	jalr $s5
	move $s4, $v0
	li $s4, 2220000
	move $a0, $s4
	jal _print
	lw $s4, 0($s1)
	lw $t9, 0($s4)
	move $s4, $t9
	move $a0, $s1
	move $a1, $s2
	jalr $s4
	move $s1, $v0
	move $s2, $s1
	lw $s4, 0($s2)
	lw $t9, 4($s4)
	move $s4, $t9
	move $a0, $s2
	jalr $s4
	move $s2, $v0
	move $s4, $s2
	li $s2, 33300000
	move $a0, $s2
	jal _print
	lw $s2, 0($s1)
	lw $t9, 0($s2)
	move $s2, $t9
	move $a0, $s1
	move $a1, $s3
	jalr $s2
	move $s1, $v0
	lw $s2, 0($s1)
	lw $t9, 4($s2)
	move $s2, $t9
	move $a0, $s1
	jalr $s2
	move $s1, $v0
	move $s4, $s1
	li $s1, 44440000
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
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	addu $sp, $sp, 52
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
