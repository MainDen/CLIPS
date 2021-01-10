%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Разработать базу знаний, содержащую информацию о студентах.                 %   vvvvvvvvvvvvvvvvvvvvv   %
% Предусмотреть ответы на следующие вопросы:                                  % vV*********************Vv %
% • Сколько студентов из группы живут в общежитии?                            %**  vvvVVVVv   vVVVVvvv  **%
% • Сколько студентов не получают стипендии (получили “тройки” на экзамене)?  % vVVVVVVVVVVv vVVVVVVVVVVv %
% • В какой из групп самая высокая успеваемость?                              %  *V     *VVVvVVV*     V*  %
% • Есть ли группа, в которой стипендию получают больше половины студентов?   %          VVVVVVV          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          *VVVVV*          %
% База знаний:                                                                %           VVVVV           %
% Студент:                                                                    %           *VVV*           %
% - Номер (студенческого билета)                                              %            VVV            %
% - Группа                                                                    %            *V*            %
% - Имя                                                                       %             V             %
% - Список предметов                                                          %                           %
% - Общежитие                                                                 %   T    E    S    L    A   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Запросы:                                % Описание:                                                     %
% Группа(Номер)                           % Узнать группу студента                                        %
% Имя(Номер)                              % Узнать имя студента                                           %
% Успеваемость(Номер)                     % Узнать успеваемость студента                                  %
% Стипендия(Номер)                        % Узнать есть ли стипендия у студента                           %
% Общежитие(Номер)                        % Узнать есть ли общежитие у студента                           %
% Студенты()                              % Выбрать всех студентов                                        %
% Студенты(Операция,Студенты,Студенты)    % Выбрать результат операции над двумя списками студентов       %
% Количетво(Студенты)                     % Узнать длину списка студентов                                 %
% Студенты(Группа)                        % Выбрать список студентов группы                               %
% Группы(Студенты)                        % Выбрать список групп студентов                                %
% СтудентыСОбщежитием(Студенты)           % Выбрать студентов с общежитием                                %
% СтудентыСоСтипендией(Студенты)          % Выбрать студентов со стипендией                               %
% СредняяУспеваемость(Студенты)           % Узнать среднюю успеваемость студентов                         %
% НаибольшаяУспеваемостьГруппа(Студенты)  % Узнать группу с наивысшей успеваемостью                       %
% СтипендияБольшеПоловиныГруппа(Студенты) % Выбрать группу больше половины студенов которой со стипендией %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
include "Students.pro"
domains
	ilist=integer*
	slist=string*

predicates
% Integer
	eq_i(integer,integer)
	noeq_i(integer,integer)
	contains_i(ilist,integer)
% String
	eq_s(string,string)
	noeq_s(string,string)
	contains_s(slist,string)
% Student
	eq(student,student)
	noeq(student,student)
	exist(student)
	contains(students,student)
	student_id(student,integer)
	group_id(string,integer)
	name_id(string,integer)
	academic_performance(disciplines,real)
	academic_performance(disciplines,integer,real,real)
	academic_performance_id(real,integer)
	ap_id(real,integer)
	stipend(integer)
	stipend(disciplines,integer)
	dormitory_id(accept,integer)
% Students
	students(ilist)

clauses
% Integer
	eq_i(X,Y):-
		X=Y.
	noeq_i(X,Y):-
		not(eq_i(X,Y)).
	contains_i([],X):-
		!,fail.
	contains_i([H|T],X):-
		H=X,!;
		contains_i(T,X).
% String
	eq_s(X,Y):-
		X=Y.
	noeq_s(X,Y):-
		not(eq_s(X,Y)).
	contains_s([],X):-
		!,fail.
	contains_s([H|T],X):-
		H=X,!;
		contains_s(T,X).
% Student
	eq(X,Y):-
		X=Y.
	noeq(X,Y):-
		not(eq(X,Y)).
	exist(student(ID,GROUP,NAME,DISCIPLINES,ACCEPT)):-
		student(ID,GROUP,NAME,DISCIPLINES,ACCEPT).
	contains([],X):-
		!,fail.
	contains([H|T],X):-
		H=X,!;
		contains(T,X).
	student_id(S,ID):-
		exist(student(ID,GROUP,NAME,DISCIPLINES,ACCEPT)),
		eq(student(ID,GROUP,NAME,DISCIPLINES,ACCEPT),S),!.
	group_id(GROUP,ID):-
		exist(student(ID,GROUP,NAME,DISCIPLINES,ACCEPT)).
	name_id(NAME,ID):-
		exist(student(ID,GROUP,NAME,DISCIPLINES,ACCEPT)).
	academic_performance(DISCIPLINES,AP):-
		academic_performance(DISCIPLINES,0,0,AP).
	academic_performance([],0,TEMP,AP):-
		!,fail.
	academic_performance([],COUNT,TEMP,AP):-
		AP=TEMP/COUNT,!.
	academic_performance([discipline(TITLE,MARK)|T],COUNT,TEMP,AP):-
		COUNT1=COUNT+1,TEMP1=TEMP+MARK,academic_performance(T,COUNT1,TEMP1,AP).
	academic_performance_id(AP,ID):-
		exist(student(ID,GROUP,NAME,DISCIPLINES,ACCEPT)),
		academic_performance(DISCIPLINES,AP).
	ap_id(AP,ID):-
		academic_performance_id(AP,ID).
	stipend(ID):-
		exist(student(ID,GROUP,NAME,DISCIPLINES,ACCEPT)),
		stipend(DISCIPLINES,0).
	stipend([],0):-!,fail.
	stipend([],COUNT):-!.
	stipend([discipline(TITLE,MARK)|T],COUNT):-
		MARK>3,COUNT1=COUNT+1,stipend(T,COUNT1).
	dormitory_id(ACCEPT,ID):-
		exist(student(ID,GROUP,NAME,DISCIPLINES,ACCEPT)).
	students(I):-
		exist(S).