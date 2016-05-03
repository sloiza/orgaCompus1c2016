#include <mips/regdef.h>
#include <sys/syscall.h>
		.text
		.abicalls
		.align 2
		.globl	matrix_multiply
		.ent 	matrix_multiply
matrix_multiply:
		
		.frame  $fp, 48, ra
		.set 	noreorder
		.cpload t9
		.set	reorder
		subu sp, sp,48
		.cprestore 44
		sw $fp, 40(sp)
		move $fp,sp

		sw 		a0, 48($fp) #guardo dir m1
		sw 		a1, 52($fp) #guardo dir m2
		sw 		a2, 56($fp) #guardo dir out

		lw 		t0,48($fp) #t0= dir matrix m1
		li 		t1, 0
		addu 	t2, t0, t1 #cargo valor de rows
		lw 		t2, 0(t2)
		sw 		t2, 0($fp) #guardo valor de rows
		addiu 	t1, t1, 8
		addu 	t3, t0, t1 #cargo dir de array de m1
		lw 		t3, 0(t3)
		sw 		t3, 4($fp) #guardo dir de array de m1

		lw 		t0,52($fp) #t0= dir matrix m2
		li 		t1, 0
		addiu 	t1, t1, 8
		addu 	t3, t0, t1 #cargo dir de array de m2
		lw 		t3, 0(t3)
		sw 		t3, 8($fp) #guardo dir de array de m2


		lw 		t0,56($fp) #t0= dir matrix out
		li 		t1, 0
		addiu 	t1, t1, 8
		addu 	t3, t0, t1 #cargo dir de array de out
		lw 		t3, 0(t3)
		sw 		t3, 12($fp) #guardo dir de array de out

		li 		t0,0 #cargo valor el valor 0 en t0
		sw 		t0,16($fp) #pos = 0
		sw 		t0,20($fp) # i = 0
		sw 		t0,28($fp) # k = 0

		lw 		t1,0($fp) #t1=rows
		mul 	t1,t1,t1 #t1=rows*rows
		sw  	t1,36($fp) #cantidad de elementos matriz 1

f1: 	lw 		t0, 20($fp)  #t0= i
		lw 		t1, 36($fp)  #t1 = cantidad elementos
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
		lw  	t3, 36($fp) #t3=cantidad elementos
		bge 	t2,t3,endf3 #j< cantidad elementos

		lw  	t3, 4($fp) #t3=m1
		lw 		t1,32($fp) #t1=m
		sll 	t1,t1,3  #t1= m*8
		addu 	t3,t3,t1  #t3 = &m1[m]

		lw  	t4, 8($fp) #t4=m2
		lw 		t2, 24($fp) #t2=j
		sll 	t2, t2, 3 #t2 = j*8
		addu 	t4,t4,t2  #t4= &m2[j]

		l.d   	$f2,0(t3) #f1 = m1[m]
		l.d   	$f4,0(t4) #f2= m2[j]
		mul.d 	$f2,$f2,$f4 #m1[m]*m2[j]
		add.d 	$f0,$f0,$f2

		lw  	t1,32($fp) #cargo en t1 el valor de m
		addi 	t1,t1,1 #m = m+1
		sw  	t1,32($fp) # actualizo m

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
		li 		t0, 0
		sw 		t0, 28($fp)
		j  		f1


endf1: 	
	move sp, $fp
	lw $fp, 40(sp) #recupero fp
	addu sp,sp,48 #restablezco stack frame
	jr ra
	.end matrix_multiply

		.align 2
   		.globl print_string
   		.ent print_string
print_string:
    	.frame $fp, 16, ra    #frame multiplo de 8 bytes          
   	 	.set noreorder      
    	.cpload t9		      #se usa t9 para referenciar data global	
    	.set reorder

   	 	subu sp,sp,16         #reservo el stackframe
    	.cprestore 8          #lw y sw del gp en 8(sp) automatico

    	sw  $fp, 4(sp)		  #guarda fp
    	sw ra, 12(sp)
		move $fp, sp		  #fp=sp
    	sw	a0, 16($fp)       #guarda 1°arg (file descriptor)
    	sw	a1, 20($fp)       #guarda 2°arg (string)
    	move a0, a1           #a0=string carga la direcc del string como primer arg para llamar a strlen
    	la  t9, strlen        #carga direccion de la funcion strlen
    	jal t9                #llama a strlen retorno en v0
    	lw a0, 16($fp)        #carga el file descriptor como 1 argumento
    	move a2, v0           #carga el retorno de strlen como 3 argumento
    	li v0, SYS_write      #carga syscall en v0
    	syscall               #llamado a SYS_write
    	beqz a3, ok  	      #a3=0 --> syscall OK, a3=1 --> syscall error 
error:  li v0, -1             #si error devuelve -1
ok:                 	      #result syscall == v0 == #bytes escritos
    	lw gp, 8(sp)	      #restore gp
    	lw $fp, 4(sp)	      #restore fp
    	lw ra, 12(sp)
		addu sp, sp, 16	      #restore stack frame
    	jr ra                 #salta a la direccion siguiente a la que la haya llamado
.end print_string
