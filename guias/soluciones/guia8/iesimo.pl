%iesimo(+N, +L, -E) obtenga el iesimo elemento de una lista.
iesimo(0, [X | XS], X).
iesimo(N, [X | XS], E) :- N2 is N-1, iesimo(N2, XS, E).  

%iesimoReversible(?N, +L, -E) obtenga el iesimo elemento de una lista
iesimoReversible(I, L, E) :- length(L, LL), between(0, LL, I), iesimo(I, L, E).


%iesimoReversible SIN recursion explícita. Acá tengo dos casos disjuntos obligatorios. 
%Si me lo mandan es una cosa, sino, es otro.
iesimoReversible2(I, L, X) :- var(I), append(L1, [X | _], L), length(L1, I).
iesimoReversible2(I, L, X) :- nonvar(I), I >=0, length(L1, I), append(L1,[X | _], L).

