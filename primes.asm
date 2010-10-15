largest_prime:
	addiu 	$sp, $sp, -24		# Gør plads til 4 registre
	sw 	$ra, 20($sp)		# Gem registrene på stacken
	sw 	$s4, 16($sp)
	sw	$s3, 12($sp)
	sw 	$s2, 8($sp)	
	sw	$s1, 4($sp)
	sw	$s0, 0($sp)

	addu	$s3, $a0, $0		# Gem argumentet n i s3

	addiu	$a1, $0, 4		# Vi vil gange n med 4
	jal 	mul			# for at få størrelsen på vores array

	addu	$sp, $sp, $v0		# Ryk stakpegeren for at gøre plads til primes	
	addu	$s4, $sp, $0		# Gem primes i s4

	addiu 	$s0, $s0, 2 		# i = 2
L1:	slt	$t0, $s0, $s3		# t0 = i < n?
	beq 	$t0, $0, L1_exit	# hvis i >= n hop ud
	
	addu 	$a0, $0, $s0		# find offsetet til primes[i]
	addiu	$a1, $0, 4
	jal	mul
	addu	$t0, $v0, $s4

	sw 	$s0, ($t0)		# gem i i primes[i]

	addiu	$s0, $s0, 1		# forøg i med 1
	j	L1

L1_exit:	


mul:
	addu	$t0, $0, $0
	addiu	$t1, $0, 1
	addu	$v0, $0, $0
	
mulloop:
	beq	$a1, $0, mulexit
	subu	$a1, $a1, $t1
	addu	$v0, $v0, $a0
	j	mulloop
	
mulexit:
	jr	$ra

exit: