domains
 ilist = integer*
 doing = eq;lg;sm;eqlg;eqsm
 obj = integer
 res = string
 case = case(obj,res)
 caselist = case*
predicates
 numsortp(ilist,doing).
 case0(case,obj,res).
 caseof(obj,caselist,res).
 month(obj).
 n1_10(doing).
 n1_1(doing).
 n10_1(doing).
clauses
 numsortp([],D):-fail.
 numsortp([H|[]],D).
 numsortp([H1|[H2|T]],eq):-H1=H2,numsortp([H2|T],eq).
 numsortp([H1|[H2|T]],lg):-H1>H2,numsortp([H2|T],lg).
 numsortp([H1|[H2|T]],sm):-H1<H2,numsortp([H2|T],sm).
 numsortp([H1|[H2|T]],eqlg):-H1>=H2,numsortp([H2|T],eqlg).
 numsortp([H1|[H2|T]],eqsm):-H1<=H2,numsortp([H2|T],eqsm).
 case0(C,O,R):-C=case(O,R).
 caseof(X,[],R):-fail.
 caseof(X,[T|_],R):-case0(T,X,R).
 caseof(X,[H|T],R):-caseof(X,T,R).
 month(O):-caseof(O,[case(1,"January"),case(2,"February"),case(3,"March"),case(4,"April"),
 case(5,"May"),case(6,"June"),case(7,"July"),case(8,"August"),case(9,"September"),case(10,"October"),
 case(11,"November"),case(12,"December"),case(O,"isn't month")],R),write("That ",R,"!\n"),O>=1,O<=12.
 n1_10(D):-numsortp([1,2,3,4,5,6,7,8,9,10],D).
 n1_1(D):-numsortp([1,1,1,1,1,1,1,1,1,1],D).
 n10_1(D):-numsortp([10,9,8,7,6,5,4,3,2,1],D).