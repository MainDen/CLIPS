domains
	obj=obj(id,name,sername,gender)
	id=integer
	name=string
	sername=string
	gender=male;female

predicates
	eq(obj,obj)
	noeq(obj,obj)
	edge(obj,obj)

% Зависят от типа объекта
	obj(id,name,sername,gender)
	obj(obj)
	edgeId(id,id)
	id(obj,id)
	name(obj,name)
	sername(obj,sername)
	gender(obj,gender)
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
	isAuntForId(integer,obj)

% Тест
	allAuntForSister
	clr

% goal
%	clr;allAuntForSister.

clauses
	eq(X,Y):-X=Y.
	noeq(X,Y):-not(eq(X,Y)).

% Зависят от типа объекта
	edgeId(I1,I2):-edge(obj(I1,N1,S1,G1),obj(I2,N2,S2,G2)).
	id(O,I):-obj(I,N,S,G),eq(O,obj(I,N,S,G)).
	name(O,N):-obj(I,N,S,G),eq(O,obj(I,N,S,G)).
	sername(O,S):-obj(I,N,S,G),eq(O,obj(I,N,S,G)).
	gender(O,G):-obj(I,N,S,G),eq(O,obj(I,N,S,G)).
	male(O):-obj(I,N,S,male),eq(O,obj(I,N,S,male)).
	female(O):-obj(I,N,S,female),eq(O,obj(I,N,S,female)).
	obj(O):-obj(I,N,S,G),eq(O,obj(I,N,S,G)).

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
	allAuntForSister:-findAuntForSister(Sister,Aunt),write(Aunt," is aunt for ",Sister),nl,fail.
	isAuntForId(Id,Aunt):-id(X,Id),female(Aunt),hasSibOfParent(X,Aunt).
	clr:-clearwindow,fail.

% База объектов
%	(gender = male)
	obj(1,"Norman","Haldeman",male).
	obj(2,"Josephine","Fletcher",male).
	obj(3,"Joshua","Haldeman",male).
	obj(4,"Errol","Musk",male).
	obj(5,"?","Rive",male).
	obj(6,"Elon","Musk",male).
	obj(7,"Kimbal","Musk",male).
	obj(8,"Lyndon","Rive",male).
	obj(9,"Griffin","Musk",male).
	obj(10,"Xavier","Musk",male).
	obj(11,"Kai","Musk",male).
	obj(12,"Damian","Musk",male).
	obj(13,"Saxon","Musk",male).
	obj(14,"Grayson","Musk",male).
%	(gender = female)
	obj(15,"Winnifred","Fletcher",female).
	obj(16,"Maye","Haldeman",female).
	obj(17,"?","Haldeman",female).
	obj(18,"Justine","Wilson",female).
	obj(19,"Christiana","Wyly",female).
	obj(20,"Tosca","Musk",female).
	obj(21,"Isabeau","Musk",female).

	edge(obj(1,N1,S1,G1),obj(3,N2,S2,G2)).	% N.Haldeman -> J.Haldeman
	edge(obj(2,N1,S1,G1),obj(15,N2,S2,G2)).	% J.Fletcher -> W.Fletcher

	edge(obj(3,N1,S1,G1),obj(16,N2,S2,G2)).	%
	edge(obj(15,N1,S1,G1),obj(16,N2,S2,G2)).%
	edge(obj(3,N1,S1,G1),obj(17,N2,S2,G2)).	%
	edge(obj(15,N1,S1,G1),obj(17,N2,S2,G2)).%

	edge(obj(4,N1,S1,G1),obj(6,N2,S2,G2)).	%
	edge(obj(16,N1,S1,G1),obj(6,N2,S2,G2)).	%
	edge(obj(4,N1,S1,G1),obj(7,N2,S2,G2)).	%
	edge(obj(16,N1,S1,G1),obj(7,N2,S2,G2)).	%
	edge(obj(4,N1,S1,G1),obj(20,N2,S2,G2)).	%
	edge(obj(16,N1,S1,G1),obj(20,N2,S2,G2)).%

	edge(obj(5,N1,S1,G1),obj(8,N2,S2,G2)).	%
	edge(obj(17,N1,S1,G1),obj(8,N2,S2,G2)).	%

	edge(obj(6,N1,S1,G1),obj(9,N2,S2,G2)).	%
	edge(obj(18,N1,S1,G1),obj(9,N2,S2,G2)).	%
	edge(obj(6,N1,S1,G1),obj(10,N2,S2,G2)).	%
	edge(obj(18,N1,S1,G1),obj(10,N2,S2,G2)).%
	edge(obj(6,N1,S1,G1),obj(11,N2,S2,G2)).	%
	edge(obj(18,N1,S1,G1),obj(11,N2,S2,G2)).%
	edge(obj(6,N1,S1,G1),obj(12,N2,S2,G2)).	%
	edge(obj(18,N1,S1,G1),obj(12,N2,S2,G2)).%
	edge(obj(6,N1,S1,G1),obj(13,N2,S2,G2)).	%
	edge(obj(18,N1,S1,G1),obj(13,N2,S2,G2)).%

	edge(obj(20,N1,S1,G1),obj(21,N2,S2,G2)).%
	edge(obj(20,N1,S1,G1),obj(14,N2,S2,G2)).%