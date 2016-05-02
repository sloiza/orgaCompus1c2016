#include <mips/regdef.h>
#include <sys/syscall.h>
	.text
	.abicalls
	.align 2
	.globl	matrix_multiply
	.ent 	matrix_multiply
matrix_multiply:
		
		.frame  $fp, 56, ra
		.set 	noreorder
		.cpload t9
		.set	reorder
		subu sp, sp,56
		.cprestore 52
		sw $fp, 48(sp)
		move $fp,sp

		sw 		a0, 56($fp) #guardo dir m1
		sw 		a1, 60($fp) #guardo dir m2
		sw 		a2, 64($fp) #guardo dir out



		lw 		t0,56($fp) #t0= dir matrix m1
		li 		t1, 0
		addu 	t2, t0, t1 #cargo valor de rows
		lw 		t2, 0(t2)
		sw 		t2, 0($fp)
		addiu 	t1, t1, 8
		addu 	t3, t0, t1 #cargo dir de array de m1
		lw 		t3, 0(t3)
		sw 		t3, 4($fp)

		lw 		t0,60($fp) #t0= dir matrix m2
		li 		t1, 0
		addiu 	t1, t1, 8
		addu 	t3, t0, t1 #cargo dir de array de m2
		lw 		t3, 0(t3)
		sw 		t3, 8($fp)


		lw 		t0,64($fp) #t0= dir matrix out
		li 		t1, 0
		addiu 	t1, t1, 8
		addu 	t3, t0, t1 #cargo dir de array de out
		lw 		t3, 0(t3)
		sw 		t3, 12($fp)

		li 		t0,0 #cargo valor el valor 0 en t0
		sw 		t0,16($fp) #pos = 0
		sw 		t0,20($fp) # i = 0
		sw 		t0,28($fp) # k = 0

		lw 		t1,0($fp) #t1=rows
		mul 	t1,t1,t1 #t1=rows*rows
		sw  	t1,40($fp) #cantidad de elementos matriz 1

f1: 	lw 		t0, 20($fp)  #t0= i
		lw 		t1, 40($fp)  #t1 = cantidad elementos
		bge 	t0,t1,endf1  #i< cantidad elementos

f2:		lw  	t0,28($fp) #t0 = k
		lw  	t1,0($fp)  #t1= rows
		bge 	t0,t1,endf2   #k<rows
		li.d  	$f0, 0  #f0=sum=0
		
		lw  	t1,20($fp) #t1 = i
		sw  	t1, 32($fp) #m =i
		lw  	t2, 28($fp) #t2=k
		sw  	t2, 24($fp) #j=k

f3: 	lw  	t2, 24($fp) #t2 =j
		lw  	t3, 40($fp) #t3=cantidad elementos
		bge 	t2,t3,endf3 #j< cantidad elementos
		lw  	t3, 4($fp) #t3=m1
		lw 		t1,32($fp) #t1=m
		sll 	t1,t1,3  #t1= m*8
		addu 	t3,t3,t1  #t3 = &m1[m]
		lw  	t4, 8($fp) #t4=m2
		lw 		t2, 24($fp)
		sll 	t2, t2, 3 #t2 = j*8
		addu 	t4,t4,t2  #t4= &m2[j]
		l.d   	$f2,0(t3) #f1 = m1[m]
		l.d   	$f4,0(t4) #f2= m2[j]
		mul.d 	$f2,$f2,$f4
		add.d 	$f0,$f0,$f2
		lw  	t1,28($fp) #cargo en t1 el valor de m
		addi 	t1,t1,1 #m = m+1
		sw  	t1,28($fp) # actualizo m
		lw  	t1,24($fp) #t1=j
		lw  	t2,0($fp)  #t2 =rows
		addu 	t1,t1,t2  #t1= j+rows
		sw   	t1,24($fp) #j= j+rows
		j    	f3
endf3: 	lw 		t1, 12($fp) #t1=out
		lw 		t2, 16($fp) #t2=pos
		sll 	t2,t2,3  #t2=pos*8
		addu 	t1,t1,t2 # t1= &out[pos]
		s.d 	$f0,0(t1)  #out[pos]=sum
		lw 		t2,16($fp) #t2=pos
		addi 	t2,t2,1 #pos++
		sw  	t2,16($fp) #guardo pos
		lw  	t0,28($fp) #t0 = k
		addi 	t0,t0,1 #k++
		sw 		t0,28($fp)
		j   	f2
endf2: 	lw 		t0, 20($fp) #t0 = i
		lw 		t1,0($fp) #t1 =rows
		addu 	t0,t0,t1 # i=i+rows
		sw  	t0,20($fp)
		j  		f1


endf1: 	
	move sp, $fp
	lw $fp, 52(sp) #recupero fp
	addu sp,sp,56 #restablezco stack frame
	jr ra
	.end matrix_multiply

