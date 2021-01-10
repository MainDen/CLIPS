constants
	dFPName="PATIENTS.DB"
	dFDSName="DISSYMPT.DB"
	dFDTName="DISTREAT.DB"
domains
	file=dFP;dFDS;dFDT
	strList=string*
	turn=string
	id=integer
	name=string
	sername=string
	age=integer
	symptom=string
	symptoms=symptom*
	disease=string
	diseases=disease*
	treatment=string
	treatments=treatment*
	patient=patient(string,string,integer,strList)			%patient(name,sername,age,symptoms)
	patients=patient*
	disease_symptoms=disease_symptoms(string,strList)		%disease_symptoms(disease,symptoms)
	diseases_symptoms=disease_symptoms*
	disease_treatments=disease_treatments(string,strList)	%disease_treatments(disease,treatments)
	diseases_treatments=disease_treatments*
database - patients_db
	patient(string,string,integer,strList)					%patient(name,sername,age,symptoms)
database - diseases_symptoms_db
	disease_symptoms(string,strList)						%disease_symptoms(disease,symptoms)
database - diseases_treatments_db
	disease_treatments(string,strList)						%disease_treatments(disease,treatments)
predicates
	save_db(string,symbol)
	load_db(string,symbol)
	inputStrList(string,integer,strList)
	outputStrList(string,integer,strList)
	intersectionStrList(strList,strList,strList)
	cStrList(strList,integer)
	drawMainMenu
	mainMenu
	mainMenu(char)
	drawDBMenu
	dBMenu
	dBMenu(char)
% Database 1
	drawDB1
	drawDB1(integer,integer,string)
	drawDB1(char,integer,integer,string)
	drawDB1Head(integer,string)
	drawDB1List(integer,patients)
	eDB1(patient)
	lDB1(patients)
	cDB1(patients,integer)
	nDB1(patients,integer,integer,patients)
	nameIsDB1(patients,string,patients)
	sernameIsDB1(patients,string,patients)
	ageIsDB1(patients,integer,patients)
	ageInDB1(patients,integer,integer,patients)
	symptomsDraw(patients)
% Database 2
	drawDB2
	drawDB2(integer,integer,string)
	drawDB2(char,integer,integer,string)
	drawDB2Head(integer,string)
	drawDB2List(integer,diseases_symptoms)
	eDB2(disease_symptoms)
	lDB2(diseases_symptoms)
	cDB2(diseases_symptoms,integer)
	nDB2(diseases_symptoms,integer,integer,diseases_symptoms)
% Database 3
	drawDB3
	drawDB3(integer,integer,string)
	drawDB3(char,integer,integer,string)
	drawDB3Head(integer,string)
	drawDB3List(integer,diseases_treatments)
	eDB3(disease_treatments)
	lDB3(diseases_treatments)
	cDB3(diseases_treatments,integer)
	nDB3(diseases_treatments,integer,integer,diseases_treatments)
	titleIsDB3(diseases_treatments,string,diseases_treatments)
	treatmentsDraw(diseases_treatments)
% Request menu
	requestMenu(char,string,string,integer,integer,integer,string)
	symptomsDisease(strList,diseases_symptoms,real,string)
	patientTreatmentsDraw(patients)
%%%%%
	accept
	accept(char)
	turn(string,string)
	run
goal run.
clauses
	save_db(FILENAME,patients_db):-openwrite(dFP,FILENAME),save(dFP,patients_db),closefile(dFP),
		clearwindow,write("Patients database successfully saved."),readchar(_),!;
		clearwindow,write("Patients database unable to save."),readchar(_),!.
	save_db(FILENAME,diseases_symptoms_db):-openwrite(dFDS,FILENAME),save(dFDS,diseases_symptoms_db),closefile(dFDS),
		clearwindow,write("Diseases-Symptoms database successfully saved."),readchar(_),!;
		clearwindow,write("Diseases-Symptoms database unable to save."),readchar(_),!.
	save_db(FILENAME,diseases_treatments_db):-openwrite(dFDT,FILENAME),save(dFDT,diseases_treatments_db),closefile(dFDT),
		clearwindow,write("Diseases-Treatments database successfully saved."),readchar(_),!;
		clearwindow,write("Diseases-Treatments database unable to save."),readchar(_),!.
	load_db(FILENAME,patients_db):-existfile(FILENAME),openread(dFP,FILENAME),consult(dFP,patients_db),closefile(dFP),
		clearwindow,write("Patients database successfully loaded."),readchar(_),!;
		clearwindow,write("Patients database not found or damaged."),readchar(_),!.
	load_db(FILENAME,diseases_symptoms_db):-existfile(FILENAME),openread(dFDS,FILENAME),consult(dFDS,diseases_symptoms_db),closefile(dFDS),
		clearwindow,write("Diseases-Symptoms database successfully loaded."),readchar(_),!;
		clearwindow,write("Diseases-Symptoms database not found or damaged."),readchar(_),!.
	load_db(FILENAME,diseases_treatments_db):-existfile(FILENAME),openread(dFDT,FILENAME),consult(dFDT,diseases_treatments_db),closefile(dFDT),
		clearwindow,write("Diseases-Treatments database successfully loaded."),readchar(_),!;
		clearwindow,write("Diseases-Treatments database not found or damaged."),readchar(_),!.
	inputStrList(F,N,R):-writef(F,N),readln(S),S<>"",N1=N+1,inputStrList(F,N1,R1),R=[S|R1],!;R=[],!.
	outputStrList(_,_,[]):-write("not found\n"),!.
	outputStrList(F,N,[H]):-writef(F,N,H),!.
	outputStrList(F,N,[H|T]):-writef(F,N,H),N1=N+1,outputStrList(F,N1,T),!.
	intersectionStrList([],_,[]):-!.
	intersectionStrList(_,[],[]):-!.
	intersectionStrList([H],[H],[H]):-!.
	intersectionStrList([H1],[H2|T],R):-
		H1=H2,R=[H1],!;
		intersectionStrList([H1],T,R).
	intersectionStrList([H1|T],[H2],R):-
		H1=H2,R=[H1],!;
		intersectionStrList(T,[H2],R).
	intersectionStrList([H1|T1],[H2|T2],R):-
		H1=H2,intersectionStrList(T1,T2,R1),R=[H1|R1],!;
		intersectionStrList([H1],T2,[]),intersectionStrList(T1,[H2],[]),intersectionStrList(T1,T2,R),!;
		intersectionStrList([H1],T2,[H1]),intersectionStrList(T1,[H2],[]),intersectionStrList(T1,T2,R1),R=[H1|R1],!;
		intersectionStrList([H1],T2,[]),intersectionStrList(T1,[H2],[H2]),intersectionStrList(T1,T2,R2),R=[H2|R2],!.
	cStrList([],0):-!.
	cStrList([H|T],R):-
		cStrList(T,R1),R=R1+1,!.
	drawMainMenu:-clearwindow,
		write("DATABASES(1)  REQUEST(2)  CONNECT-ALL(3)  EXIT(q)\n"),!.
	mainMenu:-drawMainMenu,readchar(C),mainMenu(C),!.
	mainMenu('\27'):-!.
	mainMenu('q'):-
		clearwindow,write("Are you sure? [y/n]"),accept,
		clearwindow,write("Made by MainDen"),sleep(100),clearwindow,!;
		mainMenu,!.
	mainMenu('3'):-
		clearwindow,write("All connected databases will be lost.\n"),
		write("Continue? [y/n]"),accept,
			load_db(dFPName,patients_db),
			load_db(dFDSName,diseases_symptoms_db),
			load_db(dFDSName,diseases_treatments_db),
			mainMenu,!;mainMenu,!.
	mainMenu('2'):-
		requestMenu('p',"","",0,0,999,""),!.
	mainMenu('1'):-
		dBMenu,!.
	mainMenu(_):-mainMenu,!.
	drawDBMenu:-clearwindow,
		write("PATIENTS(1)  SYMPTOMS(2)   TREATMENTS(3)  BACK(q)\n"),!.
	dBMenu:-drawDBMenu,readchar(C),dBMenu(C),!.
	dBMenu('\27'):-mainMenu,!.
	dBMenu('q'):-mainMenu,!.
	dBMenu('1'):-drawDB1,!.
	dBMenu('2'):-drawDB2,!.
	dBMenu('3'):-drawDB3,!.
	dBMenu(_):-dBMenu,!.
