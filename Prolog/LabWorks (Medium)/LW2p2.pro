% Организовать ввод и формирование двух строковых списков.
% Найти пересечение этих списков. Упорядочить списки в алфавитном порядке.
domains
list = string*
predicates
form(integer)
member(string, list)
intersec(list, list, list)
add(integer, integer, list)
sort(list, list)
issorted(list)
main
clauses
main:-form(N),add(1,N,L1),write("\n"),add(1,N,L2),intersec(L1,L2,L),sort(L,SL),write(SL,"\n").

member(A,[]):-!,fail.
member(A, [A|T]):-!.
member(A, [H|T]):- member(A,T).
intersec([],A,[]):-!.
intersec([H|T], A, R):- intersec(T,A,R1),not(member(H,R1)),member(H,A),R=[H|R1],!; intersec(T,A,R).

issorted([]):-!.
issorted([H]):-!.
issorted([H1|[H2|T]]):- H1<=H2, issorted([H2|T]).
sort([],[]):-!.
sort([H],[H]):-!.
sort([H1|[H2|T]], R):-	issorted([H1|[H2|T]]), R = [H1|[H2|T]],!; 
						H1<=H2, sort([H2|T],R1), sort([H1|R1],R),!;
						H1>H2, sort([H1|T], R1), sort([H2|R1],R).

form(N):- write("Count: "), readln(LN), str_int(LN,N).
add(I,N,[]):-I>N,!.
add(I,N,RES):- I<=N, write("Elem(",I,"): "), readln(R), I1=I+1, add(I1,N,ES), RES=[R|ES],!.