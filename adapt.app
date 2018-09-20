L#,+		;  1
L#,*		;  2
L#,/		;  3
L#,_		;  4
L#,^		;  5
L,c0		;  6
L,1{integer}	;  7
L,2{integer}	;  8
L,3{integer}	;  9
L,4{integer}	; 10
L,5{integer}	; 11
L,6{integer}	; 12
L,7{integer}	; 13
L,8{integer}	; 14
L,9{integer}	; 15
L,dBh		; 16
L,O		; 17
L,C		; 18
L,$		; 19
L,P		; 20

str:"`"
unary:"0123456789OocP"
binary:"+*/-^s"
indexes:"+*/-^0123456789OocsP"

D,append,
	@@@*,
	¿!,@,p{strip}b]+¿
	@p@
	
D,arity,
	@,
	V
	`unary` `binary`$b[
	G€Ωe
	dbUBx$
	dbLRz€¦*
	bM*

D,behead,
	@,
	BP

D,call,
	@@@*,
	d!Q
	$b[VbRbUGbU
	B {lambda}
	V@GB]

D,end,
	@,
	dd{join}=
	{out}

D,exec,
	@@,
	dbL1$>dV
	{append}
	bU$G!*dV
	d{index}
	${arity}
	G"."=
	{pop}
	bUBZ

D,if,
	@@@@,
	¿!,p{recurse},ppp{end}¿

D,index,
	@,
	`indexes`
	$€=dbLR
	z€¦*bUM

D,integer,
	@@#,
	10*+

D,join,
	@~,
	J

D,lambda,
	@@,
	$VbUG
	]

D,main,
	@~,
	@VB]G
	{parse}
	dbLR1€Ω_
	{recurse}

D,out,
	@@:,
	¿!,$bR0$:,p¿

D,parse,
	@,
	`str`€=
	¬Bx
	ABcB*B]
	Δ!€{join}
	VA
	`str`€=
	¬Bx€!
	ABcB*B]
	Δ!€{join}
	€{strip}
	GBcB]
	£o

D,pop,
	@@@@,
	¿!,p{call},@VcGBp¿

D,recurse,
	@@@,
	dbm$
	{behead}
	V@G@$:
	{exec}
	Ap$p$@
	dbL!
	{if}

D,strip,
	@,
	`str`$
	ßþ=J

_
$main>x