%%% Database 1
	drawDB1:-drawDB1('\75',0,8,"on"),!.
	drawDB1('\27',_,_,_):-dBMenu,!.
	drawDB1('q',_,_,_):-dBMenu,!.
	drawDB1('p',START,COUNT,SAFE):-drawDB1(START,COUNT,SAFE),!.
	drawDB1('0',START,COUNT,SAFE):-turn(SAFE,SAFENEW),drawDB1(START,COUNT,SAFENEW),!.
	drawDB1('\75',_,COUNT,SAFE):-
		drawDB1(0,COUNT,SAFE),!.
	drawDB1('\77',_,COUNT,SAFE):-
		lDB1(LISTALL),cDB1(LISTALL,COUNTL),COUNTL1=COUNTL-1,COUNTL1>=0,drawDB1(COUNTL1,COUNT,SAFE),!;
		drawDB1(0,COUNT,SAFE),!.
	drawDB1('\72',START,COUNT,SAFE):-
		START>0,START1=START-1,drawDB1(START1,COUNT,SAFE),!;
		drawDB1(0,COUNT,SAFE),!.
	drawDB1('\80',START,COUNT,SAFE):-
		lDB1(LISTALL),cDB1(LISTALL,COUNTL),
		COUNTL>START+1,START1=START+1,drawDB1(START1,COUNT,SAFE),!;
		lDB1(LISTALL),cDB1(LISTALL,COUNTL),COUNTL1=COUNTL-1,COUNTL1>=0,drawDB1(COUNTL1,COUNT,SAFE),!;
		drawDB1(0,COUNT,SAFE),!.
	drawDB1('1',START,COUNT,SAFE):-clearwindow,
		lDB1(L),cDB1(L,ID),
		writef("Input new data for %d patient.\n",ID),
		write("Input name: "),readln(NAME),
		write("Input sername: "),readln(SERNAME),
		write("Input age: "),readint(AGE),
		write("Input symptoms:\n"),inputStrList("Symptom[%d]:",0,SYMPTOMS),
		assert(patient(NAME,SERNAME,AGE,SYMPTOMS),patients_db),
		clearwindow,
		writef("%5.5|%16.16|%16.16|%3.3|%10.10\n","ID","NAME","SERNAME","AGE","SYMPTOMS"),
		drawDB1List(ID,[patient(NAME,SERNAME,AGE,SYMPTOMS)]),
		write("Successfully appended.\n"),
		readchar(_),drawDB1('p',START,COUNT,SAFE),!;
		write("Incorrect data entered. Try again? [y/n]"),accept,drawDB1('1',START,COUNT,SAFE),!;
		drawDB1('p',START,COUNT,SAFE),!.
	drawDB1('2',START,COUNT,SAFE):-clearwindow,
		lDB1(L),nDB1(L,START,1,[patient(NAME0,SERNAME0,AGE0,SYMPTOMS0)]),
		writef("Input new data for %d patient.\n",START),
		write("Input name: "),readln(NAME),
		write("Input sername: "),readln(SERNAME),
		write("Input age: "),readint(AGE),
		write("Input symptoms:\n"),inputStrList("Symptom[%d]:",0,SYMPTOMS),
		clearwindow,
		writef("%5.5|%16.16|%16.16|%3.3|%10.10\n","ID","NAME","SERNAME","AGE","SYMPTOMS"),
		drawDB1List(START,[patient(NAME0,SERNAME0,AGE0,SYMPTOMS0)]),drawDB1List(START,[patient(NAME,SERNAME,AGE,SYMPTOMS)]),
		write("Confirm the changes? [y/n]\n"),accept,
		retract(patient(NAME0,SERNAME0,AGE0,SYMPTOMS0),patients_db),
		assert(patient(NAME,SERNAME,AGE,SYMPTOMS),patients_db),
		write("Successfully changed.\n"),
		readchar(_),drawDB1('p',START,COUNT,SAFE),!;
		write("Error. Try again? [y/n]"),accept,drawDB1('2',START,COUNT,SAFE),!;
		drawDB1('p',START,COUNT,SAFE),!.
	drawDB1('3',START,COUNT,SAFE):-clearwindow,
		SAFE="on",lDB1(L),cDB1(L,C),START<C,write("Delete current record? [y/n]\n"),accept,
		nDB1(L,START,1,[patient(NAME0,SERNAME0,AGE0,SYMPTOMS0)]),
		retract(patient(NAME0,SERNAME0,AGE0,SYMPTOMS0),patients_db),
		drawDB1('\72',START,COUNT,SAFE),!;
		SAFE="off",lDB1(L),cDB1(L,C),START<C,
		nDB1(L,START,1,[patient(NAME0,SERNAME0,AGE0,SYMPTOMS0)]),
		retract(patient(NAME0,SERNAME0,AGE0,SYMPTOMS0),patients_db),
		drawDB1('\72',START,COUNT,SAFE),!;
		drawDB1('p',START,COUNT,SAFE),!.
	drawDB1('4',START,COUNT,SAFE):-clearwindow,
		lDB1(L),cDB1(L,C),START<C,
		nDB1(L,START,1,[patient(NAME0,SERNAME0,AGE0,SYMPTOMS0)]),
		writef("%5.5|%16.16|%16.16|%3.3|%10.10\n","ID","NAME","SERNAME","AGE","SYMPTOMS"),
		drawDB1List(START,[patient(NAME0,SERNAME0,AGE0,SYMPTOMS0)]),
		write("Name: ",NAME0),nl,
		write("Serame: ",SERNAME0),nl,
		write("Age: ",AGE0),nl,
		write("Symptoms:\n"),outputStrList("Symptom[%d]:%\n",0,SYMPTOMS0),
		readchar(_),drawDB1('p',START,COUNT,SAFE),!;
		drawDB1('p',START,COUNT,SAFE),!.
	drawDB1('5',START,COUNT,SAFE):-
		clearwindow,write("Save database? [y/n]\n"),accept,
		save_db(dFPName,patients_db),drawDB1('p',START,COUNT,SAFE),!;
		drawDB1('p',START,COUNT,SAFE),!.
	drawDB1('6',START,COUNT,SAFE):-
		clearwindow,write("Load database? [y/n]\n"),accept,
		retractall(_,patients_db),
		load_db(dFPName,patients_db),drawDB1('\75',0,COUNT,SAFE),!;
		drawDB1('p',START,COUNT,SAFE),!.
	drawDB1('7',START,COUNT,SAFE):-
		clearwindow,write("Reset database? [y/n]\n"),accept,
		retractall(_,patients_db),
		clearwindow,write("Database was reset.\n"),
		readchar(_),drawDB1('\75',0,COUNT,SAFE),!;
		drawDB1('p',START,COUNT,SAFE),!.
	drawDB1(_,START,COUNT,SAFE):-drawDB1(START,COUNT,SAFE),!.
	drawDB1(START,COUNT,SAFE):-
		START>0,lDB1(LISTALL),nDB1(LISTALL,START,COUNT,LISTLOCAL),cDB1(LISTALL,COUNT1),COUNT1>START+COUNT,clearwindow,drawDB1Head(START,SAFE),write("...\n"),drawDB1List(START,LISTLOCAL),write("...\n"),readchar(C),drawDB1(C,START,COUNT,SAFE),!;
		START>0,lDB1(LISTALL),nDB1(LISTALL,START,COUNT,LISTLOCAL),cDB1(LISTALL,COUNT1),clearwindow,drawDB1Head(START,SAFE),write("...\n"),drawDB1List(START,LISTLOCAL),readchar(C),drawDB1(C,START,COUNT,SAFE),!;
		lDB1(LISTALL),nDB1(LISTALL,START,COUNT,LISTLOCAL),cDB1(LISTALL,COUNT1),COUNT1>START+COUNT,clearwindow,drawDB1Head(START,SAFE),nl,drawDB1List(START,LISTLOCAL),write("...\n"),readchar(C),drawDB1(C,START,COUNT,SAFE),!;
		lDB1(LISTALL),nDB1(LISTALL,START,COUNT,LISTLOCAL),clearwindow,drawDB1Head(START,SAFE),nl,drawDB1List(START,LISTLOCAL),readchar(C),drawDB1(C,START,COUNT,SAFE),!.
	drawDB1Head(CURRENT,SAFE):-
		writef("APPEND(1)  EDIT(2)  DELETE(3)  BROWSE(4)  SAFE MODE(0):%2.3s\nSAVE DB(5)  LOAD DB(6)  RESET DB(7)\n\tDatabase: Patients | Current ID: %d\n",SAFE,CURRENT),
		writef("%5.5|%16.16|%16.16|%3.3|%10.10\n","ID","NAME","SERNAME","AGE","SYMPTOMS"),!.
	drawDB1List(_,[]):-write("NO ELEMENTS\n"),!.
	drawDB1List(ID,[patient(NAME,SERNAME,AGE,SYMPTOMS)]):-
		SYMPTOMS=[],writef("%5.5|%16.16|%16.16|%3.3|%10.10\n",ID,NAME,SERNAME,AGE,"not found"),!;
		SYMPTOMS=[H],str_len(H,L),L<=10,writef("%5.5|%16.16|%16.16|%3.3|%10.10\n",ID,NAME,SERNAME,AGE,H),!;
		SYMPTOMS=[H],writef("%5.5|%16.16|%16.16|%3.3|%7.7...\n",ID,NAME,SERNAME,AGE,H),!;
		writef("%5.5|%16.16|%16.16|%3.3|%10.10\n",ID,NAME,SERNAME,AGE,"(...)"),!.
	drawDB1List(ID,[H|T]):-
		drawDB1List(ID,[H]),IDN=ID+1,drawDB1List(IDN,T),!.
	eDB1(P):-patient(NAME,SERNAME,AGE,SYMPTOMS),P=patient(NAME,SERNAME,AGE,SYMPTOMS).
	lDB1(R):-
		findall(P,eDB1(P),R),!;
		R=[],!.
	cDB1([],0):-!.
	cDB1([H|T],R):-cDB1(T,R1),R=R1+1,!.
	nDB1(_,_,0,[]):-!.
	nDB1([],_,_,[]):-!.
	nDB1([H|T],0,COUNT,R):-COUNT1=COUNT-1,nDB1(T,0,COUNT1,R1),R=[H|R1],!.
	nDB1([H|T],START,COUNT,R):-START1=START-1,nDB1(T,START1,COUNT,R),!.
	nameIsDB1([],_,[]):-!.
	nameIsDB1([H],NAME0,R):-
		H=patient(NAME,SERNAME,AGE,SYMPTOMS),NAME=NAME0,
		R=[H],!;
		R=[],!.
	nameIsDB1([H|T],NAME0,R):-
		H=patient(NAME,SERNAME,AGE,SYMPTOMS),NAME=NAME0,
		nameIsDB1(T,NAME0,R1),R=[H|R1],!;
		nameIsDB1(T,NAME0,R),!.
	sernameIsDB1([],_,[]):-!.
	sernameIsDB1([H],SERNAME0,R):-
		H=patient(NAME,SERNAME,AGE,SYMPTOMS),SERNAME=SERNAME0,
		R=[H],!;
		R=[],!.
	sernameIsDB1([H|T],SERNAME0,R):-
		H=patient(NAME,SERNAME,AGE,SYMPTOMS),SERNAME=SERNAME0,
		sernameIsDB1(T,SERNAME0,R1),R=[H|R1],!;
		sernameIsDB1(T,SERNAME0,R),!.
	ageIsDB1([],_,[]):-!.
	ageIsDB1([H],AGE0,R):-
		H=patient(NAME,SERNAME,AGE,SYMPTOMS),AGE=AGE0,
		R=[H],!;
		R=[],!.
	ageIsDB1([H|T],AGE0,R):-
		H=patient(NAME,SERNAME,AGE,SYMPTOMS),AGE=AGE0,
		ageIsDB1(T,AGE0,R1),R=[H|R1],!;
		ageIsDB1(T,AGE0,R),!.
	ageInDB1([],_,_,[]):-!.
	ageInDB1([H],AGE0,AGEN,R):-
		H=patient(NAME,SERNAME,AGE,SYMPTOMS),AGE>=AGE0,AGE<=AGEN,
		R=[H],!;
		R=[],!.
	ageInDB1([H|T],AGE0,AGEN,R):-
		H=patient(NAME,SERNAME,AGE,SYMPTOMS),AGE>=AGE0,AGE<=AGEN,
		ageInDB1(T,AGE0,AGEN,R1),R=[H|R1],!;
		ageInDB1(T,AGE0,AGEN,R),!.
	symptomsDraw([]):-!.
	symptomsDraw([H]):-
		H=patient(NAME,SERNAME,AGE,SYMPTOMS),
		outputStrList("Symptom[%]:%\n",0,SYMPTOMS),!.
	symptomsDraw([H|T]):-
		H=patient(NAME,SERNAME,AGE,SYMPTOMS),
		outputStrList("Symptom[%]:%\n",0,SYMPTOMS),!.
