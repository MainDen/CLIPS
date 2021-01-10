%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Разработать программу, содержащую базу знаний с информацией о машинисте, кочегаре и кондукторе    %
% поездной бригады поезда “Москва – Санкт-Петербург”, у которых такие же фамилии, как у пассажиров, %
% едущих в этом поезде – Иванов, Петров и Сидоров – если известно, что:                             %
% ☻ пассажир Иванов живет в Москве;                                                                 %
% ☻ кондуктор живет на полпути от Москвы до Санкт-Петербурга;                                       %
% ☻ пассажир, однофамилец кондуктора, живет в Санкт-Петербурге;                                     %
% ☻ тот пассажир, который живет ближе к месту жительства кондуктора,                                %
%   чем другие пассажиры, зарабатывает в месяц ровно втрое больше кондуктора;                       %
% ☻ пассажир Петров зарабатывает в месяц 20 тыс. рублей;                                            %
% ☻ Сидоров (из бригады) недавно выиграл у кочегара партию на биллиарде.                            %
% Как фамилия машиниста?                                                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
domains
	person=person(type,sername,live,wages,play)
	persons=person*
	type=machinist;stoker;conductor;passenger
	sername=string
	sername_list=sername*
	live=string
	wages=integer
	play=winner;looser;other

predicates
% Main
	main
	is_sername(sername,sername_list)
	check_sernames(persons)
	write_all(persons)
% Persons
	eq(person,person)
	count(persons,integer)
	union(persons,persons,persons)
	contains(persons,person)
	disassemble(persons,persons,persons)
	fusion(persons,person)
	map_fusion(persons,persons)
	combination(persons,integer,integer,persons)
% Task
	enum(persons)
	mask(persons)
	distance(live,live,integer)
	wages(wages,wages)
	condition(persons)

goal
	main,readln(_),fail;
	write("Good -_-"),readln(_).

clauses
% Main
	main:-
		enum(PER),mask(MASKP),combination(MASKP,0,6,COM),map_fusion(PER,COM),condition(PER),check_sernames(PER),write_all(PER).
	write_all([]).
	write_all([person(T,S,L,W,P)|Tail]):-
		write(T," . ",S," . ",L," . ",W," . ",P,"\n"),write_all(Tail).
	is_sername(S,[H|Tail]):-
		S=H;
		is_sername(S,Tail).
	check_sernames([person(machinist,S1,L1,W1,P1)|[person(conductor,S2,L2,W2,P2)|[person(stoker,S3,L3,W3,P3)|Tail]]]):-
		is_sername(S1,["Sidoroff","Petroff","Ivanoff"]),
		is_sername(S2,["Sidoroff","Petroff","Ivanoff"]),
		is_sername(S3,["Sidoroff","Petroff","Ivanoff"]),
		S1<>S2,S2<>S3,S3<>S1.
% Persons
	eq(PERS,PERS).
	count([],0).
	count([H|T],COUNT):-
		count(T,COUNT1),COUNT=COUNT1+1.
	union([],[],[]).
	union([H|T],[],RES):-
		union(T,[],TRES),RES=[H|TRES].
	union([],[H|T],RES):-
		union([],T,TRES),RES=[H|TRES].
	union([HL|TL],[HR|TR],RES):-
		union(TL,TR,TRES),RES=[HL|[HR|TRES]].
	contains([H|T],P):-
		H=P;
		contains(T,P).
	disassemble([],R1,R2):-
		R1=[],R2=[].
	disassemble([H|T],R1,R2):-
		disassemble(T,TR1,TR2),R1=[H|TR1],R2=TR2;
		disassemble(T,TR1,TR2),R1=TR1,R2=[H|TR2].
	fusion([],_):-fail.
	fusion([H],H).
	fusion([H|[H|T]],H):-
		fusion([H|T],H).
	map_fusion([],_):-fail.
	map_fusion(_,[]):-fail.
	map_fusion([H],[H]).
	map_fusion([H1|[H2|TL]],[H1|[H2|TR]]):-
		map_fusion([H2|TL],[H2|TR]).
	combination(PERSONS,I,N,RES):-
		N=0,RES=[];
		0=I,I<N,combination(PERSONS,1,N,RES);
		0<I,I<N,disassemble(PERSONS,PERS,NEXT),fusion(PERS,P),I1=I+1,combination(NEXT,I1,N,OTHERS),RES=[P|OTHERS];
		0<I,I=N,fusion(PERSONS,P),RES=[P].
