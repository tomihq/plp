% X es un miembro de la lista L si existe una partición S y [X | _] tal que al hacer append(S, [X | _], L) da como resultado L, y además X no aparece en S. %
memberDeterministico(X, L) :- append(S, [X | _], L), not(memberDeterministico(X, S)).

% interseccion(+L1, +L2, -L3). El caso base es que si la lista es vacia en L1 entonces L3 tambien.%
interseccion([], _, []).
interseccion([X | XS], L2, [X | L3]) :- interseccion(XS, L2, L3), memberDeterministico(X, L2).
interseccion([X | XS], L2, L3) :- interseccion(XS, L2, L3), not(memberDeterministico(X, L2)).

%partir(N, L, L1, L2) donde L1 tiene los primeros N elementos de L y L2 el resto.%
% ¿Qué significa esto? Bueno, L1 tiene N elementos. L2 tiene N elementos y L1 + L2 = L osea append(L1, L2, L).
partir(N, L, L1, L2) :- length(L, LL), LL >= N, length(L1, N), length(L2, N), append(L1, L2, L).

%borrar(+L, +X, -LSD) que elimina todas las ocurrencias de X en L. %
borrar([], X, []).
borrar([E | XS], X, LSD) :- E \= X, borrar(XS, X, R), append([E], R, LSD). 
borrar([X | XS], X, LSD) :- borrar(XS, X, LSD).  
%o la segunda clausula podria ser borrar([E | XS], X, [E|R]) :- E \= X, borrar(XS, X, R). 
%sacarDuplicados(+L1, -L2).%
%% La lista sin duplicados de L1 es una lista que contiene exactamente una aparición de cada elemento que aparece en L1, respetando el orden de su primera aparición. Para construirla, tomamos el primer elemento X de la lista y lo incluimos en la salida. Luego eliminamos todas sus ocurrencias en el resto de la lista (XS), obteniendo una nueva lista LSE sin X. Aplicamos recursivamente el mismo procedimiento sobre LSE, y concatenamos X con el resultado.
sacarDuplicados([], []).
sacarDuplicados([X | XS], L2) :- borrar(XS, X, LSE), sacarDuplicados(LSE, RR), append([X], RR, L2). 

%permutación(+L1, ?L2)
%member acá no nos interesa porque podemos tener repetidos. Solo usamos append. El desafío acá es intercalar la cabeza de cada lista.
% [1, 2]. Suponemos que la lista vacía y la lista con un elemento ya esta permutada.
% [] -> [].
% [1] -> [1], [2] -> [2]
% [1, 2] -> [1] ++ [2] o [2] ++ [1]

%reparto(+L, +N, -LListas): que da true si LListas es UNA LISTA de N listas (N>=1) de cualquier longitud tales que al concatenarlas se obtiene la lista L.
% +L = [1, 2, 3] N = 3, LListas: append(Lista1, ResRecursivo, L), al final sucede que length(Llistas, N).
% ¿Hay una limitación sobre la cantidad de elementos en cada sublista? No. La realidad es que lo unico que tiene que cumplr Llistas es que sea de longitud N (tenga N listas adentro) y concatenadas den L.
reparto(X, 1, [X]).
reparto(L, N, [X | Ls]) :- N > 1, M is N-1, append(X, Xs, L), reparto(Xs, M, Ls).


%insertar(+L, +E, +I, -R) que inserta el elemento E en la lista L en la posición I.
%La idea es garantizar que inicialmente L1 y L2 daban L (para garantizar que L1 y L2 tengan los elementos que hay en L). 
insertar(L, E, I, R) :- append(L1, L2, L), length(L1, I), append(L1, [E | L2], R). 