%%% Database 2
	drawDB2:-drawDB2('\75',0,8,"on"),!.
	drawDB2('\27',_,_,_):-dBMenu,!.
	drawDB2('q',_,_,_):-dBMenu,!.
	drawDB2('p',START,COUNT,SAFE):-drawDB2(START,COUNT,SAFE),!.
	drawDB2('0',START,COUNT,SAFE):-turn(SAFE,SAFENEW),drawDB2(START,COUNT,SAFENEW),!.
	drawDB2('\75',_,COUNT,SAFE):-
		drawDB2(0,COUNT,SAFE),!.
	drawDB2('\77',_,COUNT,SAFE):-
		lDB2(LISTALL),cDB2(LISTALL,COUNTL),COUNTL1=COUNTL-1,COUNTL1>=0,drawDB2(COUNTL1,COUNT,SAFE),!;
		drawDB2(0,COUNT,SAFE),!.
	drawDB2('\72',START,COUNT,SAFE):-
		START>0,START1=START-1,drawDB2(START1,COUNT,SAFE),!;
		drawDB2(0,COUNT,SAFE),!.
	drawDB2('\80',START,COUNT,SAFE):-
		lDB2(LISTALL),cDB2(LISTALL,COUNTL),
		COUNTL>START+1,START1=START+1,drawDB2(START1,COUNT,SAFE),!;
		lDB2(LISTALL),cDB2(LISTALL,COUNTL),COUNTL1=COUNTL-1,COUNTL1>=0,drawDB2(COUNTL1,COUNT,SAFE),!;
		drawDB2(0,COUNT,SAFE),!.
	drawDB2('1',START,COUNT,SAFE):-clearwindow,
		lDB2(L),cDB2(L,ID),
		writef("Input new data for %d disease.\n",ID),
		write("Input title: "),readln(TITLE),
		write("Input symptoms:\n"),inputStrList("Symptom[%d]:",0,SYMPTOMS),
		assert(disease_symptoms(TITLE,SYMPTOMS),diseases_symptoms_db),
		clearwindow,
		writef("%5.5|%16.16|%10.10\n","ID","TITLE","SYMPTOMS"),
		drawDB2List(ID,[disease_symptoms(TITLE,SYMPTOMS)]),
		write("Successfully appended.\n"),
		readchar(_),drawDB2('p',START,COUNT,SAFE),!;
		write("Incorrect data entered. Try again? [y/n]"),accept,drawDB2('1',START,COUNT,SAFE),!;
		drawDB2('p',START,COUNT,SAFE),!.
	drawDB2('2',START,COUNT,SAFE):-clearwindow,
		lDB2(L),nDB2(L,START,1,[disease_symptoms(TITLE0,SYMPTOMS0)]),
		writef("Input new data for %d disease.\n",START),
		write("Input title: "),readln(TITLE),
		write("Input symptoms:\n"),inputStrList("Symptom[%d]:",0,SYMPTOMS),
		clearwindow,
		writef("%5.5|%16.16|%10.10\n","ID","TITLE","SYMPTOMS"),
		drawDB2List(START,[disease_symptoms(TITLE0,SYMPTOMS0)]),drawDB2List(START,[disease_symptoms(TITLE,SYMPTOMS)]),
		write("Confirm the changes? [y/n]\n"),accept,
		retract(disease_symptoms(TITLE0,SYMPTOMS0),diseases_symptoms_db),
		assert(disease_symptoms(TITLE,SYMPTOMS),diseases_symptoms_db),
		write("Successfully changed.\n"),
		readchar(_),drawDB2('p',START,COUNT,SAFE),!;
		write("Error. Try again? [y/n]"),accept,drawDB2('2',START,COUNT,SAFE),!;
		drawDB2('p',START,COUNT,SAFE),!.
	drawDB2('3',START,COUNT,SAFE):-clearwindow,
		SAFE="on",lDB2(L),cDB2(L,C),START<C,write("Delete current record? [y/n]\n"),accept,
		nDB2(L,START,1,[disease_symptoms(TITLE0,SYMPTOMS0)]),
		retract(disease_symptoms(TITLE0,SYMPTOMS0),diseases_symptoms_db),
		drawDB2('\72',START,COUNT,SAFE),!;
		SAFE="off",lDB2(L),cDB2(L,C),START<C,
		nDB2(L,START,1,[disease_symptoms(TITLE0,SYMPTOMS0)]),
		retract(disease_symptoms(TITLE0,SYMPTOMS0),diseases_symptoms_db),
		drawDB2('\72',START,COUNT,SAFE),!;
		drawDB2('p',START,COUNT,SAFE),!.
	drawDB2('4',START,COUNT,SAFE):-clearwindow,
		lDB2(L),cDB2(L,C),START<C,
		nDB2(L,START,1,[disease_symptoms(TITLE0,SYMPTOMS0)]),
		writef("%5.5|%16.16|%10.10\n","ID","TITLE","SYMPTOMS"),
		drawDB2List(START,[disease_symptoms(TITLE0,SYMPTOMS0)]),
		write("Title: ",TITLE0),nl,
		write("Symptoms:\n"),outputStrList("Symptom[%d]:%\n",0,SYMPTOMS0),
		readchar(_),drawDB2('p',START,COUNT,SAFE),!;
		drawDB2('p',START,COUNT,SAFE),!.
	drawDB2('5',START,COUNT,SAFE):-
		clearwindow,write("Save database? [y/n]\n"),accept,
		save_db(dFDSName,diseases_symptoms_db),drawDB2('p',START,COUNT,SAFE),!;
		drawDB2('p',START,COUNT,SAFE),!.
	drawDB2('6',START,COUNT,SAFE):-
		clearwindow,write("Load database? [y/n]\n"),accept,
		retractall(_,diseases_symptoms_db),
		load_db(dFDSName,diseases_symptoms_db),drawDB2('\75',0,COUNT,SAFE),!;
		drawDB2('p',START,COUNT,SAFE),!.
	drawDB2('7',START,COUNT,SAFE):-
		clearwindow,write("Reset database? [y/n]\n"),accept,
		retractall(_,diseases_symptoms_db),
		clearwindow,write("Database was reset.\n"),
		readchar(_),drawDB2('\75',0,COUNT,SAFE),!;
		drawDB2('p',START,COUNT,SAFE),!.
	drawDB2(_,START,COUNT,SAFE):-drawDB2(START,COUNT,SAFE),!.
	drawDB2(START,COUNT,SAFE):-
		START>0,lDB2(LISTALL),nDB2(LISTALL,START,COUNT,LISTLOCAL),cDB2(LISTALL,COUNT1),COUNT1>START+COUNT,clearwindow,drawDB2Head(START,SAFE),write("...\n"),drawDB2List(START,LISTLOCAL),write("...\n"),readchar(C),drawDB2(C,START,COUNT,SAFE),!;
		START>0,lDB2(LISTALL),nDB2(LISTALL,START,COUNT,LISTLOCAL),cDB2(LISTALL,COUNT1),clearwindow,drawDB2Head(START,SAFE),write("...\n"),drawDB2List(START,LISTLOCAL),readchar(C),drawDB2(C,START,COUNT,SAFE),!;
		lDB2(LISTALL),nDB2(LISTALL,START,COUNT,LISTLOCAL),cDB2(LISTALL,COUNT1),COUNT1>START+COUNT,clearwindow,drawDB2Head(START,SAFE),nl,drawDB2List(START,LISTLOCAL),write("...\n"),readchar(C),drawDB2(C,START,COUNT,SAFE),!;
		lDB2(LISTALL),nDB2(LISTALL,START,COUNT,LISTLOCAL),clearwindow,drawDB2Head(START,SAFE),nl,drawDB2List(START,LISTLOCAL),readchar(C),drawDB2(C,START,COUNT,SAFE),!.
	drawDB2Head(CURRENT,SAFE):-
		writef("APPEND(1)  EDIT(2)  DELETE(3)  BROWSE(4)  SAFE MODE(0):%2.3s\nSAVE DB(5)  LOAD DB(6)  RESET DB(7)\n\tDatabase: Diseases-Symptoms | Current ID: %d\n",SAFE,CURRENT),
		writef("%5.5|%16.16|%10.10\n","ID","TITLE","SYMPTOMS"),!.
	drawDB2List(_,[]):-write("NO ELEMENTS\n"),!.
	drawDB2List(ID,[disease_symptoms(TITLE,SYMPTOMS)]):-
		SYMPTOMS=[],writef("%5.5|%16.16|%10.10\n",ID,TITLE,"not found"),!;
		SYMPTOMS=[H],str_len(H,L),L<=10,writef("%5.5|%16.16|%10.10\n",ID,TITLE,H),!;
		SYMPTOMS=[H],writef("%5.5|%16.16|%7.7...\n",ID,TITLE,H),!;
		writef("%5.5|%16.16|%10.10\n",ID,TITLE,"(...)"),!.
	drawDB2List(ID,[H|T]):-
		drawDB2List(ID,[H]),IDN=ID+1,drawDB2List(IDN,T),!.
	eDB2(DS):-disease_symptoms(TITLE,SYMPTOMS),DS=disease_symptoms(TITLE,SYMPTOMS).
	lDB2(R):-
		findall(DS,eDB2(DS),R),!;
		R=[],!.
	cDB2([],0):-!.
	cDB2([H|T],R):-cDB2(T,R1),R=R1+1,!.
	nDB2(_,_,0,[]):-!.
	nDB2([],_,_,[]):-!.
	nDB2([H|T],0,COUNT,R):-COUNT1=COUNT-1,nDB2(T,0,COUNT1,R1),R=[H|R1],!.
	nDB2([H|T],START,COUNT,R):-START1=START-1,nDB2(T,START1,COUNT,R),!.
