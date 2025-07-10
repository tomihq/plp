desde(X, X).
desde(X, Y) :- N is X+1, desde(N, Y). 

%Desconozco de que parcial es, pero estuvo en uno.
%capicua(-L): Que instancie en L todas las listas que son capicua.
capicua(L) :- desde(0, N), listaQueSuma(N, L), reverse(L, L).

listaQueSuma(0, []).
listaQueSuma(N, [X | XS]) :- between(1, N, X), N2 is N-X, listaQueSuma(N2, XS).


%opcional: N > 0 en la segunda cláusula. %