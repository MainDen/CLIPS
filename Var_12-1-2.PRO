domains
 ilist = integer*
 doing = eq;lg;sm;eqlg;eqsm
 obj = integer
 res = integer
 case = case(obj,res)
 caselist = case*
predicates
 numsortp(ilist,doing).
 case0(case,obj,res).
 caseof(obj,caselist,res).
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