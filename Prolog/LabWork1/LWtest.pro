domains
	obj=string

predicates
	eq(obj,obj)
	noeq(obj,obj)
	edge(obj,obj)

% Зависят от типа объекта
	obj(obj)
	name(obj)
	male(obj)
	female(obj)

% Не зависят от типа объекта
	findParent(obj,obj)
	hasParent(obj,obj)
	findChild(obj,obj)
	hasChild(obj,obj)
	findSib(obj,obj)
	hasSib(obj,obj)
	findSpouse(obj,obj)
	hasSpouse(obj,obj)
	findGrandParent(obj,obj)
	hasGrandParent(obj,obj)
	findGrandChild(obj,obj)
	hasGrandChild(obj,obj)
	findSibOfParent(obj,obj)
	hasSibOfParent(obj,obj)
	findAuntForSister(obj,obj)
	hasAuntForSister(obj,obj)

% Тест
	allAuntForSister
	clr

goal
	clr;allAuntForSister;readln(_).

clauses
	eq(X,Y):-X=Y.
	noeq(X,Y):-not(eq(X,Y)).

% Зависят от типа объекта
	name(O):-obj(O).
	obj(O):-male(O1),eq(O,O1);female(O1),eq(O,O1).

% Не зависят от типа объекта
	findParent(C,P):-obj(C1),obj(P1),edge(P1,C1),eq(C,C1),eq(P,P1).
	hasParent(C,P):-findParent(C,P),!.
	findChild(P,C):-obj(P1),obj(C1),edge(P1,C1),eq(C,C1),eq(P,P1).
	hasChild(P,C):-findChild(P,C),!.
	findSib(X1,X2):-hasParent(X1,P),findChild(P,X2),noeq(X1,X2).
	hasSib(X1,X2):-findSib(X1,X2),!.
	findSpouse(X1,X2):-hasChild(X1,C),findParent(C,X2),noeq(X1,X2).
	hasSpouse(X1,X2):-findSpouse(X1,X2),!.
	findGrandParent(C,GP):-findParent(C,P),findParent(P,GP).
	hasGrandParent(C,GP):-findGrandParent(C,GP),!.
	findGrandChild(GP,C):-findChild(GP,P),findChild(P,C).
	hasGrandChild(GP,C):-findGrandChild(GP,C),!.
	findSibOfParent(C,SoP):-findParent(C,P),findSib(P,SoP).
	hasSibOfParent(C,SoP):-findSibOfParent(C,SoP),!.
	findAuntForSister(Sister,Aunt):-female(Sister),hasSib(Sister,_),findSibOfParent(Sister,Aunt),female(Aunt).
	hasAuntForSister(Sister,Aunt):-findAuntForSister(Sister,Aunt),!.
	allAuntForSister:-findAuntForSister(Sister,Aunt),write(Aunt," is aunt for ",Sister," which has sib."),nl,fail.
	clr:-clearwindow,fail.

% База объектов
%	(gender = male)
	male("David").
	male("Fill").
	male("Henry").
	male("Kevin").
	male("Peter").
	male("Tom").
%	(gender = female)
	female("Alice").
	female("Banny").
	female("Caren").
	female("Julia").
	female("Laura").
	female("Marry").
	female("Nancy").
	female("Sia").

% База связей объектов
	edge("David","Fill").
	edge("David","Henry").
	edge("David","Banny").
	edge("David","Caren").
	edge("Alice","Fill").
	edge("Alice","Henry").
	edge("Alice","Banny").
	edge("Alice","Caren").
	edge("Fill","Tom").
	edge("Fill","Sia").
	edge("Henry","Nancy").
	edge("Banny","Kevin").
	edge("Banny","Peter").
	edge("Banny","Marry").
	edge("Caren","Laura").
	edge("Caren","Julia").