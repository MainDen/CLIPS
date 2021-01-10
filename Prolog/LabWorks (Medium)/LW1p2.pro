% Определить среднее арифметическое элементов списка.
domains
	rlist=real*
predicates
	%%%%%%%%% Ввод списка %%%%%%%%%
	input(rlist)                  % Задаёт список
	input(integer,integer,rlist)  % Задаёт список
	%%%%%%% Обработка списка %%%%%%
	count(rlist,integer)          % Вычисляет количетво элементов списка
	sum(rlist,real)               % Вычисляет сумму элементов списка
	average(rlist,real)           % Вычисляет среднее арифметическое элементов списка
	%%%%%%%%%%%%% Run %%%%%%%%%%%%%
	run                           %
clauses%%%%%%%%%% Run %%%%%%%%%%%%%
	run:-clearwindow,input(LIST),clearwindow,write(LIST,"\n"),average(LIST,AVG),write("Average: ",AVG),nl.
	%%%%%%%%% Ввод списка %%%%%%%%%
	input(LIST):-write("Length: "),readln(LN),str_int(LN,N),input(0,N,LIST).
	input(I,N,LIST):-I>N,write("Error: invalid length.\n"),!,fail.
	input(N,N,[]):-!.
	input(I,N,[H|T]):-write("List[",I,"]: "),readln(LN),str_real(LN,H),I1=I+1,input(I1,N,T).
	%%%%%%% Обработка списка %%%%%%
	count([],0):-!.
	count([H|T],COUNT):-count(T,TCOUNT),COUNT=TCOUNT+1.
	sum([],0):-!.
	sum([H|T],SUM):-sum(T,TSUM),SUM=TSUM+H.
	average(LIST,AVG):-count(LIST,COUNT),COUNT>0,sum(LIST,SUM),AVG=SUM/COUNT,!.
	average(LIST,AVG):-write("Error: empty list.\n"),!,fail.