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
	id=integer
	type=machinist;stoker;conductor;passenger
	surname=string
	live=string
	wages=integer
	play=winner;looser;other

predicates
	person(id,type,surname,live,wages,play)
	surname(surname)
	live(live)
	distance(live,live,integer)
	wages(wages)
	play(play)
	brigadiers(surname,surname,play,play)
	passengers(surname,surname,surname,live,live,live,wages,wages,wages)
	condition1(surname,surname,surname,surname,live,live,live)
	condition2(live,live,live,wages,wages,wages)
	condition3(surname,surname,play,play)
	machinist(surname)
	main

goal
	main.

clauses
	person(1,passenger,"Ivanoff","Moscow",W1,other):-wages(W1).
	person(2,passenger,"Petroff",L2,20000,other):-live(L2).
	person(3,passenger,"Sidoroff",L3,W3,other):-live(L3),wages(W3).
	person(4,machinist,S4,L4,W4,P4):-surname(S4),live(L4),wages(W4),play(P4).
	person(5,conductor,S5,"Middle",W5,P5):-surname(S5),wages(W5),play(P5).
	person(6,stoker,S6,L6,W6,looser):-surname(S6),live(L6),wages(W6).
	surname("Sidoroff").
	surname("Petroff").
	surname("Ivanoff").
	live("Moscow").
	live("Saint-Petersburg").
	live("Middle").
	distance("Saint-Petersburg","Moscow",10).
	distance("Moscow","Saint-Petersburg",10).
	distance("Saint-Petersburg","Middle",5).
	distance("Middle","Saint-Petersburg",5).
	distance("Moscow","Middle",5).
	distance("Middle","Moscow",5).
	distance(X,X,0).
	wages(10000).
	wages(20000).
	wages(30000).
	play(winner).
	play(looser).
	play(other).
	brigadiers(SER_MACH,SER_COND,PLAY_MACH,PLAY_COND):-
		person(4,T4,SER_MACH,L4,W4,PLAY_MACH),
		person(5,T5,SER_COND,L5,W5,PLAY_COND),
		person(6,T6,SER_STOK,L6,W6,PLAY_STOK),
		SER_MACH<>SER_COND,SER_COND<>SER_STOK,SER_STOK<>SER_MACH.
	passengers(SER_P1,SER_P2,SER_P3,LIVE_P1,LIVE_P2,LIVE_P3,WAG_P1,WAG_P2,WAG_P3):-
		person(1,T1,SER_P1,LIVE_P1,WAG_P1,other),
		person(2,T2,SER_P2,LIVE_P2,WAG_P2,other),
		person(3,T3,SER_P3,LIVE_P3,WAG_P3,other).
	condition1(SER_COND,SER_P1,SER_P2,SER_P3,LIVE_P1,LIVE_P2,LIVE_P3):-
		SER_COND=SER_P1,LIVE_P1="Saint-Petersburg";
		SER_COND=SER_P2,LIVE_P2="Saint-Petersburg";
		SER_COND=SER_P3,LIVE_P3="Saint-Petersburg".
	condition2(LIVE_P1,LIVE_P2,LIVE_P3,WAG_P1,WAG_P2,WAG_P3):-
		distance(LIVE_P1,"Middle",DIST_P1),distance(LIVE_P2,"Middle",DIST_P2),distance(LIVE_P3,"Middle",DIST_P3),
		DIST_P1<DIST_P2,DIST_P1<DIST_P3,WAG_P1=30000;
		distance(LIVE_P1,"Middle",DIST_P1),distance(LIVE_P2,"Middle",DIST_P2),distance(LIVE_P3,"Middle",DIST_P3),
		DIST_P2<DIST_P1,DIST_P2<DIST_P3,WAG_P2=30000;
		distance(LIVE_P1,"Middle",DIST_P1),distance(LIVE_P2,"Middle",DIST_P2),distance(LIVE_P3,"Middle",DIST_P3),
		DIST_P3<DIST_P1,DIST_P3<DIST_P2,WAG_P3=30000.
	condition3(SER_MACH,SER_COND,PLAY_MACH,PLAY_COND):-
		SER_MACH="Sidoroff",PLAY_MACH=winner;
		SER_COND="Sidoroff",PLAY_COND=winner.
	machinist(SER_MACH):-
		brigadiers(SER_MACH,SER_COND,PLAY_MACH,PLAY_COND),
		passengers(SER_P1,SER_P2,SER_P3,LIVE_P1,LIVE_P2,LIVE_P3,WAG_P1,WAG_P2,WAG_P3),
		%%% пассажир, однофамилец кондуктора, живет в Санкт-Петербурге
		condition1(SER_COND,SER_P1,SER_P2,SER_P3,LIVE_P1,LIVE_P2,LIVE_P3),
		%%% тот пассажир, который живет ближе к месту жительства кондуктора, чем другие пассажиры,
		%%% зарабатывает в месяц ровно втрое больше кондуктора
		condition2(LIVE_P1,LIVE_P2,LIVE_P3,WAG_P1,WAG_P2,WAG_P3),
		%%% бригадир Сидоров недавно выиграл у кочегара партию на биллиарде
		condition3(SER_MACH,SER_COND,PLAY_MACH,PLAY_COND),!.
	main:-
		machinist(surname),write("Machinist is ",surname,"\n").