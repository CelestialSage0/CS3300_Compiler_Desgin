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
	la $s2, RunnerMany_run
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
	.globl RunnerMany_run
RunnerMany_run:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 200
	sw $s0, 24($sp)
	sw $s1, 28($sp)
	sw $s2, 32($sp)
	sw $s3, 36($sp)
	sw $s4, 40($sp)
	sw $s5, 44($sp)
	sw $s6, 48($sp)
	sw $s7, 52($sp)
	move $s0, $a0
	li $s1, 8
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
	la $s3, Base_manyArgs
	sw $s3, 0($s1)
	la $s3, Base_baseOnly
	sw $s3, 4($s1)
	sw $s1, 0($s2)
	move $s1, $s2
	move $s7, $s1
	li $s1, 12
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
	la $s3, Base_baseOnly
	sw $s3, 4($s1)
	la $s3, Level1_manyArgs
	sw $s3, 0($s1)
	la $s3, Level1_level1Only
	sw $s3, 8($s1)
	sw $s1, 0($s2)
	move $s1, $s2
	move $s6, $s1
	li $s1, 16
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
	la $s3, Base_baseOnly
	sw $s3, 4($s1)
	la $s3, Level2_manyArgs
	sw $s3, 0($s1)
	la $s3, Level1_level1Only
	sw $s3, 8($s1)
	la $s3, Level2_level2Only
	sw $s3, 12($s1)
	sw $s1, 0($s2)
	move $s1, $s2
	move $s5, $s1
	li $s1, 20
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
	la $s3, Level3_level3Only
	sw $s3, 16($s1)
	la $s3, Base_baseOnly
	sw $s3, 4($s1)
	la $s3, Level3_manyArgs
	sw $s3, 0($s1)
	la $s3, Level1_level1Only
	sw $s3, 8($s1)
	la $s3, Level2_level2Only
	sw $s3, 12($s1)
	sw $s1, 0($s2)
	move $s1, $s2
	move $s3, $s1
	li $s1, 12
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
	la $s4, Base_baseOnly
	sw $s4, 4($s1)
	la $s4, Level1_manyArgs
	sw $s4, 0($s1)
	la $s4, Level1_level1Only
	sw $s4, 8($s1)
	sw $s1, 0($s2)
	move $s1, $s2
	li $s2, 16
	add $v1, $s2, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s2, $v0
	li $s4, 4
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	la $t0, Base_baseOnly
	sw $t0, 4($s2)
	la $t0, Level2_manyArgs
	sw $t0, 0($s2)
	la $t0, Level1_level1Only
	sw $t0, 8($s2)
	la $t0, Level2_level2Only
	sw $t0, 12($s2)
	sw $s2, 0($s4)
	move $s2, $s4
	li $s4, 20
	add $v1, $s4, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $s4, $v0
	li $t0, 4
	add $v1, $t0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t0, $v0
	la $t1, Level3_level3Only
	sw $t1, 16($s4)
	la $t1, Base_baseOnly
	sw $t1, 4($s4)
	la $t1, Level3_manyArgs
	sw $t1, 0($s4)
	la $t1, Level1_level1Only
	sw $t1, 8($s4)
	la $t1, Level2_level2Only
	sw $t1, 12($s4)
	sw $s4, 0($t0)
	move $s4, $t0
	lw $t0, 0($s7)
	lw $t9, 0($t0)
	move $t0, $t9
	move $v1, $t0
	sw $v1, 120($sp)
	li $v1, 1
	sw $v1, 144($sp)
	li $v1, 2
	sw $v1, 136($sp)
	li $t0, 8
	add $v1, $t0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t0, $v0
	la $t1, _LAMBDA_0
	sw $t1, 0($t0)
	sw $s0, 4($t0)
	move $v1, $t0
	sw $v1, 100($sp)
	li $t0, 8
	add $v1, $t0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t0, $v0
	la $t1, _LAMBDA_1
	sw $t1, 0($t0)
	sw $s0, 4($t0)
	move $v1, $t0
	sw $v1, 72($sp)
	li $v1, 3
	sw $v1, 148($sp)
	li $t0, 8
	add $v1, $t0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t0, $v0
	la $t1, _LAMBDA_2
	sw $t1, 0($t0)
	sw $s0, 4($t0)
	move $v1, $t0
	sw $v1, 140($sp)
	move $a0, $s7
	lw $v1, 144($sp)
	move $a1, $v1
	lw $v1, 136($sp)
	move $a2, $v1
	lw $v1, 100($sp)
	move $a3, $v1
	lw $v1, 72($sp)
	sw $v1, 0($sp)
	lw $v1, 148($sp)
	sw $v1, 4($sp)
	lw $v1, 140($sp)
	sw $v1, 8($sp)
	lw $v1, 120($sp)
	jalr $v1
	move $s7, $v0
	lw $t0, 0($s6)
	lw $t9, 0($t0)
	move $t0, $t9
	move $v1, $t0
	sw $v1, 80($sp)
	li $v1, 1
	sw $v1, 88($sp)
	li $v1, 2
	sw $v1, 92($sp)
	li $t0, 8
	add $v1, $t0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t0, $v0
	la $t1, _LAMBDA_3
	sw $t1, 0($t0)
	sw $s0, 4($t0)
	move $v1, $t0
	sw $v1, 56($sp)
	li $t0, 8
	add $v1, $t0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t0, $v0
	la $t1, _LAMBDA_4
	sw $t1, 0($t0)
	sw $s0, 4($t0)
	move $v1, $t0
	sw $v1, 156($sp)
	li $v1, 3
	sw $v1, 160($sp)
	li $t0, 8
	add $v1, $t0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t0, $v0
	la $t1, _LAMBDA_5
	sw $t1, 0($t0)
	sw $s0, 4($t0)
	move $v1, $t0
	sw $v1, 124($sp)
	move $a0, $s6
	lw $v1, 88($sp)
	move $a1, $v1
	lw $v1, 92($sp)
	move $a2, $v1
	lw $v1, 56($sp)
	move $a3, $v1
	lw $v1, 156($sp)
	sw $v1, 0($sp)
	lw $v1, 160($sp)
	sw $v1, 4($sp)
	lw $v1, 124($sp)
	sw $v1, 8($sp)
	lw $v1, 80($sp)
	jalr $v1
	move $s6, $v0
	lw $t0, 0($s5)
	lw $t9, 0($t0)
	move $t0, $t9
	move $v1, $t0
	sw $v1, 96($sp)
	li $v1, 2
	sw $v1, 60($sp)
	li $v1, 3
	sw $v1, 64($sp)
	li $t0, 8
	add $v1, $t0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t0, $v0
	la $t1, _LAMBDA_6
	sw $t1, 0($t0)
	sw $s0, 4($t0)
	move $v1, $t0
	sw $v1, 176($sp)
	li $t0, 8
	add $v1, $t0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t0, $v0
	la $t1, _LAMBDA_7
	sw $t1, 0($t0)
	sw $s0, 4($t0)
	move $v1, $t0
	sw $v1, 128($sp)
	li $v1, 4
	sw $v1, 132($sp)
	li $t0, 8
	add $v1, $t0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t0, $v0
	la $t1, _LAMBDA_8
	sw $t1, 0($t0)
	sw $s0, 4($t0)
	move $v1, $t0
	sw $v1, 108($sp)
	move $a0, $s5
	lw $v1, 60($sp)
	move $a1, $v1
	lw $v1, 64($sp)
	move $a2, $v1
	lw $v1, 176($sp)
	move $a3, $v1
	lw $v1, 128($sp)
	sw $v1, 0($sp)
	lw $v1, 132($sp)
	sw $v1, 4($sp)
	lw $v1, 108($sp)
	sw $v1, 8($sp)
	lw $v1, 96($sp)
	jalr $v1
	move $s5, $v0
	lw $t0, 0($s3)
	lw $t9, 0($t0)
	move $t0, $t9
	move $v1, $t0
	sw $v1, 68($sp)
	li $v1, 3
	sw $v1, 116($sp)
	li $v1, 1
	sw $v1, 164($sp)
	li $t0, 8
	add $v1, $t0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t0, $v0
	la $t1, _LAMBDA_9
	sw $t1, 0($t0)
	sw $s0, 4($t0)
	move $v1, $t0
	sw $v1, 152($sp)
	li $t0, 8
	add $v1, $t0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t0, $v0
	la $t1, _LAMBDA_10
	sw $t1, 0($t0)
	sw $s0, 4($t0)
	move $v1, $t0
	sw $v1, 188($sp)
	li $v1, 2
	sw $v1, 104($sp)
	li $t0, 8
	add $v1, $t0, 4
	move $t9, $v1
	move $a0, $t9
	jal _halloc
	move $t0, $v0
	la $t1, _LAMBDA_11
	sw $t1, 0($t0)
	sw $s0, 4($t0)
	move $v1, $t0
	sw $v1, 84($sp)
	move $a0, $s3
	lw $v1, 116($sp)
	move $a1, $v1
	lw $v1, 164($sp)
	move $a2, $v1
	lw $v1, 152($sp)
	move $a3, $v1
	lw $v1, 188($sp)
	sw $v1, 0($sp)
	lw $v1, 104($sp)
	sw $v1, 4($sp)
	lw $v1, 84($sp)
	sw $v1, 8($sp)
	lw $v1, 68($sp)
	jalr $v1
	move $s3, $v0
	lw $t0, 0($s1)
	lw $t9, 8($t0)
	move $t0, $t9
	move $v1, $t0
	sw $v1, 168($sp)
	li $v1, 5
	sw $v1, 172($sp)
	move $a0, $s1
	lw $v1, 172($sp)
	move $a1, $v1
	lw $v1, 168($sp)
	jalr $v1
	move $s1, $v0
	lw $t0, 0($s2)
	lw $t9, 12($t0)
	move $t0, $t9
	move $v1, $t0
	sw $v1, 180($sp)
	li $v1, 6
	sw $v1, 184($sp)
	move $a0, $s2
	lw $v1, 184($sp)
	move $a1, $v1
	lw $v1, 180($sp)
	jalr $v1
	move $s2, $v0
	lw $t0, 0($s4)
	lw $t9, 16($t0)
	move $t0, $t9
	move $v1, $t0
	sw $v1, 112($sp)
	li $v1, 7
	sw $v1, 76($sp)
	move $a0, $s4
	lw $v1, 76($sp)
	move $a1, $v1
	lw $v1, 112($sp)
	jalr $v1
	move $s4, $v0
	add $v1, $s7, $s6
	move $t9, $v1
	move $s6, $t9
	add $v1, $s5, $s3
	move $t9, $v1
	move $s3, $t9
	add $v1, $s6, $s3
	move $t9, $v1
	move $s3, $t9
	add $v1, $s1, $s2
	move $t9, $v1
	move $s1, $t9
	add $v1, $s1, $s4
	move $t9, $v1
	move $s1, $t9
	add $v1, $s3, $s1
	move $t9, $v1
	move $s1, $t9
	move $v0, $s1
	lw $s0, 24($sp)
	lw $s1, 28($sp)
	lw $s2, 32($sp)
	lw $s3, 36($sp)
	lw $s4, 40($sp)
	lw $s5, 44($sp)
	lw $s6, 48($sp)
	lw $s7, 52($sp)
	addu $sp, $sp, 200
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Base_manyArgs
Base_manyArgs:
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
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3
	lw $s4, 0($fp)
	lw $s5, 4($fp)
	move $s6, $s3
	lw $s7, 0($s6)
	move $a0, $s6
	move $a1, $s1
	jalr $s7
	move $s6, $v0
	lw $s7, 0($s4)
	move $a0, $s4
	move $a1, $s2
	jalr $s7
	move $s4, $v0
	add $v1, $s6, $s4
	move $t9, $v1
	move $s7, $t9
	add $v1, $s7, $s5
	move $t9, $v1
	move $s7, $t9
	move $a0, $s7
	jal _print
	add $v1, $s6, $s4
	move $t9, $v1
	move $s4, $t9
	add $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	move $v0, $s4
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
	.globl Base_baseOnly