%%% Database 3
	drawDB3:-drawDB3('\75',0,8,"on"),!.
	drawDB3('\27',_,_,_):-dBMenu,!.
	drawDB3('q',_,_,_):-dBMenu,!.
	drawDB3('p',START,COUNT,SAFE):-drawDB3(START,COUNT,SAFE),!.
	drawDB3('0',START,COUNT,SAFE):-turn(SAFE,SAFENEW),drawDB3(START,COUNT,SAFENEW),!.
	drawDB3('\75',_,COUNT,SAFE):-
		drawDB3(0,COUNT,SAFE),!.
	drawDB3('\77',_,COUNT,SAFE):-
		lDB3(LISTALL),cDB3(LISTALL,COUNTL),COUNTL1=COUNTL-1,COUNTL1>=0,drawDB3(COUNTL1,COUNT,SAFE),!;
		drawDB3(0,COUNT,SAFE),!.
	drawDB3('\72',START,COUNT,SAFE):-
		START>0,START1=START-1,drawDB3(START1,COUNT,SAFE),!;
		drawDB3(0,COUNT,SAFE),!.
	drawDB3('\80',START,COUNT,SAFE):-
		lDB3(LISTALL),cDB3(LISTALL,COUNTL),
		COUNTL>START+1,START1=START+1,drawDB3(START1,COUNT,SAFE),!;
		lDB3(LISTALL),cDB3(LISTALL,COUNTL),COUNTL1=COUNTL-1,COUNTL1>=0,drawDB3(COUNTL1,COUNT,SAFE),!;
		drawDB3(0,COUNT,SAFE),!.
	drawDB3('1',START,COUNT,SAFE):-clearwindow,
		lDB3(L),cDB3(L,ID),
		writef("Input new data for %d disease.\n",ID),
		write("Input title: "),readln(TITLE),
		write("Input treatments:\n"),inputStrList("Treatment[%d]:",0,TREATMENTS),
		assert(disease_treatments(TITLE,TREATMENTS),diseases_treatments_db),
		clearwindow,
		writef("%5.5|%16.16|%10.10\n","ID","TITLE","TREATMENTS"),
		drawDB3List(ID,[disease_treatments(TITLE,TREATMENTS)]),
		write("Successfully appended.\n"),
		readchar(_),drawDB3('p',START,COUNT,SAFE),!;
		write("Incorrect data entered. Try again? [y/n]"),accept,drawDB3('1',START,COUNT,SAFE),!;
		drawDB3('p',START,COUNT,SAFE),!.
	drawDB3('2',START,COUNT,SAFE):-clearwindow,
		lDB3(L),nDB3(L,START,1,[disease_treatments(TITLE0,TREATMENTS0)]),
		writef("Input new data for %d disease.\n",START),
		write("Input title: "),readln(TITLE),
		write("Input treatments:\n"),inputStrList("Treatment[%d]:",0,TREATMENTS),
		clearwindow,
		writef("%5.5|%16.16|%10.10\n","ID","TITLE","TREATMENTS"),
		drawDB3List(START,[disease_treatments(TITLE0,TREATMENTS0)]),drawDB3List(START,[disease_treatments(TITLE,TREATMENTS)]),
		write("Confirm the changes? [y/n]\n"),accept,
		retract(disease_treatments(TITLE0,TREATMENTS0),diseases_treatments_db),
		assert(disease_treatments(TITLE,TREATMENTS),diseases_treatments_db),
		write("Successfully changed.\n"),
		readchar(_),drawDB3('p',START,COUNT,SAFE),!;
		write("Error. Try again? [y/n]"),accept,drawDB3('2',START,COUNT,SAFE),!;
		drawDB3('p',START,COUNT,SAFE),!.
	drawDB3('3',START,COUNT,SAFE):-clearwindow,
		SAFE="on",lDB3(L),cDB3(L,C),START<C,write("Delete current record? [y/n]\n"),accept,
		nDB3(L,START,1,[disease_treatments(TITLE0,TREATMENTS0)]),
		retract(disease_treatments(TITLE0,TREATMENTS0),diseases_treatments_db),
		drawDB3('\72',START,COUNT,SAFE),!;
		SAFE="off",lDB3(L),cDB3(L,C),START<C,
		nDB3(L,START,1,[disease_treatments(TITLE0,TREATMENTS0)]),
		retract(disease_treatments(TITLE0,TREATMENTS0),diseases_treatments_db),
		drawDB3('\72',START,COUNT,SAFE),!;
		drawDB3('p',START,COUNT,SAFE),!.
	drawDB3('4',START,COUNT,SAFE):-clearwindow,
		lDB3(L),cDB3(L,C),START<C,
		nDB3(L,START,1,[disease_treatments(TITLE0,TREATMENTS0)]),
		writef("%5.5|%16.16|%10.10\n","ID","TITLE","TREATMENTS"),
		drawDB3List(START,[disease_treatments(TITLE0,TREATMENTS0)]),
		write("Title: ",TITLE0),nl,
		write("Treatments:\n"),outputStrList("Treatment[%d]:%\n",0,TREATMENTS0),
		readchar(_),drawDB3('p',START,COUNT,SAFE),!;
		drawDB3('p',START,COUNT,SAFE),!.
	drawDB3('5',START,COUNT,SAFE):-
		clearwindow,write("Save database? [y/n]\n"),accept,
		save_db(dFDTName,diseases_treatments_db),drawDB3('p',START,COUNT,SAFE),!;
		drawDB3('p',START,COUNT,SAFE),!.
	drawDB3('6',START,COUNT,SAFE):-
		clearwindow,write("Load database? [y/n]\n"),accept,
		retractall(_,diseases_treatments_db),
		load_db(dFDTName,diseases_treatments_db),drawDB3('\75',0,COUNT,SAFE),!;
		drawDB3('p',START,COUNT,SAFE),!.
	drawDB3('7',START,COUNT,SAFE):-
		clearwindow,write("Reset database? [y/n]\n"),accept,
		retractall(_,diseases_treatments_db),
		clearwindow,write("Database was reset.\n"),
		readchar(_),drawDB3('\75',0,COUNT,SAFE),!;
		drawDB3('p',START,COUNT,SAFE),!.
	drawDB3(_,START,COUNT,SAFE):-drawDB3(START,COUNT,SAFE),!.
	drawDB3(START,COUNT,SAFE):-
		START>0,lDB3(LISTALL),nDB3(LISTALL,START,COUNT,LISTLOCAL),cDB3(LISTALL,COUNT1),COUNT1>START+COUNT,clearwindow,drawDB3Head(START,SAFE),write("...\n"),drawDB3List(START,LISTLOCAL),write("...\n"),readchar(C),drawDB3(C,START,COUNT,SAFE),!;
		START>0,lDB3(LISTALL),nDB3(LISTALL,START,COUNT,LISTLOCAL),cDB3(LISTALL,COUNT1),clearwindow,drawDB3Head(START,SAFE),write("...\n"),drawDB3List(START,LISTLOCAL),readchar(C),drawDB3(C,START,COUNT,SAFE),!;
		lDB3(LISTALL),nDB3(LISTALL,START,COUNT,LISTLOCAL),cDB3(LISTALL,COUNT1),COUNT1>START+COUNT,clearwindow,drawDB3Head(START,SAFE),nl,drawDB3List(START,LISTLOCAL),write("...\n"),readchar(C),drawDB3(C,START,COUNT,SAFE),!;
		lDB3(LISTALL),nDB3(LISTALL,START,COUNT,LISTLOCAL),clearwindow,drawDB3Head(START,SAFE),nl,drawDB3List(START,LISTLOCAL),readchar(C),drawDB3(C,START,COUNT,SAFE),!.
	drawDB3Head(CURRENT,SAFE):-
		writef("APPEND(1)  EDIT(2)  DELETE(3)  BROWSE(4)  SAFE MODE(0):%2.3s\nSAVE DB(5)  LOAD DB(6)  RESET DB(7)\n\tDatabase: Diseases-Treatments | Current ID: %d\n",SAFE,CURRENT),
		writef("%5.5|%16.16|%10.10\n","ID","TITLE","TREATMENTS"),!.
	drawDB3List(_,[]):-write("NO ELEMENTS\n"),!.
	drawDB3List(ID,[disease_treatments(TITLE,TREATMENTS)]):-
		TREATMENTS=[],writef("%5.5|%16.16|%10.10\n",ID,TITLE,"not found"),!;
		TREATMENTS=[H],str_len(H,L),L<=10,writef("%5.5|%16.16|%10.10\n",ID,TITLE,H),!;
		TREATMENTS=[H],writef("%5.5|%16.16|%7.7...\n",ID,TITLE,H),!;
		writef("%5.5|%16.16|%10.10\n",ID,TITLE,"(...)"),!.
	drawDB3List(ID,[H|T]):-
		drawDB3List(ID,[H]),IDN=ID+1,drawDB3List(IDN,T),!.
	eDB3(DT):-disease_treatments(TITLE,TREATMENTS),DT=disease_treatments(TITLE,TREATMENTS).
	lDB3(R):-
		findall(DT,eDB3(DT),R),!;
		R=[],!.
	cDB3([],0):-!.
	cDB3([H|T],R):-cDB3(T,R1),R=R1+1,!.
	nDB3(_,_,0,[]):-!.
	nDB3([],_,_,[]):-!.
	nDB3([H|T],0,COUNT,R):-COUNT1=COUNT-1,nDB3(T,0,COUNT1,R1),R=[H|R1],!.
	nDB3([H|T],START,COUNT,R):-START1=START-1,nDB3(T,START1,COUNT,R),!.
	titleIsDB3([],_,[]):-!.
	titleIsDB3([H],TITLE0,R):-
		H=disease_treatments(TITLE,TREATMENTS),TITLE0=TITLE,
		R=[H],!;
		R=[],!.
	titleIsDB3([H|T],TITLE0,R):-
		H=disease_treatments(TITLE,TREATMENTS),TITLE0=TITLE,
		titleIsDB3(T,TITLE0,R1),R=[H|R1],!;
		titleIsDB3(T,TITLE0,R),!.
	treatmentsDraw([]):-!.
	treatmentsDraw([H]):-
		H=disease_treatments(TITLE,TREATMENTS0),
		write("Treatments:\n"),outputStrList("Treatment[%]:%\n",0,TREATMENTS0),!.
	treatmentsDraw([H|T]):-
		H=disease_treatments(TITLE,TREATMENTS0),
		write("Treatments:\n"),outputStrList("Treatment[%]:%\n",0,TREATMENTS0),!.
