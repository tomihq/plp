ab(nil).
ab(bin(Izq, _, Der)) :- ab(Izq), ab(Der).

vacio(ab(nil), Res).

raiz(ab(AB), R) :- raiz(AB, R).
raiz(bin(_, R, _), R).  

devolverMax(X, Y, X) :- X >= Y.
devolverMax(X, Y, Y) :- X < Y.

altura(nil, 0).
altura(ab(AB), Alt) :- altura(AB, Alt).
altura(bin(Izq, _, Der), Alt) :- 
                                altura(Izq, Alt2), Alt3 is Alt2 + 1, 
                                altura(Der, Alt4), Alt5 is Alt4 + 1, 
                                devolverMax(Alt3, Alt5, Alt).