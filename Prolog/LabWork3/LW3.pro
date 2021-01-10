domains
	listReal=real*

predicates
	input(listReal,integer)
	input(string,listReal,integer)
	input(integer,string,listReal,integer)
	input(string,integer,string,listReal,integer)
	inputCondition(string)
	check(string,string,real)
	check(string,real,string,real)
	aListReal(listReal,real,listReal)
	aListList(listReal,listReal,listReal)
	sortList(listReal,listReal)
	sortedList(listReal)
	findListReal(real,listReal)
	hasListReal(real,listReal)
	listToSet(listReal,listReal)
	test

goal
	test.

clauses
	input(L,N):-input(0,"real",L,N).
	input(S,L,N):-input(0,S,L,N).
	input(I,CHECK,L,N):-
		write("List[",I,"]:"),readln(LN),
		input(LN,I,CHECK,L,N).
	input(LN,I,CHECK,L,N):-
		check(CHECK,LN,R),I1=I+1,input(I1,CHECK,L1,N1),N=N1+1,L=[R|L1],!;
		check("real",LN,R),write("Condition not met.\n"),input(I,CHECK,L,N),!;
		L=[],N=0.
	inputCondition(COND):-
		write("Condition for elements (like '>0'):\n"),
		readln(COND).
	check("<",E,LN,R):-str_real(LN,R),R<E,!.
	check(">",E,LN,R):-str_real(LN,R),R>E,!.
	check("=",E,LN,R):-str_real(LN,R),R=E,!.
	check("==",E,LN,R):-str_real(LN,R),R<>E,!.
	check("<>",E,LN,R):-str_real(LN,R),R<>E,!.
	check("!=",E,LN,R):-str_real(LN,R),R<>E,!.
	check("<=",E,LN,R):-str_real(LN,R),R<=E,!.
	check(">=",E,LN,R):-str_real(LN,R),R>=E,!.
	check("real",LN,R):-str_real(LN,R),!.
	check("",LN,R):-str_real(LN,R),!.
	check(S,LN,R):-
		fronttoken(S,T1,T),fronttoken(T,T2,TT),str_real(TT,R0),concat(T1,T2,T0),check(T0,R0,LN,R),!;
		fronttoken(S,T0,T),str_real(T,R0),check(T0,R0,LN,R).
	aListReal([],X,R):-R=[X],!.
	aListReal([H],X,R):-R=[H|[X]],!.
	aListReal([H|T],X,R):-aListReal(T,X,R0),R=[H|R0].
	aListList([],[],[]):-!.
	aListList([],L,L):-!.
	aListList(L,[],L):-!.
	aListList(L,[H],[H|L]):-!.
	aListList([H],L,[H|L]):-!.
	aListList([H1|T1],[H2|T2],R):-aListList([H1|[H2|T1]],T2,R),!.
	sortList([],[]):-!.
	sortList([H],[H]):-!.
	sortList([H1|[H2|T]],R):-
		sortedList([H1|[H2|T]]),R=[H1|[H2|T]],!;
		H1>=H2,sortList([H2|T],R1),sortList([H1|R1],R),!;
		H1<H2,sortList([H1|T],R2),sortList([H2|R2],R).
	sortedList([]):-!.
	sortedList([H]):-!.
	sortedList([H1|[H2|T]]):-H1>=H2,sortedList([H2|T]).
	findListReal(X,[]):-fail,!.
	findListReal(X,[H]):-X=H,!.
	findListReal(X,[H|T]):-X=H,!;findListReal(X,T).
	hasListReal(X,L):-findListReal(X,L),!.
	listToSet([],[]):-!.
	listToSet([H],[H]):-!.
	listToSet([H|T],R):-
		listToSet(T,R0),hasListReal(H,R0),R=R0,!;
		listToSet(T,R0),R=[H|R0],!.
	test:-
		clearwindow,write("Input first list.\n"),
		inputCondition(COND1),
		input(COND1,L1,_),clearwindow,write(L1),nl,readchar(_),
		clearwindow,write("Input second list.\n"),
		inputCondition(COND2),
		input(COND2,L2,_),clearwindow,write(L2),nl,readchar(_),
		clearwindow,
		write("First list:\n",L1),nl,write("Second list:\n",L2),nl,
		aListList(L1,L2,L),write("Combine of lists:\n",L),nl,
		sortList(L,SL),write("Sorted combine:\n",SL),nl,
		write("Press 'ENTER' to continue.\n"),readln(Line),Line="",test,!;
		clearwindow.
		