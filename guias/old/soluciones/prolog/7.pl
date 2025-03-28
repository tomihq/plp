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

insertar(X, L, LX) :- append(P, S, L), append(P, [X|S], LX).

% reparto(+L, +N, -LListas) que tenga éxito si LListas es una lista de N listas (N ≥ 1) de cualquier
% longitud - incluso vacías - tales que al concatenarlas se obtiene la lista L.
reparto([], 0, []).         % Cuando N=0 solo podemos unificar si ya repartimos todo L.
reparto(L, N, [X|Xs]) :-
    N > 0,                  % Hay sublistas por generar.
    append(X, L2, L),       % Generamos todas las posibles sublistas X.
    N2 is N-1,              % L2 es lo que queda de L para repartir en N-1 sublistas.
    reparto(L2, N2, Xs).    % Generamos el resto de las sublistas.

% repartoSinVacías(+L, -LListas) similar al anterior, pero ninguna de las listas de LListas puede ser
% vacía, y la longitud de LListas puede variar.

% Como no pueden haber sublistas vacías, a lo sumo hay N sublistas siendo length(L, N).

repartoSinVacias(L, Xs) :-
    length(L, N),
    between(1, N, K),   % Generamos todas los posibles K = cantidades de sublistas.
    reparto(L, K, Xs),  % Repartimos en K sublistas.
    not((member(X, Xs), length(X, 0))). % No pueden haber sublistas vacías.