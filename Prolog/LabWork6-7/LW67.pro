domains
	listChar=char*
	motion=string
	listMotion=string*

predicates
	move(listChar,listChar,motion,listMotion)
	move(listChar,listChar,motion,listChar,listChar)
	boat(motion)
	boat(motion,motion)
	countChar(listChar,char,integer)
	countCharStr(string,char,integer)
	addChar(listChar,char,listChar)
	addChar(listChar,char,integer,listChar)
	drawChar(listChar)
	addMotion(listMotion,motion,listMotion)
	addMotion(listMotion,motion,integer,listMotion)
	appendMotion(listMotion,motion,listMotion)
	drawState(listChar,listChar,listMotion,string)
	test

goal
	test.

clauses
	move([],R,M,[]):-!.
	move(L,R,M,ML):-
		boat(MOVE),boat(M,MOVE),
			move(L,R,MOVE,L1,R1),move(L1,R1,MOVE,ML1),addMotion(ML1,MOVE,ML),!.

	move(L,R,M,L1,R1):-
		countCharStr(M,'j',NB),NB>0,countCharStr(M,'[',1),countChar(L,'j',NL),NL>=NB,NL1=NL-NB,countChar(R,'j',NR),NR1=NR+NB,
			countChar(L,'F',LF),countChar(R,'F',RF),
			addChar([],'F',LF,LL),addChar(LL,'j',NL1,L1),addChar([],'F',RF,RR),addChar(RR,'j',NR1,R1),!;
		countCharStr(M,'j',NB),NB>0,countCharStr(M,']',1),countChar(R,'j',NR),NR>=NB,NR1=NR-NB,countChar(L,'j',NL),NL1=NL+NB,
			countChar(L,'F',LF),countChar(R,'F',RF),
			addChar([],'F',LF,LL),addChar(LL,'j',NL1,L1),addChar([],'F',RF,RR),addChar(RR,'j',NR1,R1),!;
		countCharStr(M,'F',NB),NB>0,countCharStr(M,'[',1),countChar(L,'F',NL),NL>=NB,NL1=NL-NB,countChar(R,'F',NR),NR1=NR+NB,
			countChar(L,'j',Lj),countChar(R,'j',Rj),
			addChar([],'F',NL1,LL),addChar(LL,'j',Lj,L1),addChar([],'F',NR1,RR),addChar(RR,'j',Rj,R1),!;
		countCharStr(M,'F',NB),NB>0,countCharStr(M,']',1),countChar(R,'F',NR),NR>=NB,NR1=NR-NB,countChar(L,'F',NL),NL1=NL+NB,
			countChar(L,'j',Lj),countChar(R,'j',Rj),
			addChar([],'F',NL1,LL),addChar(LL,'j',Lj,L1),addChar([],'F',NR1,RR),addChar(RR,'j',Rj,R1),!.

	boat("[jj)").
	boat("(jj]").
	boat("[j.)").
	boat("(.j]").
	boat("[F.)").
	boat("(.F]").

	boat("[..)","(..]"):-!.
	boat("(..]","[..)"):-!.

	boat(M,M):-!,fail.
	boat("[..)","[F.)"):-!,fail.
	boat("[..)","[jj)"):-!,fail.
	boat("[..)","[j.)"):-!,fail.
	boat("(..]","(jj]"):-!,fail.
	boat("(..]","(.j]"):-!,fail.

	boat("[jj)","[j.)"):-!,fail.
	boat("[jj)","[F.)"):-!,fail.
	boat("[jj)","(jj]"):-!,fail.
	boat("(jj]","[jj)"):-!,fail.
	boat("(jj]","(.j]"):-!,fail.
	boat("[j.)","[jj)"):-!,fail.
	boat("[j.)","[F.)"):-!,fail.
	boat("[j.)","(.j]"):-!,fail.
	boat("(.j]","[j.)"):-!,fail.
	boat("(.j]","(jj]"):-!,fail.
	boat("[F.)","[jj)"):-!,fail.
	boat("[F.)","[j.)"):-!,fail.
	boat(M1,M2):-!.

	countChar([],C,0):-!.
	countChar([C|T],C,N):-countChar(T,C,N1),N=N1+1,!.
	countChar([H|T],C,N):-countChar(T,C,N),!.
	countCharStr("",C,0):-!.
	countCharStr(S,C,N):-frontchar(S,C,T),countCharStr(T,C,N1),N=N1+1,!.
	countCharStr(S,C,N):-frontchar(S,C1,T),countCharStr(T,C,N),!.
	addChar(L,C,[C|L]):-!.
	addChar(L,C,0,L):-!.
	addChar(L,C,N,R):-N1=N-1,addChar(L,C,N1,R1),R=[C|R1],!.
	drawChar([]):-nl,!.
	drawChar([H|T]):-write(H," "),drawChar(T),!.

	addMotion(L,M,[M|L]):-!.
	addMotion(L,M,0,L):-!.
	addMotion(L,C,N,R):-N1=N-1,addMotion(L,M,N1,R1),R=[C|R1],!.

	appendMotion([],M,[M]):-!.
	appendMotion([H|T],M,R):-appendMotion(T,M,R1),R=[H|R1],!.

	drawState([],_,_,_):-write("General:\n\tPress 'F' to pay respect!\n"),readchar(F),F='f',test,!.
	drawState([],_,_,_):-write("Press any button."),readchar(_),!.

	drawState(L,R,[M|T],B):-boat(B,B1),B="(..]",move(L,R,M,L1,R1),clearwindow,
		drawChar(L),write(B1,"\n\n\n"),drawChar(R),/*readln(_)*/sleep(40),clearwindow,
		drawChar(L1),write(M,"\n\n\n"),drawChar(R),/*readln(_)*/sleep(40),clearwindow,
		drawChar(L1),write(" ",M,"\n\n\n"),drawChar(R),sleep(20),clearwindow,
		drawChar(L1),write("  ",M,"\n\n\n"),drawChar(R),sleep(20),clearwindow,
		drawChar(L1),write("   ",M,"\n\n\n"),drawChar(R),sleep(20),clearwindow,
		drawChar(L1),write("\n    ",M,"\n\n"),drawChar(R),sleep(20),clearwindow,
		drawChar(L1),write("\n     ",M,"\n\n"),drawChar(R),sleep(20),clearwindow,
		drawChar(L1),write("\n      ",M,"\n\n"),drawChar(R),sleep(20),clearwindow,
		drawChar(L1),write("\n\n       ",M,"\n"),drawChar(R),sleep(20),clearwindow,
		drawChar(L1),write("\n\n        ",M,"\n"),drawChar(R),sleep(20),clearwindow,
		drawChar(L1),write("\n\n         ",M,"\n"),drawChar(R),/*readln(_)*/sleep(40),clearwindow,
		drawChar(L1),write("\n\n         ",B,"\n"),drawChar(R1),
		drawState(L1,R1,T,B1),!.

	drawState(L,R,[M|T],B):-boat(B,B1),B="[..)",move(L,R,M,L1,R1),clearwindow,
		drawChar(L),write("\n\n         ",B1,"\n"),drawChar(R),/*readln(_)*/sleep(40),clearwindow,
		drawChar(L),write("\n\n         ",M,"\n"),drawChar(R1),/*readln(_)*/sleep(40),clearwindow,
		drawChar(L),write("\n\n        ",M,"\n"),drawChar(R1),sleep(20),clearwindow,
		drawChar(L),write("\n\n       ",M,"\n"),drawChar(R1),sleep(20),clearwindow,
		drawChar(L),write("\n      ",M,"\n\n"),drawChar(R1),sleep(20),clearwindow,
		drawChar(L),write("\n     ",M,"\n\n"),drawChar(R1),sleep(20),clearwindow,
		drawChar(L),write("\n    ",M,"\n\n"),drawChar(R1),sleep(20),clearwindow,
		drawChar(L),write("   ",M,"\n\n\n"),drawChar(R1),sleep(20),clearwindow,
		drawChar(L),write("  ",M,"\n\n\n"),drawChar(R1),sleep(20),clearwindow,
		drawChar(L),write(" ",M,"\n\n\n"),drawChar(R1),sleep(20),clearwindow,
		drawChar(L),write(M,"\n\n\n"),drawChar(R1),/*readln(_)*/sleep(40),clearwindow,
		drawChar(L1),write(B,"\n\n\n"),drawChar(R1),
		drawState(L1,R1,T,B1),!.

	test:-clearwindow,
		write("General:\n\tWe need to deliver the soldiers!\n"),readln(_),
		write("General:\n\tHow many soldiers do we have?\n"),
		write("You:\n\tI think about...\n*input number*\n\t..."),readint(I),I>0,!,
		write("General:\n\tNot bad! Let's see it.\n"),sleep(200),
		clearwindow,addChar([],'F',I,L0),addChar(L0,'j',2,L1),move(L1,[],"(..]",ML),drawState(L1,[],ML,"(..]");
		write("General:\n\tHmm... Are you all right?\n\nPress 'Enter' to restart."),readln(S),S="",test.