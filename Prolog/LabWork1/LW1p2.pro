domains
	obj = integer
	list = obj*

predicates
	eq(obj,obj)
	noeq(obj,obj)
	out(list)
	count(list,integer)
	test(list)
	clr

goal
	clr;
	test([]);
	test([2]);
	test([1,1,1,1,1]);
	test([1,2,3,4,5,6,7,8,9,10]);
	readln(_).

clauses
	eq(X,Y):-X=Y.
	noeq(X,Y):-not(eq(X,Y)).
	clr:-clearwindow,fail.

	out([]):-write("no elements"),nl,nl,!,fail.
	out([H]):-write(" ",H),nl,!.
	out([H|T]):-write(" ",H),out(T),!.
	count([],0):-!.
	count([H],1):-!.
	count([H|T],N):-count(T,N1),N=N1+1,!.

	test(L):-out(L),count(L,N),write("Count = ",N),nl,nl,fail.