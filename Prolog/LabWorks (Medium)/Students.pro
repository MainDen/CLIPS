domains
	student=student(integer,string,string,disciplines,accept)
	students=student*
	discipline=discipline(string,integer)
	disciplines=discipline*
	accept=no;yes
predicates
	student(integer,string,string,disciplines,accept)
clauses
	student( 0,"A-13-17","I",[
		discipline("Mathematical Logic",5),discipline("Software Engineering",5),
		discipline("System Programming",5),discipline("Architecture of Computing Systems",5)
		],no).
	student( 1,"A-13-17","Other Guy",[
		discipline("Mathematical Logic",4),discipline("Software Engineering",4),
		discipline("System Programming",4),discipline("Architecture of Computing Systems",4)
		],yes).
	student( 2,"A-13-17","Other Guy",[
		discipline("Mathematical Logic",4),discipline("Software Engineering",4),
		discipline("System Programming",4),discipline("Architecture of Computing Systems",4)
		],no).
	student( 3,"A-13-17","Other Guy",[
		discipline("Mathematical Logic",4),discipline("Software Engineering",4),
		discipline("System Programming",4),discipline("Architecture of Computing Systems",4)
		],yes).
	student( 4,"A-13-17","Other Guy",[
		discipline("Mathematical Logic",4),discipline("Software Engineering",4),
		discipline("System Programming",4),discipline("Architecture of Computing Systems",4)
		],no).
	student( 4,"A-13-17","Other Guy",[
		discipline("Mathematical Logic",4),discipline("Software Engineering",4),
		discipline("System Programming",4),discipline("Architecture of Computing Systems",4)
		],yes).
	student( 6,"A-13-17","Other Guy",[
		discipline("Mathematical Logic",4),discipline("Software Engineering",4),
		discipline("System Programming",4),discipline("Architecture of Computing Systems",4)
		],no).
	student( 7,"ENEMIES-13-17","Dr. Heinz Doofenshmirtz",[
		discipline("Military Logic",5),discipline("Bad Philosophy",5),
		discipline("Mockery of the Weak",4),discipline("Brilliant Thinking",5)
		],no).
	student( 8,"ENEMIES-13-17","Loki",[
		discipline("Military Logic",5),discipline("Bad Philosophy",3),
		discipline("Mockery of the Weak",3),discipline("Brilliant Thinking",5)
		],yes).
	student( 9,"ENEMIES-13-17","Lord Voldemort",[
		discipline("Military Logic",4),discipline("Bad Philosophy",5),
		discipline("Mockery of the Weak",4),discipline("Brilliant Thinking",2)
		],yes).
	student(10,"ENEMIES-13-17","Scream",[
		discipline("Military Logic",1),discipline("Bad Philosophy",5),
		discipline("Mockery of the Weak",5),discipline("Brilliant Thinking",5)
		],yes).
	student(11,"ENEMIES-13-17","Agent Smith",[
		discipline("Military Logic",5),discipline("Bad Philosophy",5),
		discipline("Mockery of the Weak",2),discipline("Brilliant Thinking",2)
		],no).
	student(12,"ENEMIES-13-17","Scar",[
		discipline("Military Logic",2),discipline("Bad Philosophy",5),
		discipline("Mockery of the Weak",5),discipline("Brilliant Thinking",3)
		],no).
	