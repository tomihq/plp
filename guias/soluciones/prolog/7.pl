/* borrar(+L, +X, -Xs) */
borrar([], _, []).
borrar([H | T], H, XS) :- borrar(T, H, XS).
borrar([H | T], E, [H | XS]) :- H \= E, borrar(T, E, XS). /* acá como sabemos que mi head es diferente al elemento que quiero eliminar lo agregamos en la lista resultante */ 

/* no uso append en este caso porque tengo que agregar adelante, append es poco eficiente */
sacarDuplicados([], []).
sacarDuplicados([H | XS], L2) :- member(H, XS), sacarDuplicados(XS, L2). 
sacarDuplicados([H | XS], [H | L2]) :- not(member(H, XS)), sacarDuplicados(XS, L2).

/* no uso append porque es poco eficiente. */ 
interseccion([], L2, []).
interseccion([H | XS], L2, [H | Res]) :- member(H, L2), interseccion(XS, L2, Res2), sacarDuplicados(Res2, Res).
interseccion([H | XS], L2, Res) :- not(member(H, L2)), interseccion(XS, L2, Res).

/* permutacion(+L1, ?L2) */
permutacion([], []).
permutacion(L1, [H|T]) :-
    append(L, [H|R], L1), 
    append(L, R, Resto),  
    permutacion(Resto, T).  