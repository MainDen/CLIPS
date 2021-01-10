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
	person=person(id,type,sername,live,wages,play)
	id=integer
	type=machinist;stoker;conductor;passenger
	sername=string
	live=string
	wages=integer
	play=winner;looser;other
predicates
% Database
	person(id,type,sername,live,wages,play)
	brigadier(id)
	sername(sername)
	live(live)
	distance(live,live,integer)
	wages(wages)
	play(play)
	type_id(type,id)
	sername_id(sername,id)
	live_id(live,id)
	wages_id(wages,id)
	play_id(play,id)
% Search
	machinist(sername)
clauses
	person(1,passenger,"Ivanoff","Moscow",W1,other):-
		wages(W1).
	person(2,passenger,"Petroff",L2,20000,other):-
		live(L2).
	person(3,passenger,"Sidoroff",L3,W3,other):-
		live(L3),wages(W3).
	person(4,machinist,S4,L4,W4,P4):-
		sername(S4),live(L4),wages(W4),play(P4).
	person(5,conductor,S5,"Middle",W5,P5):-
		sername(S5),wages(W5),play(P5).
	person(6,stoker,S6,L6,W6,looser):-
		sername(S6),live(L6),wages(W6).
	brigadier(4).
	brigadier(5).
	brigadier(6).
	sername("Sidoroff").
	sername("Petroff").
	sername("Ivanoff").
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
	type_id(T,I):-
		person(I,T,S,L,W,P).
	sername_id(S,I):-
		person(I,T,S,L,W,P).
	live_id(L,I):-
		person(I,T,S,L,W,P).
	wages_id(W,I):-
		person(I,T,S,L,W,P).
	play_id(P,I):-
		person(I,T,S,L,W,P).
	machinist(SERNAME):-fail,
		%%% фамилии бригадиров различны
		type_id(machinist,MACH),type_id(conductor,COND),type_id(stoker,STOK),
		sername_id(SER_MACH,MACH),sername_id(SER_COND,COND),sername_id(SER_STOK,STOK),
		SER_MACH<>SER_COND,SER_COND<>SER_STOK,SER_STOK<>SER_MACH,
		%%% пассажир, однофамилец кондуктора, живет в Санкт-Петербурге
		type_id(passenger,PAS_A),sername_id(SER_COND,PAS_A),live_id("Saint-Petersburg",PAS_A),
		%%% тот пассажир, который живет ближе к месту жительства кондуктора, чем другие пассажиры,
		%%% зарабатывает в месяц ровно втрое больше кондуктора
		type_id(passenger,PAS_B1),type_id(passenger,PAS_B2),type_id(passenger,PAS_B3),
		PAS_B1<>PAS_B2,PAS_B2<>PAS_B3,PAS_B3<>PAS_B1,
		live_id(LIVE_B1,PAS_B1),live_id(LIVE_B2,PAS_B2),live_id(LIVE_B3,PAS_B3),live_id(LIVE_COND,COND),
		distance(LIVE_B1,LIVE_COND,DIST_B1),distance(LIVE_B2,LIVE_COND,DIST_B2),distance(LIVE_B3,LIVE_COND,DIST_B3),
		DIST_B1<DIST_B2,DIST_B1<DIST_B3,wages_id(30000,PAS_B1),
		%%% бригадир Сидоров недавно выиграл у кочегара партию на биллиарде
		brigadier(ID_BR),sername_id("Sidoroff",ID_BR),play_id(winner,ID_BR),
		sername_id(SERNAME,MACH),!.