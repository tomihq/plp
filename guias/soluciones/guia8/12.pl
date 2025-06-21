inorder(nil, []).
inorder(bin(I, R, D), L) :- inorder(I, L1), inorder(D, L2), append(L1, [R], L3), append(L3, L2, L).

treeWithInorder([], nil).
treeWithInorder([X], bin(nil, X, nil)).
treeWithInorder(L, bin(I, R, D)) :- length(L, LenL), M is LenL // 2, length(LL, M), append(LL, [R|LR], L), treeWithInorder(LL, I), treeWithInorder(LR, D).


/* Refactorizar este ejercicio de ABB porque no tiene sentido que use listas si el predicado no las tiene.  */
todosMenoresIguales([], _R).
todosMenoresIguales([X|Xs], R) :-
    X =< R,
    todosMenoresIguales(Xs, R).


todosMayores([], _R).
todosMayores([X|Xs], R) :-
    X > R,
    todosMayores(Xs, R).

abb(nil).
abb(bin(nil, X, nil)).
abb(bin(I, R, D)) :- inorder(I, LI), inorder(D, LD), todosMayores(LD, R), todosMenoresIguales(LI, R), abb(I), abb(D).

