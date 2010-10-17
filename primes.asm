main:	addiu 	$a0, $0, 28		# gør argumentet klar
	jal 	largest_prime		# largest_prime(28)
	
	addu	$v0, $0, $0 		# return 0
	j 	end

largest_prime:	
	addiu 	$sp, $sp, -24		# Gør plads til 4 registre
	sw 	$ra, 20($sp)		# Gem retur adressen på stacken
	sw 	$s4, 16($sp)		# Gem s-registrene, vi skal bruge s4 til primes
	sw	$s3, 12($sp)		# gem $s3 i stacken, da vi skal bruge s3 til n
	sw 	$s2, 8($sp)		
	sw	$s1, 4($sp)		
	sw	$s0, 0($sp)		# vi skal bruge s0 til i

	addu	$s3, $a0, $0		# Gem argumentet n i s3

	addiu	$a1, $0, 4		# Vi vil gange n med 4
	jal 	mul			# for at få størrelsen på vores array
	subu	$sp, $sp, $v0		# Ryk stakpegeren for at gøre plads til primes	
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
	addiu 	$s1, $0, 2		# Initialiser p=2
L2:	addu	$a0, $s1, $0		# Gør klar til at gange p med sig selv
	addu	$a1, $a0, $0
	jal 	mul			# v0 = p*p
	slt	$t0, $v0, $s3		# Sæt t0 til 1 hvis p*p er mindre end n
	beq 	$t0, $0, L2_exit	# Hvis p*p ikke er mindre end n, forlad løkke
	
	addu 	$a0, $s1, $0		# Gør klar til at gange p med 4 (offset ind i primes)
	addiu	$a1, $0, 4		
	jal 	mul			# v0 = p*4
	addu	$t1, $v0, $s4		# t1 = offset i primes til p. primes + p*4
	lw	$t0, ($t1)		# t0 = primes[p]
	beq	$t0, $0, L2_continue	# spring videre hvis primes[p] = 0

	addiu	$s0, $0, 2		# i = 2

W1:	addu	$a0, $s0, $0		# Gør klar til at gange i med p. a0 = i
	addu	$a1, $s1, $0		# a1 = p
	jal	mul				# v0 = i*p
	addu	$s2, $v0, $0		# idx = i*p

	slt	$t0, $s2, $s3		# t0 = idx < n
	beq	$t0, $0, W1_break	# break hvis idx ikke er < n, altså idx >= n

	addu 	$a0, $s2, $0		# gør kar til at gange idx med 4 (offset ind i primes)
	addiu	$a1, $0, 4
	jal 	mul			# v0 = p*4
	addu	$t0, $v0, $s4		# t0 = primes + idx*4 = positionen af primes[idx]
	sw	$0, ($t0)		# primes[idx] = 0

	addiu	$s0, $s0, 1		# i++

	j	W1
	
W1_break:	
	
L2_continue: 
	addiu 	$s1, $s1, 1		# inkrementer p
	j	L2

L2_exit:
	addu	$s0, $s3, $0		#  i = n (vi tr�kker en fra p� n�ste linje
L3:	addiu	$s0, $s0, -1		# i = i - 1
	slti 	$t0, $s0, 2		# t0 = i < 2
	addiu	$t1, $0, 1		# t1 = 1
	beq	$t1, $t0, L3_exit	# exit loop hvis i < 2
	
	addu	$a0, $s0, $0		# Gør klar til at regne i*4 (offset i primes til i) a0 = i
	addiu	$a1, $0, 4		# a1 = 4
	jal 	mul			# v0 = i*4
	addu	$t1, $v0, $s4		# t1 = i*4 + primes = positionen af primes[i]
	lw	$t0, ($t1)		# t0 = primes[i]
	beq	$t0, $0, L3		# Hvis primes[i] er nul, loop igen

	j	largest_prime_exit	# return i
	
L3_exit: 	
	addu	$s0, $0, $0		# gør returværdien klar
	
largest_prime_exit: 
	addu	$a0, $s3, $0		# Gør klar til at gange n med 4
	addiu	$a1, $0, 4		# Vi vil gange n med 4
	jal 	mul			# for at få størrelsen på vores array
	addu	$sp, $sp, $v0		# Ryk stakpegeren for at gøre plads til primes

	addu	$v0, $s0, $0		# Gem returnv�rdien

	lw 	$ra, 20($sp)		# hent returadressen retur adressen på stacken
	lw 	$s4, 16($sp)		# hent s-registrene ind igen
	lw	$s3, 12($sp)
	lw 	$s2, 8($sp)	
	lw	$s1, 4($sp)
	lw	$s0, 0($sp)
	addiu 	$sp, $sp, 24		# Gør plads til 4 registre
	jr	$ra			# skal fikses

mul:	addiu	$t1, $0, 1		# t1 = 1, vi skal bruge den til at dekrementere
	addu	$v0, $0, $0		# returværdien initialiseres til 0
	
mulloop: 
	slti	$t0, $a1, 1		# t0 = b < 1
	beq	$t0, $t1, mulexit	# Hvis b < 1 eller b !> 0, exit
	subu	$a1, $a1, $t1		# dekrementer b
	addu	$v0, $v0, $a0		# Læg a til resultatet
	j	mulloop			# loop
	
mulexit:
	jr	$ra			# returner


end:
