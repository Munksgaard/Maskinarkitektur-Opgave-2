# test af MIPS instruktioner.

addiu $1, $0, 0x1               # $1 = 0 + 1 = 0x1
addiu $2, $0, 0xc               # $2 = 0 + 12 = 0xc
addiu $3, $0, 0xffff            # $3 = 0 + 0xffff = 0xffffffff (pga sign extend)
addu  $4, $1, $2                # $4 = 1 + 12 = 0xd
subu  $5, $2, $1                # $5 = 12 - 1 = 0xb
subu  $6, $1, $2                # $6 = 00000001 - 12 = 0xfffffff5
and   $7, $4, $5                # $7 = 1011 and 1101 = 0x9
and   $8, $0, $5                # $8 = 0000 and 1011 = 0x0
or    $9, $4, $5                # $9 = 1101 or 1011 = 0xf
or    $10, $5, $0               # $10 = 1011 or 0000 =0xb
slt   $11, $2, $5               # $11 = 12 < 11 = 0
slt   $12, $5, $2               # $12 = 11 < 12 = 1
andi  $13, $2, 0x6              # $13 = 1100 and 0110 = 0x4
andi  $14, $0, 0xffff           # $14 = 0 and 0xffff = 0x0
sw    $7, 4($1)                 # store the contents of $7 (0x9) in memory 0x4
lw    $15, 4($1)                # read memory 0x4 into register 15 (9)
slti  $16, $2, 0xa              # $16 = 12 < 10 = 0
slti  $17, $2, 0xff             # $17 = 12 < 0xff = 1
ori   $20, $10, 0x2             # $20 = 0xb or 0x2 = 0xf
ori   $21, $13, 0x8             # $21 = 0x4 or 0x8 = 0xc

addu $18, $1, $0                # load contents of $1 into $18, $18 = 1
Loop:   addiu $18, $18, 0x1     # add one to $18
        slti $19, $18, 0x5      # check if 18 is still less than 5
        beq $19, $zero, Exit    # if it isn't we're done, go out of the loop
        jal Loop  # if it is, loop again.

Exit:   
        addu $21, $4, $5
        addu $22, $4, $5
        jr   $31
