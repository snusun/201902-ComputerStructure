	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text

	#------You can declare additional functions here
	.align	1
	.globl	your_funct
	.type	your_funct, @function
	
	ld s1, 0(a0)
	mv s2, a1
	mv s3, a2
your_funct:
	addi sp, sp, -56
	sd ra, 48(sp)
	sd a0, 40(sp)
	sd a1, 32(sp)
	sd a2, 24(sp)
	sd a3, 16(sp)
	sd s4, 8(sp)
	sd s5, 0(sp)

	li t0, 20
	blt a2, t0, zero_checker

	li a0, -1	
	jr ra

	zero_checker:
		bge a0, zero, zero_check
		
		zero_check:
		bge a1, zero, outof
		ld s5, 0(sp)
		ld s4, 8(sp)
		ld a3, 16(sp)
		ld a2, 24(sp)
		ld a1, 32(sp)
		ld a0, 40(sp)
		ld ra, 48(sp)
	 	addi sp, sp, 56
		
		li a0, -1
		jr ra

	outof:
		blt a0, s2, Dead
		Dead:
		blt a1, s3, Dead_end
		
		ld s5, 0(sp)
		ld s4, 8(sp)
		ld a3, 16(sp)
		ld a2, 24(sp)
		ld a1, 32(sp)
		ld a0, 40(sp)
		ld ra, 48(sp)
	 	addi sp, sp, 56

		li a0, -1
		jr ra

	Dead_end:
		mul t1, a1, s2
		add t1, t1, a0
		slli t1, t1, 3
		add t1, s1, t1
		ld t2, 0(t1)
		beq t2, zero, Success
		
		ld s5, 0(sp)
		ld s4, 8(sp)
		ld a3, 16(sp)
		ld a2, 24(sp)
		ld a1, 32(sp)
		ld a0, 40(sp)
		ld ra, 48(sp)
	 	addi sp, sp, 56

		li a0, -1
		jr ra

	Success: 
		mv t3, s2
		addi t3, t3, -1
		bne a0, t3, tra
		next:
		mv t3, s3
		addi t3, t3, -1
		bne a1, t3, tra
		
		ld s5, 0(sp)
		ld s4, 8(sp)
		ld a3, 16(sp)
		ld a2, 24(sp)
		ld a1, 32(sp)
		ld a0, 40(sp)
		ld ra, 48(sp)
	 	addi sp, sp, 56

		mv a0, a2

		jr ra

	tra: 
		li s4, -1	
		li t3, 3
		beq a3, t3, left 

		addi sp, sp, -56 
		sd ra, 48(sp)
		sd a0, 40(sp)
		sd a1, 32(sp)
		sd a2, 24(sp)
		sd a3, 16(sp)
		sd s4, 8(sp)
		sd s5, 0(sp)
	
		addi a1, a1, -1
		addi a2, a2, 1
		li a3, 0

		jal ra, your_funct
		ld s4, 0(a0) # min = your_funct

		ld s5, 0(sp)
		ld s4, 8(sp)
		ld a3, 16(sp)
		ld a2, 24(sp)
		ld a1, 32(sp)
		ld a0, 40(sp)
		ld ra, 48(sp)
	 	addi sp, sp, 56

		left:
			li t3, 2
			beq a3, t3, right

			addi sp, sp, -56 
			sd ra, 48(sp)
			sd a0, 40(sp)
			sd a1, 32(sp)
			sd a2, 24(sp)
			sd a3, 16(sp)
			sd s4, 8(sp)
			sd s5, 0(sp)

			addi a0, a0, -1
			addi a2, a2, 1
			li a3, 1

			jal ra, your_funct
			ld s5, 0(a0)	 # result = your_funct		

			blt s5, zero, right

			ld s5, 0(sp)
			ld s4, 8(sp)
			ld a3, 16(sp)
			ld a2, 24(sp)
			ld a1, 32(sp)
			ld a0, 40(sp)
			ld ra, 48(sp)
		 	addi sp, sp, 56
					
			bge s4, zero, left_mer
			mv s4, s5
			beq zero, zero, right

			left_mer:
				bge s5, s4, right
				mv s4, s5		

		right:
			li t3, 1
			beq a3, t3, down			

			addi sp, sp, -56 
			sd ra, 48(sp)
			sd a0, 40(sp)
			sd a1, 32(sp)
			sd a2, 24(sp)
			sd a3, 16(sp)
			sd s4, 8(sp)
			sd s5, 0(sp)

			addi a0, a0, 1
			addi a2, a2, 1
			li a3, 2

			jal ra, your_funct
			ld s5, 0(a0)	 # result = your_funct		
			blt s5, zero, down			

			ld s5, 0(sp)
			ld s4, 8(sp)
			ld a3, 16(sp)
			ld a2, 24(sp)
			ld a1, 32(sp)
			ld a0, 40(sp)
			ld ra, 48(sp)
		 	addi sp, sp, 56
					
			bge s4, zero, right_mer
			mv s4, s5
			beq zero, zero, down

			right_mer:
				bge s5, s4, down
				mv s4, s5

		down:			
			li t3, 0
			beq a3, t3, return

			addi sp, sp, -56 
			sd ra, 48(sp)
			sd a0, 40(sp)
			sd a1, 32(sp)
			sd a2, 24(sp)
			sd a3, 16(sp)
			sd s4, 8(sp)
			sd s5, 0(sp)

			addi a1, a1, 1
			addi a2, a2, 1
			li a3, 3	

			jal ra, your_funct
			ld s5, 0(a0)	 # result = your_funct		
			blt s5, zero, return

			ld s5, 0(sp)
			ld s4, 8(sp)
			ld a3, 16(sp)
			ld a2, 24(sp)
			ld a1, 32(sp)
			ld a0, 40(sp)
			ld ra, 48(sp)
		 	addi sp, sp, 56
					
			bge s4, zero, down_mer
			mv s4, s5
			beq zero, zero, return

			down_mer:
				bge s5, s4, return
				mv s4, s5

	return: 
		mv a0, s4
		ld s5, 0(sp)
		ld s4, 8(sp)
		ld a3, 16(sp)
		ld a2, 24(sp)
		ld a1, 32(sp)
		ld a0, 40(sp)
		ld ra, 48(sp)
	 	addi sp, sp, 56
		
	#Ret
	jr	ra
	.size	your_funct, .-your_funct

	#------Your code ends here

	.align	1
	.globl	solve_maze
	.type	solve_maze, @function
solve_maze:
	#------Your code starts here------
	#maze: a0, width: a1, height: a2

	addi sp, sp, -32
	sd ra, 24(sp)
	sd a0, 16(sp)
	sd a1, 8(sp)
	sd a2, 0(sp)
	
	ld t1, 0(a0)
	mv t2, a1

#here load 0, 0, 0, T_RIGHT

	li a0, 0
	li a1, 0
	li a2, 0
	li a3, 2
	jal ra, your_funct
	
	mv a0, t1
	mv a1, t2

	ld a2, 0(sp)
	ld a1, 8(sp)
	ld a0, 16(sp)
	ld ra, 24(sp)
	addi sp, sp, 32


	#Load return value to reg a0
	#------Your code ends here------

	#Ret
	jr	ra
	.size	solve_maze, .-solve_maze


	.ident	"GCC: (GNU) 9.2.0"
