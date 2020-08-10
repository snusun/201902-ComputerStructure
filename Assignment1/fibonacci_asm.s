	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	fibonacci
	.type	fibonacci, @function
fibonacci:
	#------Your code starts here------
	#LHS: a0, RHS: a1

#type of count is unsigned	
	addi sp, sp, -16
	sd a0, 8(sp)
	sd a1, 0(sp)

#assign opt[0]=1, opt[1]=1
	li t0, 1	
	sd t0, 0(a0)
		

	li t1, 2
	blt a1, t1, fibonacci_ret # if

	sd t0, 8(a0)
	
	li t2, 2
	beq zero, zero, fibo	

	fibo: 
		blt a1, t2, exit
		mv t5, t2
		addi t5, t5, -2

		slli t6, t5, 3 # t6 = (i-2)*8
		add t6, t6, a0 # t6 = opt + (i-2)*8
		ld t3, 0(t6)
		ld t4, 8(t6)
		add s1, t3, t4
		sd s1, 16(t6)
		
		addi t2, t2, 1
		beq zero, zero, fibo

	fibonacci_ret:
		jr ra

	exit: 
	ld a1, 0(sp)
	ld a0, 8(sp)
	addi sp, sp, 16	
	
	#Load return value to reg a0
	#------Your code ends here-----

	#Ret
	jr	ra
	.size	fibonacci, .-fibonacci
	.ident	"GCC: (GNU) 9.2.0"
