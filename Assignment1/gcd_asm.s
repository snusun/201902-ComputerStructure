	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text


	.align	1
	.globl	gcd
	.type	gcd, @function
gcd:
	#------Your code starts here------
	#LHS: a0, RHS: a1

	#addi sp, sp, -16
	#sd x1, 8(sp)
	#sd x10, 0(sp)
	#jal x1, gcd
	#ld a0, 0(sp)
	#addi sp, sp, 8

	gcd:
		beq a0, a1, done
		bge a1, a0, b_bigger
		sub a0, a0, a1
		beq a0, a0, gcd
	b_bigger:
		sub a1, a1, a0	
		beq a1, a1, gcd
	done:
	#ret	

	#Load return value to reg a0
	#------Your code ends here------

	#Ret
	jr	ra
	.size	gcd, .-gcd


	.ident	"GCC: (GNU) 9.2.0"
