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