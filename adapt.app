; First, we define the core variables:
; `code` contains the file, read from the ARGV
; `input` contains the contents of STDIN
; `char` is a temp variable for colleting STDIN
; `str` sets the opening and closing character for strings. At the moment, it is a backtick (`)
; `radix` is the base for pushing integers
; `argv` contains the list of ARGV

code:?
input:""
char:""
str:"`"
radix:10
argv:_

; We then define our string variables:
; `digits` contains the digits from 0 to 9
; `nilads` contains the niladic (no argument) commands
; `unary` contains the commands with only 1 argument
; `dyads` have the commands with 2 arguments
; `stacks` are the commands that operate only on the stack
; `cmds` is a collection of `unary` and `dyads`

digits:"1234567890"
nilads:"@?A!#"
unary:"POocr"
dyads:"+*-/^%"
stacks:"s.[~:]R"
cmds:"POocr+*-/^%"
chars:"1234567890POocr+*-/^%s.[~:]R@?A!#`"

; Collect the input, char by char

Dchar,
	`char,
	]getchar,
	`input,
	+char,

; Take copies of `input` and `argv` in order to iterate over them

charinput:input
eachargv:argv

; If `code` contains a file name, read the file contents
; Finally, convert to a string, to avoid examples like "16"

`code
]read
]string

;  Twig functions  ;
; ================ ;

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

; ================ ;

;  Nilad commands  ;
; ================ ;

D,niladat,
	@*,
	0b]+

D,niladarg,
	@*,
	`eachargv`BP
	`eachargv`0$:
	$Vb]+G
	"eachargv"U

D,niladargv,
	@*,
	`argv`b]+

D,niladchar,
	@*,
	`charinput`BP
	`charinput`0$:
	$Vb]+G
	"charinput"U

D,niladinput,
	@*,
	`input`b]+

; ================ ;

;  Stack commands  ;
; ================ ;

D,stackswap,
	@*,
	2{pop}bU+

D,stackdup,
	@*,
	d1{pop}bU$p+

D,stackwrap,
	@*!,

D,stackpop,
	@*,
	1{pop}bUp

D,stackrev,
	@*,
	bR

D,stacksplat,
	@*~,
	
D,stackrot,
	@*,
	3{pop}bUbR
	1{pop}bU$++

; ================ ;

;     Commands     ;
; ================ ;

D,prime,
	@*,
	1{pop}bUbU
	P
	b]+

D,output,
	@*,
	1{pop}bUbU
	dBhA

D,ord,
	@*,
	1{pop}bUbU
	€O
	+

D,char,
	@*,
	1{pop}bUbU
	C
	b]+

D,setradix,
	@*,
	1{pop}bUbU
	"radix"U

D,plus,
	@*,
	2{pop}bUbU
	+
	b]+

D,mul,
	@*,
	2{pop}bUbU
	*
	b]+

D,sub,
	@*,
	2{pop}bUbU
	_
	b]+

D,div,
	@*,
	2{pop}bUbU
	/
	b]+

D,pow,
	@*,
	2{pop}bUbU
	^
	b]+
	
D,mod,
	@*,
	2{pop}bUbU
	%
	b]+

; ================ ;

; Branch functions ;
; ================ ;

D,pinteger,
	@@*,
	i$1{pop}bUbU@$
	@`radix`*+b]+

D,pstring,
	@@*,
	$VBPb]G$+

D,pnilad,
	@@*,
	`nilads`$€=
	dbLRz£*bMb[V
	`$niladat`
	`$niladarg`
	`$niladargv`
	`$niladchar`
	`$niladinput`
	B]GbUV@G@1_
	$:$b]$~

D,command,
	@@*,
	`cmds`$€=
	dbLRz£*bM1_
	`$prime`	b]
	`$output`	b]+
	`$ord`		b]+
	`$char`		b]+
	`$setradix`	b]+
	`$plus`		b]+
	`$mul`		b]+
	`$sub`		b]+
	`$div`		b]+
	`$pow`		b]+
	`$mod`		b]+
	:$b]$~

D,stackcmd,
	@@*,
	`stacks`$€=
	dbLRz£*bM1_
	`$stackswap`	b]
	`$stackdup`		b]+
	`$stackwrap`	b]+
	`$stackpop`		b]+
	`$stackrev`		b]+
	`$stacksplat`	b]+
	`$stackrot`		b]+
	:$b]$~

; ================ ;

; Trunk functions  ;
; ================ ;

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
	d0$:`str`=$
	d`digits`€e¦*$
	d`nilads`€e¦*$
	d`cmds`  €e¦*$
	d`stacks`€e¦*$
	pB]dbLRz£*bMV
	`$pstring`
	`$pinteger`
	`$pnilad`
	`$command`
	`$stackcmd`
	B]G1_$:ABKb[$~
	d{global}p
	;h

D,main,
	@:,
	{parse}
	€{exec}
	bUVcGbUn

; =============== ;

`x
$global>[0]
`code
$main>code
