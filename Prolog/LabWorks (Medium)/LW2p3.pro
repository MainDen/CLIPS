%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Организовать ввод и формирование двух целочисленных списков X и Y из N элементов. %
% Найти список Т, элементы которого получают значения по правилу: Ti = max(Xi,Yi),  %
% и подсчитать, сколько элементов в Тi получило значения Xi.                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
domains
	ilist = integer*

predicates
	input(integer)
	input(integer,ilist)
	input(integer,integer,ilist)
	max(integer,integer,integer)
	eq(integer,integer)
	eqlistcount(ilist,ilist,integer)
	maxlist(ilist,ilist,ilist)
	test

clauses
	input(N):-
		write("Length: "),readln(LN),str_int(LN,N),N>0,!;
		write("Length must be lager then zero!"),fail.
	input(N,List):-
		write("Input list:\n"),input(0,N,List).
	input(I,N,List):-
		I<N,write("[",I,"]: "),readln(LN),str_int(LN,H),NEXT=I+1,input(NEXT,N,T),List=[H|T],!;
		List=[].
	max(I1,I2,R):-
		I1>I2,R=I1,!;
		R=I2.
	maxlist(L1,[],L1):-!.
	maxlist([],L2,L2):-!.
	maxlist([H1|T1],[H2|T2],R):-
		max(H1,H2,H),maxlist(T1,T2,T),R=[H|T].
	eq(I,I).
	eqlistcount(_,[],0):-!.
	eqlistcount([],_,0):-!.
	eqlistcount([H1|T1],[H2|T2],R):-
		eq(H1,H2),eqlistcount(T1,T2,R0),R=R0+1,!;
		eqlistcount(T1,T2,R).
	test:-
		input(N),input(N,X),input(N,Y),maxlist(X,Y,T),eqlistcount(X,T,C),
		write("X = ",X,"\nY = ",Y,"\nT = ",T,"\n",C," Ti got the Xi values\n").