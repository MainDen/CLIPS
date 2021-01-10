%project "LabWork2"
%include "LabWork2\\String.pro"
constants
	pathIn = "input.txt"
	pathOut = "output.txt"
	operators = ["0","1","not","and","conj","or","disj","xor","eq","xnor","nor","peirce","nand","sheffer","impl"]
	varX = ["X0","X1","X2","X3","X4","X5","X6","X7","X8","X9"]
	varY = ["Y0","Y1","Y2","Y3","Y4","Y5","Y6","Y7","Y8","Y9"]
	varZ = ["Z0","Z1","Z2","Z3","Z4","Z5","Z6","Z7","Z8","Z9"]
	varA = ["A ","B ","C ","D ","E ","F ","G ","H ","I ","J ","K ","L ","M ","N ","O ","P ","Q ","R ","S ","T ","U ","V ","W ","X ","Y ","Z "]
	varElse = [' ',',','(',')','\t','\n','\0','f','.','=']
	varChBig = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
	varChSmall = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
	varChNum = ['0','1','2','3','4','5','6','7','8','9']
	varChZO = ['0','1']

domains
	bool=integer
	listInt=integer*
	listChr=char*
	listStr=string*

predicates
% Logical
	bool(bool)				% Boolean {"false" = 0, true = 1}
	not2(bool,bool)			% Negation ("¬", "-", "!")
	and2(bool,bool,bool)	% Logical conjunction ("∧", "⋅", "&")
	conj2(bool,bool,bool)	% Logical conjunction ("∧", "⋅", "&")
	or2(bool,bool,bool)		% Logical disjunction ("∨", "+", "|")
	disj2(bool,bool,bool)	% Logical disjunction ("∨", "+", "|")
	xor2(bool,bool,bool)	% Exclusive or ("⊕")
	eq2(bool,bool,bool)		% Equality ("↔", "≡", "==")
	xnor2(bool,bool,bool)	% Equality ("↔", "≡", "==")
	nor2(bool,bool,bool)	% Peirce arrow ("↓")
	peirce2(bool,bool,bool)	% Peirce arrow ("↓")
	nand2(bool,bool,bool)	% Sheffer stroke ("↑", "\")
	sheffer2(bool,bool,bool)% Sheffer stroke ("↑", "\")
	impl2(bool,bool,bool)	% Implication ("→")

% Print
	printFunction(string)
	printHead(listStr,integer)
	printListInt(listInt)

% List
	aListInt(listInt,integer,listInt)
	nListInt(listInt,integer,listInt)
	findListInt(integer,listInt)
	hasListInt(integer,listInt)
	addListBool(listInt,integer,listInt)
	findListChr(char,listChr)
	hasListChr(char,listChr)
	aListStr(listStr,string,listStr)
	findListStr(string,listStr)
	hasListStr(string,listStr)
	lengthListStr(listStr,integer)
	isListStrInt(listStr,listInt,string,integer)
	sortedListStr(listStr)
	sortListStr(listStr,listStr,listStr)
	findNameList(string,string,listStr,listStr)

% String
	exclude(string,listChr,string,string)
	comparison(string,string,integer)

% Eval
	eval(string)
	eval(string,integer)
	eval(string,listInt,integer)
	eval(string,listStr ,listInt,integer)
	eval(string,string,listStr,listInt,string,integer)
	logical(string,bool)
	logical(string,bool,bool)
	logical(string,bool,bool,bool)
	logicalConnect(listStr,listInt,integer,string,string,string,string,string,string)
	conj(listStr,listInt,string)
	conj(string,string)
	disj(listStr,listInt,string)
	disj(string,string)
	cnf(string)
	cnf(string,string)
	cnf(string,listStr,listInt,string)
	dnf(string)
	dnf(string,string)
	dnf(string,listStr,listInt,string)

% Test
	test(string)

goal
	test("and(X,Y)"),test("or(X1,X2)"),test("impl(X1, X2)").

clauses
% Logical
	bool(0).
	bool(1).
	not2(0,1).
	not2(1,0).
	and2(0,0,0).
	and2(0,1,0).
	and2(1,0,0).
	and2(1,1,1).
	conj2(0,0,0).
	conj2(0,1,0).
	conj2(1,0,0).
	conj2(1,1,1).
	or2(0,0,0).
	or2(0,1,1).
	or2(1,0,1).
	or2(1,1,1).
	disj2(0,0,0).
	disj2(0,1,1).
	disj2(1,0,1).
	disj2(1,1,1).
	xor2(0,0,0).
	xor2(0,1,1).
	xor2(1,0,1).
	xor2(1,1,0).
	eq2(0,0,1).
	eq2(0,1,0).
	eq2(1,0,0).
	eq2(1,1,1).
	xnor2(0,0,1).
	xnor2(0,1,0).
	xnor2(1,0,0).
	xnor2(1,1,1).
	nor2(0,0,1).
	nor2(0,1,0).
	nor2(1,0,0).
	nor2(1,1,0).
	peirce2(0,0,1).
	peirce2(0,1,0).
	peirce2(1,0,0).
	peirce2(1,1,0).
	nand2(0,0,1).
	nand2(0,1,1).
	nand2(1,0,1).
	nand2(1,1,0).
	sheffer2(0,0,1).
	sheffer2(0,1,1).
	sheffer2(1,0,1).
	sheffer2(1,1,0).
	impl2(0,0,1).
	impl2(0,1,1).
	impl2(1,0,0).
	impl2(1,1,1).

% Print
	printFunction(S):-write("f(...)=",S,"\n").
	printHead(_,0):-nl,!.
	printHead(_,1):-write("f(...)"),printHead(_,0),!.
	printHead([],N):-!,fail.
	printHead([H|T],N):-H1=H,write(H,"\t|"),N1=N-1,printHead(T,N1),!.
	printListInt([]):-!,fail.
	printListInt([H]):-H1=H,write(H1),nl,!.
	printListInt([H|T]):-H1=H,write(H1,"\t|"),printListInt(T).

% List
	aListInt([],X,R):-bool(X),R=[X],!.
	aListInt([H],X,R):-bool(X),R=[H|[X]],!.
	aListInt([H|T],X,R):-bool(X),aListInt(T,X,R0),R=[H|R0].
	nListInt(L,0,R):-R=L,!.
	nListInt(L,N,R):-bool(X),aListInt(L,X,R0),N0=N-1,nListInt(R0,N0,R).
	findListInt(I,[]):-fail,!.
	findListInt(I,[H]):-I=H,!.
	findListInt(I,[H|T]):-I=H,!;findListInt(I,T).
	hasListInt(I,L):-findListInt(I,L),!.
	addListBool([H|T],I,R):-
		T=[],xor2(H,1,H1),and2(H,1,I),R=[H1];
		addListBool(T,I1,R1),xor2(H,I1,H1),and2(H,I1,I),R=[H1|R1].
	findListChr(C,[]):-fail,!.
	findListChr(C,[H]):-C=H,!.
	findListChr(C,[H|T]):-C=H,!;findListChr(C,T).
	hasListChr(C,L):-findListChr(C,L),!.
	aListStr([],X,R):-R=[X],!.
	aListStr([H],X,R):-R=[H|[X]],!.
	aListStr([H|T],X,R):-aListStr(T,X,R0),R=[H|R0].
	findListStr(S,[]):-fail,!.
	findListStr(S,[H]):-S=H,!.
	findListStr(S,[H|T]):-S=H;findListStr(S,T).
	hasListStr(S,L):-findListStr(S,L),!.
	lengthListStr([],0):-!.
	lengthListStr([H|T],N):-lengthListStr(T,N1),N=N1+1.
	isListStrInt([],_,_,_):-!,fail.
	isListStrInt(_,[],_,_):-!,fail.
	isListStrInt([S|T1],[I|T2],S,I).
	isListStrInt([S|T1],[I|T2],S0,I0):-isListStrInt(T1,T2,S0,I0).
	sortedListStr([]):-!.
	sortedListStr([H]):-!.
	sortedListStr([H1|[H2|T]]):-
		comparison(H1,H2,I),I=-1,sortedListStr([H2|T]);
		comparison(H1,H2,I),I= 0,sortedListStr([H2|T]).
	sortListStr([],R0,R):-sortedListStr(R0),R=R0,!;sortListStr(R0,[],R),!.
	sortListStr([H1|[H2|T]],R0,R):-
		comparison(H1,H2,I),I=-1,aListStr(R0,H1,R1),sortListStr([H2|T],R1,R),!;
		comparison(H1,H2,I),I= 0,aListStr(R0,H1,R1),sortListStr([H2|T],R1,R),!;
		comparison(H1,H2,I),I= 1,aListStr(R0,H2,R1),sortListStr([H1|T],R1,R),!.
	sortListStr([H],R0,R):-sortListStr([],[H|R0],R).
	findNameList("",S0,NL,R):-
		hasListStr(S0,operators),!;
		comparison(S0,"",I),I=1,hasListStr(S0,NL),R=NL,!;
		comparison(S0,"",I),I=1,aListStr(NL,S0,R),!;
		R=NL,!.
	findNameList(CS,S0,NL,R):-
		frontchar(CS,C,S),hasListChr(C,varElse),hasListStr(S0,operators),findNameList(S,"",NL,R),!;
		frontchar(CS,C,S),hasListChr(C,varElse),comparison(S0,"",I),I=1,hasListStr(S0,NL),findNameList(S,"",NL,R),!;
		frontchar(CS,C,S),hasListChr(C,varElse),comparison(S0,"",I),I=1,aListStr(NL,S0,NL0),findNameList(S,"",NL0,R),!;
		frontchar(CS,C,S),hasListChr(C,varElse),comparison(S0,"",I),I=0,findNameList(S,"",NL,R),!;
		frontchar(CS,C,S),str_char(SC,C),concat(S0,SC,S1),findNameList(S,S1,NL,R),!.

% String
	exclude("",CL,R0,R):-R=R0,!.
	exclude(S,CL,R0,R):-frontchar(S,C,S1),hasListChr(C,CL),exclude(S1,CL,R0,R),!.
	exclude(S,CL,R0,R):-frontchar(S,C,S1),str_char(SC,C),concat(R0,SC,R1),exclude(S1,CL,R1,R).
	comparison("","",0):-!.
    comparison(_,"",1):-!.
    comparison("",_,-1):-!.
    comparison(S1,S2,R):-
		frontchar(S1,C,S1_),
		frontchar(S2,C,S2_),
		comparison(S1_,S2_,R),!;
		frontchar(S1,C1,_),
		frontchar(S2,C2,_),
		C1<C2,R=-1,!;R=1,!.

% Eval
	eval(S):-
		exclude(S,varElse,"",S0),
		findNameList(S,"",[],NL),
		lengthListStr(NL,N),
		NR=N+1,
		printHead(NL,NR),
		nListInt([],N,VL),
		eval(S0,"",NL,VL,_,RES),
		aListInt(VL,RES,VLR),
		printListInt(VLR),
		fail.
	eval(S,RES):-
		exclude(S,varElse,"",S0),
		findNameList(S,"",[],NL),
		lengthListStr(NL,N),
		NR=N+1,
		nListInt([],N,VL),
		eval(S0,"",NL,VL,_,RES),
		aListInt(VL,RES,VLR).
	eval(S,VL,RES):-
		exclude(S,varElse,"",S0),
		findNameList(S,"",[],NL),
		lengthListStr(NL,N),
		NR=N+1,
		nListInt([],N,VL0),
		VL=VL0,
		eval(S0,"",NL,VL,_,RES),
		aListInt(VL,RES,VLR).

	eval(S,NL,VL,RES):-
		exclude(S,varElse,"",S0),
		findNameList(S,"",[],NL0),
		NL=NL0,
		lengthListStr(NL,N),
		NR=N+1,
		nListInt([],N,VL0),
		VL=VL0,
		eval(S0,"",NL,VL,_,RES),
		aListInt(VL,RES,VLR).

	eval(S,S0,NL,VL,TAIL,RES):-
		logical(S0,RES),TAIL=S,!;
		isListStrInt(NL,VL,S0,RES),TAIL=S,!;
		S0="not",eval(S,"",NL,VL,T,R),logical("not",R,RES),TAIL=T,!;
		hasListStr(S0,operators),eval(S,"",NL,VL,T1,R1),eval(T1,"",NL,VL,T2,R2),logical(S0,R1,R2,RES),TAIL=T2,!;
		S1=S,frontchar(S1,C,S2),C1=C,str_char(SC,C1),SC1=SC,concat(S0,SC1,S3),eval(S2,S3,NL,VL,TAIL,RES),!.

	logical("0",R):-bool(R),R=0.
	logical("1",R):-bool(R),R=1.
	logical("not",X1,R):-not2(X1,R).
	logical("and",X1,X2,R):-and2(X1,X2,R).
	logical("conj",X1,X2,R):-conj2(X1,X2,R).
	logical("or",X1,X2,R):-or2(X1,X2,R).
	logical("disj",X1,X2,R):-disj2(X1,X2,R).
	logical("xor",X1,X2,R):-xor2(X1,X2,R).
	logical("eq",X1,X2,R):-eq2(X1,X2,R).
	logical("xnor",X1,X2,R):-xnor2(X1,X2,R).
	logical("nor",X1,X2,R):-nor2(X1,X2,R).
	logical("peirce",X1,X2,R):-peirce2(X1,X2,R).
	logical("nand",X1,X2,R):-nand2(X1,X2,R).
	logical("sheffer",X1,X2,R):-sheffer2(X1,X2,R).
	logical("impl",X1,X2,R):-impl2(X1,X2,R).

	logicalConnect([N],[V],IS,PREF,SEP,SUFF,NEG,CON,R):-
		IS=V,
		R=N,!;
		concat(NEG,PREF,R00),
		concat(R00,N,R01),
		concat(R01,SUFF,R02),
		R=R02,!.

	logicalConnect([N|T],[V],IS,PREF,SEP,SUFF,NEG,CON,R):-% For debug
		logicalConnect([N],[V],IS,PREF,SEP,SUFF,NEG,CON,R),!.

	logicalConnect([N],[V|T],IS,PREF,SEP,SUFF,NEG,CON,R):-% For debug
		logicalConnect([N],[V],IS,PREF,SEP,SUFF,NEG,CON,R),!.

	logicalConnect([N|T1],[V|T2],IS,PREF,SEP,SUFF,NEG,CON,R):-
		IS=V,
		concat(CON,PREF,R1),
		concat(R1,N,R2),
		concat(R2,SEP,R3),
		logicalConnect(T1,T2,IS,PREF,SEP,SUFF,NEG,CON,R4),
		concat(R3,R4,R5),
		concat(R5,SUFF,R),!;
		concat(NEG,PREF,R00),
		concat(R00,N,R01),
		concat(R01,SUFF,R02),
		concat(CON,PREF,R1),
		concat(R1,R02,R2),
		concat(R2,SEP,R3),
		logicalConnect(T1,T2,IS,PREF,SEP,SUFF,NEG,CON,R4),
		concat(R3,R4,R5),
		concat(R5,SUFF,R),!.

	conj(S,R):-
		exclude(S,varElse,"",S0),findNameList(S,"",[],NL),lengthListStr(NL,N),!,nListInt([],N,VL),
		eval(S0,"",NL,VL,_,1),conj(NL,VL,R).
	conj(NL,VL,R):-logicalConnect(NL,VL,1,"(",",",")","not","and",R).

	disj(S,R):-
		exclude(S,varElse,"",S0),findNameList(S,"",[],NL),lengthListStr(NL,N),!,nListInt([],N,VL),
		eval(S0,"",NL,VL,_,0),disj(NL,VL,R).
	disj(NL,VL,R):-logicalConnect(NL,VL,0,"(",",",")","not","or",R).

	cnf(S):-
		exclude(S,varElse,"",S0),
		findNameList(S,"",[],NL),
		lengthListStr(NL,N),
		nListInt([],N,VL),!,
		cnf(S,NL,VL,R),
		write("f(...)=",R),nl.
	cnf(S,R):-
		exclude(S,varElse,"",S0),
		findNameList(S,"",[],NL),
		lengthListStr(NL,N),
		nListInt([],N,VL),!,
		cnf(S,NL,VL,R).
	cnf(S,NL,VL,R):-
		eval(S,NL,VL,0),disj(NL,VL,DISJ),addListBool(VL,0,VL1),cnf(S,NL,VL1,DISJ1),comparison(DISJ1,"",I),I=1,conj([DISJ|[DISJ1]],[1,1],R),!;
		eval(S,NL,VL,0),disj(NL,VL,DISJ),R=DISJ,!;
		addListBool(VL,0,VL1),cnf(S,NL,VL1,DISJ1),comparison(DISJ1,"",I),I=1,R=DISJ1,!.

	dnf(S):-
		exclude(S,varElse,"",S0),
		findNameList(S,"",[],NL),
		lengthListStr(NL,N),
		nListInt([],N,VL),!,
		dnf(S,NL,VL,R),
		write("f(...)=",R),nl.
	dnf(S,R):-
		exclude(S,varElse,"",S0),
		findNameList(S,"",[],NL),
		lengthListStr(NL,N),
		nListInt([],N,VL),!,
		dnf(S,NL,VL,R).
	dnf(S,NL,VL,R):-
		eval(S,NL,VL,1),conj(NL,VL,CONJ),addListBool(VL,0,VL1),dnf(S,NL,VL1,CONJ1),comparison(CONJ1,"",I),I=1,disj([CONJ|[CONJ1]],[0,0],R),!;
		eval(S,NL,VL,1),conj(NL,VL,CONJ),R=CONJ,!;
		addListBool(VL,0,VL1),dnf(S,NL,VL1,CONJ1),comparison(CONJ1,"",I),I=1,R=CONJ1,!.

% Test
	test(S):-
	clearwindow,printFunction(S),nl,write("Conj.Norm.Form:\n"),cnf(S),nl,write("Table:\n"),eval(S),!;
	not(cnf(S,_)),write("Does not exist.\n"),nl,write("Table:\n"),eval(S),!;
	write("Press 'ENTER' to continue.\n"),readln(L),L="",clearwindow,write("Next f(...)="),readln(S1),test(S1);
	clearwindow.