% Task
	enum(PERSONS):-
		eq(person(machinist,S1,L1,W1,P1),P_1),
		eq(person(conductor,S2,L2,W2,P2),P_2),
		eq(person(stoker,S3,L3,W3,P3),P_3),
		eq(person(passenger,"Sidoroff",L4,W4,P4),P_4),
		eq(person(passenger,"Petroff",L5,W5,P5),P_5),
		eq(person(passenger,"Ivanoff",L6,W6,P6),P_6),
		PERSONS=[P_1|[P_2|[P_3|[P_4|[P_5|[P_6]]]]]];
		write("Error in condition.\n"),!,fail.
	mask(PERSONS):-
		eq(person(machinist,S1,L1,W1,P1),P_1),                    % Иначе победителем может быть только машинист
		eq(person(T2,"Sidoroff",L2,W2,winner),P_2),               % Сидоров (из бригады) недавно выиграл у кочегара партию на биллиарде
		eq(person(conductor,S3,"Middle",W3,P3),P_3),              % кондуктор живет на полпути от Москвы до Санкт-Петербурга
		eq(person(stoker,S4,L4,W4,looser),P_4),                   % Сидоров (из бригады) недавно выиграл у кочегара партию на биллиарде
		eq(person(passenger,"Sidoroff",L5,W5,other),P_5),         % Иначе пассажир из Санкт-Петербурга может быть только Сидоров
		eq(person(passenger,"Ivanoff","Moscow",W6,other),P_6),    % пассажир Иванов живет в Москве
		eq(person(passenger,"Petroff",L7,20000,other),P_7),       % пассажир Петров зарабатывает в месяц 20 тыс. рублей
		eq(person(passenger,S3,"Saint-Petersburg",W8,other),P_8), % пассажир, однофамилец кондуктора, живет в Санкт-Петербурге
		PERSONS=[P_1|[P_2|[P_3|[P_4|[P_5|[P_6|[P_7|[P_8]]]]]]]],!;
		write("Error in condition.\n"),!,fail.
	distance("Saint-Petersburg","Moscow",10).
	distance("Moscow","Saint-Petersburg",10).
	distance("Saint-Petersburg","Middle",5).
	distance("Middle","Saint-Petersburg",5).
	distance("Moscow","Middle",5).
	distance("Middle","Moscow",5).
	distance(X,X,0).
	condition([M|[person(C_T,C_S,C_L,C_W,C_P)|[S|[person(P1_T,P1_S,P1_L,P1_W,P1_P)|[person(P2_T,P2_S,P2_L,P2_W,P2_P)|[person(P3_T,P3_S,P3_L,P3_W,P3_P)]]]]]]):-
		distance(C_L,P1_L,D1),distance(C_L,P2_L,D2),distance(C_L,P3_L,D3),D1<D2,D1<D3,P1_W=30000,C_W=10000; % Нельзя сравнивать свободные переменные.
		distance(C_L,P1_L,D1),distance(C_L,P2_L,D2),distance(C_L,P3_L,D3),D2<D1,D2<D3,P2_W=30000,C_W=10000; % Поэтому пытаемся сопоставить ей значение.
		distance(C_L,P1_L,D1),distance(C_L,P2_L,D2),distance(C_L,P3_L,D3),D3<D1,D3<D2,P3_W=30000,C_W=10000.