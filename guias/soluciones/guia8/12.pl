%inorder(+AB, -Lista)
inorder(nil, []).
inorder(bin(I, R, D), L) :- inorder(I, L1), inorder(D, L2), append(L1, [R], L3), append(L3, L2, L).

%arbolConInorder(+Lista, -AB)
arbolConInorder([], nil).
arbolConInorder(L, bin(RI, R, RD)) :- append(LE, [R|RE], L), arbolConInorder(LE, RI), arbolConInorder(RE, RD).

%abb(+T). Un arbol es binario de busqueda sí y solo sí para cada raíz el elemento de la izquierda es menor o igual. Y el de la derecha es mayor. Y además las demás ramas también son ABB.

maximo(bin(_, R, nil), R).
maximo(bin(_, _, D), Max) :- maximo(D, Max).

minimo(bin(nil, R, _), R).
minimo(bin(I, _, _), Min) :- minimo(I, Min).

abb(nil).
abb(bin(I, R, D)) :-
    (I = nil; maximo(I, MaxI), MaxI < R),
    (D = nil; minimo(D, MinD), MinD > R),
    abb(I),
    abb(D).