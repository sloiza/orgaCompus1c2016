	.file	1 "tp0.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.rdata
	.align	2
$LC0:
	.ascii	"Usage:\t ./tp0 -h \n"
	.ascii	"\t ./tp0 -V \n"
	.ascii	"\t ./tp0 < in_file > out_file \n"
	.ascii	"Options: \n"
	.ascii	" -V, --version \n"
	.ascii	"\t Print version and quit. \n"
	.ascii	" -h, --help \n"
	.ascii	"\t Print this information and quit.\n"
	.ascii	" Examples: \n"
	.ascii	"  ./tp0 < in.txt > out.txt \n"
	.ascii	"  cat in.txt | ./tp0 > out.txt \n\000"
	.align	2
$LC1:
	.ascii	"%s\000"
	.text
	.align	2
	.globl	printHelp
	.ent	printHelp
printHelp:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	la	$v0,$LC0
	sw	$v0,24($fp)
	la	$a0,$LC1
	lw	$a1,24($fp)
	la	$t9,printf
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	printHelp
	.size	printHelp, .-printHelp
	.rdata
	.align	2
$LC2:
	.ascii	"-h\000"
	.align	2
$LC3:
	.ascii	"--help\000"
	.align	2
$LC4:
	.ascii	"-V\000"
	.align	2
$LC5:
	.ascii	"--version\000"
	.align	2
$LC6:
	.ascii	"-v\000"
	.align	2
$LC7:
	.ascii	"Version 1.0\n\000"
	.text
	.align	2
	.globl	checkArguments
	.ent	checkArguments
checkArguments:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	li	$v0,1			# 0x1
	sw	$v0,24($fp)
	lw	$v1,48($fp)
	li	$v0,2			# 0x2
	bne	$v1,$v0,$L19
	lw	$v0,52($fp)
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC2
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L20
	lw	$v0,52($fp)
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC3
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L19
$L20:
	la	$t9,printHelp
	jal	$ra,$t9
	sw	$zero,24($fp)
	b	$L21
$L19:
	lw	$v1,48($fp)
	li	$v0,2			# 0x2
	bne	$v1,$v0,$L21
	lw	$v0,52($fp)
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC4
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L23
	lw	$v0,52($fp)
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC5
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L23
	lw	$v0,52($fp)
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC6
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L21
$L23:
	la	$a0,$LC7
	la	$t9,printf
	jal	$ra,$t9
	sw	$zero,24($fp)
