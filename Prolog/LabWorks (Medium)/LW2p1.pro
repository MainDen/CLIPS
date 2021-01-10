% Организовать ввод и формирование двух целочисленных списков с проверкой.
% Найти разность двух списков. Упорядочить полученный список по убыванию.
domains
	ilist=integer*
predicates
	%%%%%%%%% Ввод списка %%%%%%%%%
	input(ilist)                  % Задаёт список
	input(integer,integer,ilist)  % Задаёт список
	%%%%%% Обработка списков %%%%%%
	remove(ilist,integer,ilist)   % Удаляет первое вхождение заданного элемента в список
	difference(ilist,ilist,ilist) % Вычисляет разность списков
	issorted(ilist)               % Проверяет,отсортирован список или нет
	sort(ilist,ilist)             % Сортирует элементы списка по убыванию
	%%%%%%%%%%%%% Run %%%%%%%%%%%%%
	run                           %
clauses%%%%%%%%%% Run %%%%%%%%%%%%%
	run:-clearwindow,input(L1),clearwindow,input(L2),clearwindow,write(L1,"\n",L2,"\n"),difference(L1,L2,DL),sort(DL,SL),write(SL,"\n").
	%%%%%%%%% Ввод списка %%%%%%%%%
	input(LIST):-write("Length: "),readln(LN),str_int(LN,N),input(0,N,LIST).
	input(I,N,LIST):-I>N,write("Error: invalid length.\n"),!,fail.
	input(N,N,[]):-!.
	input(I,N,[H|T]):-write("List[",I,"] > 0: "),readln(LN),str_int(LN,H),H>0,I1=I+1,input(I1,N,T),!;input(I,N,[H|T]).
	%%%%%% Обработка списков %%%%%%
	remove([],I,[]):-!.
	remove([H|T],H,T):-!.
	remove([H|T],I,[H|R]):-remove(T,I,R).
	difference(LIST,[],LIST):-!.
	difference([],LIST,[]):-!.
	difference(L,[H|T],LIST):-remove(L,H,R),difference(R,T,LIST).
	issorted([]):-!.
	issorted([H]):-!.
	issorted([H1|[H2|T]]):-H1>=H2,issorted([H2|T]).
	sort([],[]):-!.
	sort([H],[H]):-!.
	sort([H1|[H2|T]],R):-
		issorted([H1|[H2|T]]),R=[H1|[H2|T]],!;
		H1>=H2,sort([H2|T],R1),sort([H1|R1],R),!;
		H1<H2,sort([H1|T],R2),sort([H2|R2],R).