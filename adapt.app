code:?
input:""
char:""
str:"`"
radix:10
argv:_

; Commands:
;
; @ - Push 0
; ? - Push the next arg
; A - Push all args
; ! - Push the next input char
; # - Push all input
; a - Push each arg
;
; P - Prime test
; O - Output
; o - Ord
; c - Char
; r - Set radix
; i - Integer
; ' - String
;
; + - addition
; * - multiply
; - - subtract
; / - divide
; ^ - exponent
; % - modulo
;
; s - Swap
; . - Duplicate
; [ - Wrap
; ~ - Pop
; : - Reverse
; ] - Splat
; R - Rotate

digits:"1234567890"
nilads:"@?A!#a"
unary:"POocri'"
dyads:"+*-/^%"
stacks:"s.[~:]R"
cmds:"POocri+*-/^%"
chars:"1234567890POocri'+*-/^%s.[~:]R@?A!#`a"

Dchar,
	`char,
	]getchar,
	`input,
	+char

constargv:argv
constinput:input

; === Nilad functions === ;

D,niladat,
	@,

D,niladarg,
	@,
	p`argv`
	d0$:VBPG
	b]+"argv"UG

D,niladargs,
	@*,
	p`constargv`

D,niladchar,
	@,
	p`input`
	d0$:VBPG
	+"input"UG

D,niladinput,
	@,
	p`constinput`

D,niladunargs,
	@,
	p`constargv`

; === Unary functions === ;

D,unaryprime,
	@,
	P

D,unaryout,
	@,
	dBh

D,unaryord,
	@,
	O

D,unarychar,
	@,
	C

D,unaryradix,
	@,
	d"radix"U

D,unaryint,
	@,
	i

D,unarystr,
	@,
	J

; === Dyad functions === ;

D,dyadadd,
	@@,
	+

D,dyadmul,
	@@,
	*

D,dyadsub,
	@@,
	_

D,dyaddiv,
	@@,
	/

D,dyadexp,
	@@,
	^

D,dyadmod,
	@@,
	%

; === Stack functions === ;

D,stackswap,
	@*,
	2{pop}
	bU+

D,stackdup,
	@*,
	d1{pop}
	bU$p+

D,stackwrap,
	@*,
	b]

D,stackpop,
	@~*,
	pB]

D,stackrev,
	@*,
	bR

D,stacksplat,
	@*,
	1{pop}bUbU+

D,stackrot,
	@*,
	1{pop}bU$+

; === Switch functions === ;

D,pushstring,
	@,
	BPb]BK$+
	{global}

D,pushdigit,
	@,
	iBK1{pop}bU
	@V@bUi`radix`
	*G+b]+
	{global}

D,pushnilad,
	@,
	`nilads`$€=
	dbL1_0rBcB*
	BZ0B]bMV
	`$niladat`
	`$niladarg`
	`$niladargs`
	`$niladchar`
	`$niladinput`
	`$niladunargs`
	B]G$:0$~
	B]BK$+
	{global}

D,rununary,
	@,
	`unary`$€=
	dbL1_0rBcB*
	BZ0B]bMV
	`$unaryprime`
	`$unaryout`
	`$unaryord`
	`$unarychar`
	`$unaryradix`
	`$unaryint`
	`$unarystr`
	B]G$:BK
	1{pop}bUbR
	$V$~b]G$+
	{global}

D,rundyad,
	@,
	`dyads`$€=
	dbL1_0rBcB*
	BZ0B]bMV
	`$dyadadd`
	`$dyadmul`
	`$dyadsub`
	`$dyaddiv`
	`$dyadexp`
	`$dyadmod`
	B]G$:BK
	2{pop}bUbR
	$V$~b]G$+
	{global}

D,runstack,
	@,
	`stacks`$€=
	dbL1_0rBcB*
	BZ0B]bMV
	`$stackswap`
	`$stackdup`
	`$stackwrap`
	`$stackpop`
	`$stackrev`
	`$stacksplat`
	`$stackrot`
	B]G$:BKb]$~
	{global}

; === Helper functions === ;

D,dequeue,
	@~,
	@p@B]

D,global,
	@,
	dBk

D,list,
	@*,
	bU

D,string,
	@,
	`str`$+

D,take,
	@@,
	$bU@B

D,pop,
	@@#,
	dbL$@$_0<
	Ap*0b]*+dVAp
	{take}GApGbL$
	_$bR${take}b[
	
D,filter,
	@,
	0$:`chars`$e

D,getswitchcmd,
	@,
	1_V
	`$pushstring`
	`$pushdigit`
	`$pushnilad`
	`$rununary`
	`$rundyad`
	`$runstack`
	B]G$:

; === Main functions === ;

D,parse,
	@,
	`str`$t
	dbL2%`str`b]*+
	2$TbUBc
	€{string}$€{list}
	zBFB]`str`d+$þ=þ!
	Þ{filter}

D,exec,
	@,
	d0$:`str`=
	$d`digits`$e2*
	$d`nilads`$e3*
	$d`unary` $e4*
	$d`dyads` $e5*
	$d`stacks`$e6*
	$BZb]${getswitchcmd}~

D,main,
	@:,
	{parse}
	€{exec}
	pBKA
	"O"e!*
	BZbUn

; === Main code === ;

$global>[]

`argv
$dequeue>argv

`constargv
$dequeue>constargv

$main>code