$L21:
	lw	$v0,24($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	checkArguments
	.size	checkArguments, .-checkArguments
	.rdata
	.align	2
$LC8:
	.ascii	"%d\000"
	.align	2
$LC9:
	.ascii	"Error reading stdin\n\000"
	.text
	.align	2
	.globl	leerDimensionMatriz
	.ent	leerDimensionMatriz
leerDimensionMatriz:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$zero,24($fp)
	la	$a0,__sF
	la	$a1,$LC8
	addu	$a2,$fp,24
	la	$t9,fscanf
	jal	$ra,$t9
	move	$v1,$v0
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L25
	lhu	$v0,__sF+12
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	bne	$v0,$zero,$L25
	lhu	$v0,__sF+12
	srl	$v0,$v0,6
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L25
	la	$a0,$LC9
	la	$t9,printf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L25:
	lw	$v0,24($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	leerDimensionMatriz
	.size	leerDimensionMatriz, .-leerDimensionMatriz
	.align	2
	.globl	create_matrix
	.ent	create_matrix
create_matrix:
	.frame	$fp,48,$ra		# vars= 8, regs= 4/0, args= 16, extra= 8
	.mask	0xd0010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,44($sp)
	sw	$fp,40($sp)
	sw	$gp,36($sp)
	sw	$s0,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	li	$a0,12			# 0xc
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$s0,24($fp)
	lw	$v1,48($fp)
	lw	$v0,52($fp)
	mult	$v1,$v0
	mflo	$v0
	sll	$v0,$v0,3
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,8($s0)
	lw	$v1,24($fp)
	lw	$v0,48($fp)
	sw	$v0,0($v1)
	lw	$v1,24($fp)
	lw	$v0,52($fp)
	sw	$v0,4($v1)
	lw	$v0,24($fp)
	move	$sp,$fp
	lw	$ra,44($sp)
	lw	$fp,40($sp)
	lw	$s0,32($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	create_matrix
	.size	create_matrix, .-create_matrix
	.rdata
	.align	2
$LC10:
	.ascii	"Error malloc \n\000"
	.align	2
$LC11:
	.ascii	"%lf\000"
	.align	2
$LC12:
	.ascii	"Matriz inv\303\241lida \n\000"
	.text
	.align	2
	.globl	readMatrix
	.ent	readMatrix
readMatrix:
	.frame	$fp,56,$ra		# vars= 16, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$ra,48($sp)
	sw	$fp,44($sp)
	sw	$gp,40($sp)
	move	$fp,$sp
	sw	$a0,56($fp)
	sw	$zero,24($fp)
	sw	$zero,28($fp)
	lw	$v0,56($fp)
	lw	$v1,56($fp)
	lw	$a0,0($v0)
	lw	$v0,0($v1)
	mult	$a0,$v0
	mflo	$v0
	sw	$v0,32($fp)
	lw	$v0,56($fp)
	bne	$v0,$zero,$L29
	la	$a0,__sF+176
	la	$a1,$LC10
	la	$t9,fprintf
	jal	$ra,$t9
$L29:
	sw	$zero,36($fp)
$L30:
	lw	$v0,36($fp)
	lw	$v1,32($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L33
	b	$L31
$L33:
	la	$a0,__sF
	la	$a1,$LC11
	addu	$a2,$fp,24
	la	$t9,fscanf
	jal	$ra,$t9
	move	$v1,$v0
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L34
	lhu	$v0,__sF+12
	srl	$v0,$v0,6
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L35
	la	$a0,$LC9
	la	$t9,printf
	jal	$ra,$t9
	lw	$v0,56($fp)
	beq	$v0,$zero,$L36
	lw	$v0,56($fp)
	lw	$a0,8($v0)
	la	$t9,free
	jal	$ra,$t9
	lw	$a0,56($fp)
	la	$t9,free
	jal	$ra,$t9
	sw	$zero,56($fp)
$L36:
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L35:
	lw	$a0,56($fp)
	lw	$v0,36($fp)
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$v0,$v1,$v0
	l.d	$f0,24($fp)
	s.d	$f0,0($v0)
	b	$L32
$L34:
	la	$a0,__sF+176
	la	$a1,$LC12
	la	$t9,fprintf
	jal	$ra,$t9
	lw	$v0,56($fp)
	beq	$v0,$zero,$L38
	lw	$v0,56($fp)
	lw	$a0,8($v0)
	la	$t9,free
	jal	$ra,$t9
	lw	$a0,56($fp)
	la	$t9,free
	jal	$ra,$t9
	sw	$zero,56($fp)
$L38:
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L32:
	lw	$v0,36($fp)
	addu	$v0,$v0,1
	sw	$v0,36($fp)
	b	$L30
$L31:
	lw	$v0,56($fp)
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	readMatrix
	.size	readMatrix, .-readMatrix
	.align	2
	.globl	matrix_multiply
	.ent	matrix_multiply
matrix_multiply:
	.frame	$fp,80,$ra		# vars= 40, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,80
	.cprestore 16
	sw	$ra,72($sp)
	sw	$fp,68($sp)
	sw	$gp,64($sp)
	move	$fp,$sp
	sw	$a0,80($fp)
	sw	$a1,84($fp)
	lw	$v0,80($fp)
	lw	$v0,0($v0)
	sw	$v0,24($fp)
	lw	$a0,24($fp)
	lw	$a1,24($fp)
	la	$t9,create_matrix
	jal	$ra,$t9
	sw	$v0,28($fp)
	sw	$zero,32($fp)
	sw	$zero,36($fp)
$L40:
	lw	$v1,24($fp)
	lw	$v0,24($fp)
	mult	$v1,$v0
	mflo	$v1
	lw	$v0,36($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L43
	b	$L41
$L43:
	sw	$zero,44($fp)
$L44:
	lw	$v0,44($fp)
	lw	$v1,24($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L47
	b	$L42
$L47:
	sw	$zero,56($fp)
	sw	$zero,60($fp)
	lw	$v0,36($fp)
	sw	$v0,48($fp)
	lw	$v0,44($fp)
	sw	$v0,40($fp)
$L48:
	lw	$v1,24($fp)
	lw	$v0,24($fp)
	mult	$v1,$v0
	mflo	$v1
	lw	$v0,40($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L51
	b	$L49
$L51:
	lw	$a0,80($fp)
	lw	$v0,48($fp)
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$a1,$v1,$v0
	lw	$a0,84($fp)
	lw	$v0,40($fp)
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$v0,$v1,$v0
	l.d	$f2,0($a1)
	l.d	$f0,0($v0)
	mul.d	$f2,$f2,$f0
	l.d	$f0,56($fp)
	add.d	$f0,$f0,$f2
	s.d	$f0,56($fp)
	lw	$v0,48($fp)
	addu	$v0,$v0,1
	sw	$v0,48($fp)
	lw	$v1,40($fp)
	lw	$v0,24($fp)
	addu	$v0,$v1,$v0
	sw	$v0,40($fp)
	b	$L48
$L49:
	lw	$a0,28($fp)
	lw	$v0,32($fp)
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$v0,$v1,$v0
	l.d	$f0,56($fp)
	s.d	$f0,0($v0)
	lw	$v0,32($fp)
	addu	$v0,$v0,1
	sw	$v0,32($fp)
	lw	$v0,44($fp)
	addu	$v0,$v0,1
	sw	$v0,44($fp)
	b	$L44
$L42:
	lw	$v0,36($fp)
	lw	$v1,24($fp)
	addu	$v0,$v0,$v1
	sw	$v0,36($fp)
	b	$L40
$L41:
	lw	$v0,28($fp)
	move	$sp,$fp
	lw	$ra,72($sp)
	lw	$fp,68($sp)
	addu	$sp,$sp,80
	j	$ra
	.end	matrix_multiply
	.size	matrix_multiply, .-matrix_multiply
	.align	2
	.globl	destroy_matrix
	.ent	destroy_matrix
destroy_matrix:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,40($fp)
	lw	$v0,40($fp)
	beq	$v0,$zero,$L52
	lw	$v0,40($fp)
	lw	$a0,8($v0)
	la	$t9,free
	jal	$ra,$t9
	lw	$a0,40($fp)
	la	$t9,free
	jal	$ra,$t9
	sw	$zero,40($fp)
$L52:
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	destroy_matrix
	.size	destroy_matrix, .-destroy_matrix
	.rdata
	.align	2
$LC13:
	.ascii	"%d \000"
	.align	2
$LC14:
	.ascii	"Error printing stdout\n\000"
	.align	2
$LC15:
	.ascii	" %lf\000"
	.align	2
$LC16:
	.ascii	"\n\000"
	.text
	.align	2
	.globl	print_matrix
	.ent	print_matrix
print_matrix:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	lw	$v0,48($fp)
	lw	$v0,0($v0)
	sw	$v0,24($fp)
	la	$a0,$LC13
	lw	$a1,24($fp)
	la	$t9,printf
	jal	$ra,$t9
	lhu	$v0,__sF+100
	srl	$v0,$v0,6
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L55
	la	$a0,__sF+176
	la	$a1,$LC14
	la	$t9,fprintf
	jal	$ra,$t9
	lw	$a0,48($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L55:
	sw	$zero,28($fp)
$L56:
	lw	$v1,24($fp)
	lw	$v0,24($fp)
	mult	$v1,$v0
	mflo	$v1
	lw	$v0,28($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L59
	b	$L57
$L59:
	lw	$a0,48($fp)
	lw	$v0,28($fp)
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$v0,$v1,$v0
	la	$a0,$LC15
	lw	$a2,0($v0)
	lw	$a3,4($v0)
	la	$t9,printf
	jal	$ra,$t9
	lhu	$v0,__sF+100
	srl	$v0,$v0,6
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L58
	la	$a0,__sF+176
	la	$a1,$LC14
	la	$t9,fprintf
	jal	$ra,$t9
	lw	$a0,48($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L58:
	lw	$v0,28($fp)
	addu	$v0,$v0,1
	sw	$v0,28($fp)
	b	$L56
$L57:
	la	$a0,$LC16
	la	$t9,printf
	jal	$ra,$t9
	lhu	$v0,__sF+100
	srl	$v0,$v0,6
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L61
	la	$a0,__sF+176
	la	$a1,$LC14
	la	$t9,fprintf
	jal	$ra,$t9
	lw	$a0,48($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L61:
	move	$v0,$zero
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	print_matrix
	.size	print_matrix, .-print_matrix
	.rdata
	.align	2
$LC17:
	.ascii	"Error: Matriz inv\303\241lida para multiplicaci\303\263n"
	.ascii	" \n\000"
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,64,$ra		# vars= 24, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,64
	.cprestore 16
	sw	$ra,56($sp)
	sw	$fp,52($sp)
	sw	$gp,48($sp)
	move	$fp,$sp
	sw	$a0,64($fp)
	sw	$a1,68($fp)
	lw	$a0,64($fp)
	lw	$a1,68($fp)
	la	$t9,checkArguments
	jal	$ra,$t9
	bne	$v0,$zero,$L65
	li	$v0,1			# 0x1
	sw	$v0,40($fp)
	b	$L62
$L65:
	la	$t9,leerDimensionMatriz
	jal	$ra,$t9
	sw	$v0,24($fp)
	lhu	$v0,__sF+12
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L68
	sw	$zero,40($fp)
	b	$L62
$L68:
	lw	$v0,24($fp)
	blez	$v0,$L69
	lw	$a0,24($fp)
	lw	$a1,24($fp)
	la	$t9,create_matrix
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$a0,28($fp)
	la	$t9,readMatrix
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$a0,24($fp)
	lw	$a1,24($fp)
	la	$t9,create_matrix
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$a0,32($fp)
	la	$t9,readMatrix
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$a0,28($fp)
	lw	$a1,32($fp)
	la	$t9,matrix_multiply
	jal	$ra,$t9
	sw	$v0,36($fp)
	lw	$a0,36($fp)
	la	$t9,print_matrix
	jal	$ra,$t9
	lw	$a0,28($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	lw	$a0,32($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	lw	$a0,36($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	b	$L67
$L69:
	la	$a0,__sF+176
	la	$a1,$LC17
	la	$t9,fprintf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L67:
	lhu	$v0,__sF+12
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L65
	sw	$zero,40($fp)
$L62:
	lw	$v0,40($fp)
	move	$sp,$fp
	lw	$ra,56($sp)
	lw	$fp,52($sp)
	addu	$sp,$sp,64
	j	$ra
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
