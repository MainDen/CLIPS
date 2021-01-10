% Определить отношения и найти родственников, удовлетворяющих ему.
% Тётя, Брат
domains
	name=string
predicates
	%%%%%% База знаний %%%%%%
	male(name)              % Задаёт мужчину
	female(name)            % Задаёт женщину
	parent_child(name,name) % Задаёт отношение родитель-ребёнок
	%%%%%%  Отношения  %%%%%%
	name(name)              % Проверяет имя
	p_c(name,name)          % Проверяет отношение родитель-ребёнок
	x_aunt(name,name)       % Проверяет отншение X-тётя
	x_brother(name,name)    % Проверяет отншение X-брат
	%%%%%%%%%% Run %%%%%%%%%%
	print_aunt              %
	print_brother           %
	run                     %
clauses%%%%%%% Run %%%%%%%%%%
	print_aunt:-clearwindow,write("Aunts:\n"),fail;x_aunt(X,Aunt),write(Aunt," is aunt for ",X),nl,fail.
	print_brother:-clearwindow,write("Brothers:\n"),fail;x_brother(X,Brother),write(Brother," is bro for ",X),nl,fail.
	run:-print_aunt;readln(_),fail;print_brother;readln(_).
	%%%%%%  Отношения  %%%%%%
	name(N):-male(N);female(N).
	p_c(P,C):-name(P),name(C),parent_child(P,C),!.
	x_aunt(X,Aunt):-name(X),female(Aunt),p_c(P,X),p_c(GP,P),p_c(GP,Aunt),Aunt<>P.
	x_brother(X,Brother):-name(X),male(Brother),X<>Brother,p_c(P,X),p_c(P,Brother).
	%%%%%% База знаний %%%%%%
	male("David").
	male("Fill").
	male("Henry").
	male("Kevin").
	male("Peter").
	male("Tom").
	female("Alice").
	female("Banny").
	female("Caren").
	female("Julia").
	female("Laura").
	female("Marry").
	female("Nancy").
	female("Sia").
	parent_child("David","Fill").
	parent_child("David","Fill").
	parent_child("David","Henry").
	parent_child("David","Banny").
	parent_child("David","Caren").
	parent_child("Alice","Fill").
	parent_child("Alice","Henry").
	parent_child("Alice","Banny").
	parent_child("Alice","Caren").
	parent_child("Fill","Tom").
	parent_child("Fill","Sia").
	parent_child("Henry","Nancy").
	parent_child("Banny","Kevin").
	parent_child("Banny","Peter").
	parent_child("Banny","Marry").
	parent_child("Caren","Laura").
	parent_child("Caren","Julia").