Base_baseOnly:
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
	move $a0, $s2
	jal _print
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Level1_manyArgs
Level1_manyArgs:
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
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3
	lw $s4, 0($fp)
	lw $s5, 4($fp)
	move $s6, $s3
	lw $s7, 0($s6)
	move $a0, $s6
	move $a1, $s1
	jalr $s7
	move $s6, $v0
	lw $s7, 0($s4)
	move $a0, $s4
	move $a1, $s2
	jalr $s7
	move $s4, $v0
	add $v1, $s6, $s4
	move $t9, $v1
	move $s7, $t9
	li $t0, 10
	add $v1, $s5, $t0
	move $t9, $v1
	move $t0, $t9
	add $v1, $s7, $t0
	move $t9, $v1
	move $s7, $t9
	move $a0, $s7
	jal _print
	add $v1, $s6, $s4
	move $t9, $v1
	move $s4, $t9
	li $s6, 10
	add $v1, $s5, $s6
	move $t9, $v1
	move $s5, $t9
	add $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	move $v0, $s4
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
	.globl Level1_level1Only
Level1_level1Only:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	li $s2, 100
	add $v1, $s1, $s2
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Level2_manyArgs
Level2_manyArgs:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 64
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
	move $s3, $a3
	lw $s4, 0($fp)
	lw $s6, 4($fp)
	lw $s5, 8($fp)
	move $s7, $s3
	lw $t0, 0($s7)
	move $v1, $t0
	sw $v1, 32($sp)
	move $a0, $s7
	move $a1, $s1
	lw $v1, 32($sp)
	jalr $v1
	move $s7, $v0
	lw $t0, 0($s4)
	move $v1, $t0
	sw $v1, 40($sp)
	move $a0, $s4
	move $a1, $s2
	lw $v1, 40($sp)
	jalr $v1
	move $s4, $v0
	lw $t0, 0($s5)
	move $v1, $t0
	sw $v1, 36($sp)
	move $a0, $s5
	move $a1, $s6
	lw $v1, 36($sp)
	jalr $v1
	move $s5, $v0
	add $v1, $s7, $s4
	move $t9, $v1
	move $s6, $t9
	add $v1, $s6, $s5
	move $t9, $v1
	move $s6, $t9
	move $a0, $s6
	jal _print
	add $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	add $v1, $s7, $s4
	move $t9, $v1
	move $s4, $t9
	move $v0, $s4
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	addu $sp, $sp, 64
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Level2_level2Only
Level2_level2Only:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	li $s2, 200
	add $v1, $s1, $s2
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Level3_manyArgs
Level3_manyArgs:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 64
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
	move $s3, $a3
	lw $s4, 0($fp)
	lw $s6, 4($fp)
	lw $s5, 8($fp)
	move $s7, $s3
	lw $t0, 0($s7)
	move $v1, $t0
	sw $v1, 32($sp)
	move $a0, $s7
	move $a1, $s1
	lw $v1, 32($sp)
	jalr $v1
	move $s7, $v0
	lw $t0, 0($s4)
	move $v1, $t0
	sw $v1, 40($sp)
	move $a0, $s4
	move $a1, $s2
	lw $v1, 40($sp)
	jalr $v1
	move $s4, $v0
	lw $t0, 0($s5)
	move $v1, $t0
	sw $v1, 36($sp)
	move $a0, $s5
	move $a1, $s6
	lw $v1, 36($sp)
	jalr $v1
	move $s5, $v0
	add $v1, $s7, $s4
	move $t9, $v1
	move $s6, $t9
	mul $v1, $s6, $s5
	move $t9, $v1
	move $s6, $t9
	move $a0, $s6
	jal _print
	add $v1, $s7, $s4
	move $t9, $v1
	move $s4, $t9
	mul $v1, $s4, $s5
	move $t9, $v1
	move $s4, $t9
	move $v0, $s4
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	addu $sp, $sp, 64
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Level3_level3Only
Level3_level3Only:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	li $s2, 300
	add $v1, $s1, $s2
	move $t9, $v1
	move $s2, $t9
	move $a0, $s2
	jal _print
	move $v0, $s2
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addu $sp, $sp, 20
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _LAMBDA_3
_LAMBDA_3:
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
	.globl _LAMBDA_4
_LAMBDA_4:
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
	.globl _LAMBDA_1
_LAMBDA_1:
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
	.globl _LAMBDA_11
_LAMBDA_11:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	move $s0, $a0
	move $s1, $a1
	li $s2, 10
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
	.globl _LAMBDA_2
_LAMBDA_2:
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
	.globl _LAMBDA_10
_LAMBDA_10:
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
	.globl _LAMBDA_7
_LAMBDA_7:
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
	.globl _LAMBDA_8
_LAMBDA_8:
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
	sub $v1, $s1, $s2
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
	.globl _LAMBDA_5
_LAMBDA_5:
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
	.globl _LAMBDA_6
_LAMBDA_6:
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
	.globl _LAMBDA_9
_LAMBDA_9:
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
	.globl _LAMBDA_0
_LAMBDA_0:
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