% Request menu
	requestMenu('p',NAME,SERNAME,AGE,AGE0,AGEN,TITLE):-clearwindow,
		write("SEARCH:\nPATIENT'S SYMPTOMS(1)  PATIENT'S TREATMENTS(2)\nPATIENTS IN AGE GROUP(3)  DISEASE'S SYMPTOMS(4)  BACK(q)\n"),nl,
		writef("- Name: %\n",NAME),writef("- Sername: %\n",SERNAME),writef("- Age: %3.3d\n",AGE),nl,
		writef("- Age: from %3.3 to %3.3\n",AGE0,AGEN),nl,
		writef("- Disease: %",TITLE),nl,
		readchar(C),requestMenu(C,NAME,SERNAME,AGE,AGE0,AGEN,TITLE),!.
	requestMenu('q',NAME,SERNAME,AGE,AGE0,AGEN,TITLE):-
		mainMenu,!.
	requestMenu('\27',NAME,SERNAME,AGE,AGE0,AGEN,TITLE):-
		mainMenu,!.
	requestMenu('1',NAME,SERNAME,AGE,AGE0,AGEN,TITLE):-clearwindow,
		write("Set new parameters?[y/n]\n"),accept,clearwindow,
		write("Name: "),readln(NAME1),
		write("Sername: "),readln(SERNAME1),
		write("Age: "),readint(AGE1),
		clearwindow,
		lDB1(L0),nameIsDB1(L0,NAME1,L1),sernameIsDB1(L1,SERNAME1,L2),ageIsDB1(L2,AGE1,L3),nDB1(L3,0,1,L4),
		writef("%5.5|%16.16|%16.16|%3.3|%10.10\n","ID","NAME","SERNAME","AGE","SYMPTOMS"),
		drawDB1List(0,L4),nl,
		symptomsDraw(L4),
		readchar(_),
		requestMenu('p',NAME1,SERNAME1,AGE1,AGE0,AGEN,TITLE),!;
		clearwindow,
		lDB1(L0),nameIsDB1(L0,NAME,L1),sernameIsDB1(L1,SERNAME,L2),ageIsDB1(L2,AGE,L3),nDB1(L3,0,1,L4),
		writef("%5.5|%16.16|%16.16|%3.3|%10.10\n","ID","NAME","SERNAME","AGE","SYMPTOMS"),
		drawDB1List(0,L4),nl,
		symptomsDraw(L4),
		readchar(_),
		requestMenu('p',NAME,SERNAME,AGE,AGE0,AGEN,TITLE),!.
	requestMenu('2',NAME,SERNAME,AGE,AGE0,AGEN,TITLE):-clearwindow,
		write("Set new parameters?[y/n]\n"),accept,clearwindow,
		write("Name: "),readln(NAME1),
		write("Sername: "),readln(SERNAME1),
		write("Age: "),readint(AGE1),
		clearwindow,
		lDB1(L0),nameIsDB1(L0,NAME1,L1),sernameIsDB1(L1,SERNAME1,L2),ageIsDB1(L2,AGE1,L3),nDB1(L3,0,1,L4),
		writef("%5.5|%16.16|%16.16|%3.3|%10.10\n","ID","NAME","SERNAME","AGE","SYMPTOMS"),
		drawDB1List(0,L4),nl,
		patientTreatmentsDraw(L4),
		readchar(_),
		requestMenu('p',NAME1,SERNAME1,AGE1,AGE0,AGEN,TITLE),!;
		clearwindow,
		lDB1(L0),nameIsDB1(L0,NAME,L1),sernameIsDB1(L1,SERNAME,L2),ageIsDB1(L2,AGE,L3),nDB1(L3,0,1,L4),
		writef("%5.5|%16.16|%16.16|%3.3|%10.10\n","ID","NAME","SERNAME","AGE","SYMPTOMS"),
		drawDB1List(0,L4),nl,
		patientTreatmentsDraw(L4),
		readchar(_),
		requestMenu('p',NAME,SERNAME,AGE,AGE0,AGEN,TITLE),!.
	requestMenu('3',NAME,SERNAME,AGE,AGE0,AGEN,TITLE):-clearwindow,
		write("Set new parameters?[y/n]\n"),accept,clearwindow,
		write("Age from: "),readint(AGE1),
		write("Age to: "),readint(AGE2),
		clearwindow,
		lDB1(L0),ageInDB1(L0,AGE1,AGE2,L1),
		writef("%5.5|%16.16|%16.16|%3.3|%10.10\n","ID","NAME","SERNAME","AGE","SYMPTOMS"),
		drawDB1List(0,L1),
		readchar(_),
		requestMenu('p',NAME,SERNAME,AGE,AGE1,AGE2,TITLE),!;
		clearwindow,
		writef("%5.5|%16.16|%16.16|%3.3|%10.10\n","ID","NAME","SERNAME","AGE","SYMPTOMS"),
		lDB1(L0),ageInDB1(L0,AGE0,AGEN,L1),
		drawDB1List(0,L1),
		readchar(_),
		requestMenu('p',NAME,SERNAME,AGE,AGE0,AGEN,TITLE),!.
	requestMenu('4',NAME,SERNAME,AGE,AGE0,AGEN,TITLE):-clearwindow,
		write("Set new parameters?[y/n]\n"),accept,clearwindow,
		write("Disease title: "),readln(TITLE0),
		clearwindow,
		lDB3(L0),titleIsDB3(L0,TITLE0,L1),nDB3(L1,0,1,L2),
		writef("%5.5|%16.16|%10.10\n","ID","TITLE","TREATMENTS"),
		drawDB3List(0,L2),
		treatmentsDraw(L2),
		readchar(_),
		requestMenu('p',NAME,SERNAME,AGE,AGE0,AGEN,TITLE0),!;
		clearwindow,
		lDB3(L0),titleIsDB3(L0,TITLE,L1),nDB3(L1,0,1,L2),
		writef("%5.5|%16.16|%10.10\n","ID","TITLE","TREATMENTS"),
		drawDB3List(0,L2),
		treatmentsDraw(L2),
		readchar(_),
		requestMenu('p',NAME,SERNAME,AGE,AGE0,AGEN,TITLE),!.
	requestMenu(_,NAME,SERNAME,AGE,AGE0,AGEN,TITLE):-
		requestMenu('p',NAME,SERNAME,AGE,AGE0,AGEN,TITLE),!.
	symptomsDisease([],_,0,"not found"):-!.
	symptomsDisease(SYMPTOMS,[H],W,R):-
		H=disease_symptoms(TITLE0,SYMPTOMS0),
		intersectionStrList(SYMPTOMS,SYMPTOMS0,SYMPTOMS1),
		cStrList(SYMPTOMS1,COUNT1),COUNT1>0,
		cStrList(SYMPTOMS0,COUNT0),cStrList(SYMPTOMS,COUNT),
		W=COUNT1*COUNT1/COUNT0/COUNT,R=TITLE0,!;
		W=0,R="not found",!.
	symptomsDisease(SYMPTOMS,[H|T],W,R):-
		H=disease_symptoms(TITLE0,SYMPTOMS0),
		intersectionStrList(SYMPTOMS,SYMPTOMS0,SYMPTOMS1),
		cStrList(SYMPTOMS1,COUNT1),COUNT1>0,
		cStrList(SYMPTOMS0,COUNT0),cStrList(SYMPTOMS,COUNT),
		W1=COUNT1*COUNT1/COUNT0/COUNT,R1=TITLE0,
		symptomsDisease(SYMPTOMS,T,W2,R2),
		W2>=W1,W=W2,R=R2,!;
		H=disease_symptoms(TITLE0,SYMPTOMS0),
		intersectionStrList(SYMPTOMS,SYMPTOMS0,SYMPTOMS1),
		cStrList(SYMPTOMS1,COUNT1),COUNT1>0,
		cStrList(SYMPTOMS0,COUNT0),cStrList(SYMPTOMS,COUNT),
		W=COUNT1*COUNT1/COUNT0/COUNT,R=TITLE0,!;
		symptomsDisease(SYMPTOMS,T,W,R),!.
	patientTreatmentsDraw([]):-nl,!.
	patientTreatmentsDraw([H]):-
		H=patient(NAME1,SERNAME1,AGE1,SYMPTOMS),
		lDB2(DS0),symptomsDisease(SYMPTOMS,DS0,W,TITLE0),lDB3(DT0),titleIsDB3(DT0,TITLE0,DT1),
		writef("Disease: %\nProbability of disease: %\n\n",TITLE0,W),
		treatmentsDraw(DT1),!.
	patientTreatmentsDraw([H|T]):-patientTreatmentsDraw([H]),!.
%%%%%
	accept:-readchar(C),accept(C),!.
	accept('y'):-!.
	accept('n'):-!,fail.
	accept(_):-accept.
	turn("on","off"):-!.
	turn("off","on"):-!.
	run:-mainMenu.