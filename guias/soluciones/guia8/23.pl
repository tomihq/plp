desde(X, X).
desde(X, Y) :- N is X+1, desde(N, Y).

%arbolInfinitoMal(-A). No hacer!!! Se queda colgado generando solo arboles en la rama izquierda.
arbolInfinitoMal(nil).
arbolInfinitoMal(bin(I, _, D)) :- arbolInfinitoMal(I).
arbolInfinitoMal(bin(I, _, D)) :- arbolInfinitoMal(D).


%arbol(-A)
arbol(nil). 
arbol(A) :- desde(1, N), arbolConProfundidad(N, A).

%generarArbolProfundidad(+N, -A)
arbolConProfundidad(0, nil). 
arbolConProfundidad(N, bin(L, _, R)) :-
    N > 0,
    N1 is N - 1,
    between(0, N1, NL),
    NR is N1 - NL,
    arbolConProfundidad(NL, L),
    arbolConProfundidad(NR, R).

%nodosEn(?A, +L): Tengo que gastar la lista de elementos poniendo cada elemento en cada posible raíz. 
%Tengo varias opciones: Ponerlo o no ponerlo en este paso.
nodosEn(nil, []).
nodosEn(bin(I, X, D), L) :-
    append(LI, [X | LD], L),
    nodosEn(I, LI),
    nodosEn(D, LD).