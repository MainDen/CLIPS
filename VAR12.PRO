domains
 i = integer
 r = real
 s = string
 ind = i
 ty = symbol
 rc = i
 sq = r
 fl = i
 zo = s
 variant = v(ind,ty,rc,sq,fl,isfl,zo)
predicates
 set(ind,ty,rc,sq,fl,isfl,zo).
 type(ind,ty).
 rooms(ind,rc).
 square(ind,sq).
 floor(ind,fl).
 zone(ind,zo).
clauses
type(1,obmen).
type(2,obmen).
type(3,obmen).
type(4,prodazha).
type(5,prodazha).
type(6,prodazha).
type(7,obmen).
type(8,obmen).
type(9,obmen).
type(10,prodazha).
type(11,obmen).
type(12,obmen).
rooms(1,2).
rooms(2,2).
rooms(3,1).
rooms(4,3).
rooms(5,6).
rooms(6,136).
rooms(7,1).
rooms(8,3).
rooms(9,2).
rooms(10,0).
rooms(11,1).
rooms(12,2).
floor(1,8).
floor(2,4).
floor(3,3).
floor(4,1).
floor(5,11).
floor(6,1).
floor(7,5).
floor(8,78).
floor(9,10).
floor(10,1).
floor(11,1).
floor(12,3).
square(1,25.4).
square(2,57).
square(3,12.5).
square(4,20.2).
square(5,16).
square(6,1780.3).
square(7,56).
square(8,21.4).
square(9,35.7).
square(10,19746.4).
square(11,43).
square(12,60).
zone(1,”Moscow”).
zone(2,”Moscow”).
zone(3,”Moscow”).
zone(4,”Moscow”).
zone(5,”SPB”).
zone(6,”SPB”).
zone(7,”SPB”).
zone(8,”Moscow”).
zone(9,”SPB”).
zone(10,”Donbass”).
zone(11,”SPB”).
zone(12,”Moscow”).
zone(4,”Novogireevo”).
zone(1,”Novogireevo”).
zone(2,”Aviamotornaja”).
zone(7,”Aviamotornaja”).
 type(I,T).
 rooms(I,RC).
 square(I,SQ).
 floor(I,FL).
 zone(I,ZO).
 set(I,TY,RC,SQ,FL,ISFL,ZO).