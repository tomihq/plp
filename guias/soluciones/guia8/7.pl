% interseccion(+L1, +L2, -L3). El caso base es que si la lista es vacia en L1 entonces L3 tambien.%
/* 
    Preguntar: usé un cut porque no sabía como eliminar los duplicados (salen del member), te da dos true true si el elem está dos veces.
*/
interseccion([], _, []).
interseccion([X | XS], L2, [X | L3]) :- member(X, L2), interseccion(XS, L2, L3), !, not(member(X, L3)).
interseccion([X | XS], L2, L3) :- not(member(X, L2)), interseccion(XS, L2, L3).

%partir(N, L, L1, L2) donde L1 tiene los primeros N elementos de L y L2 el resto.%
/* 
    ¿Qué significa esto? Bueno, 
    L1 tiene N elementos.
    L2 tiene N elementos.
    y L1 + L2 = L osea append(L1, L2, L).
    
*/ 

partir(N, L, L1, L2) :- length(L, LL), LL >= N, length(L1, N), length(L2, N), append(L1, L2, L).

%borrar(+L, +X, -Ls)%
/* 
    ¿Qué significa esto? 
        La longitud de Ls será longitud total - cant apariciones elemento.
        X no está en Ls.
*/

/* 

    Preguntar: usé un cut porque no sabia como eliminar los duplicados
                  [1,2,3,1]
                  /         \
     quitar 1° ocurrencia   quitar 2° ocurrencia
           |                        |
        [2,3,1]                  [1,2,3]
           |                        |
        quitar 1                 quitar 1
           |                        |
         [2,3]                   [2,3]   ← mismas soluciones
*/
borrar(L, X, R) :- not(member(X, L)), R = L.
borrar(L, X, R) :- append(A, [X | B], L), append(A, B, L1), !, borrar(L1, X, R).

cantApariciones([], X, 0).
cantApariciones([X | XSS], X, T) :-  cantApariciones(XSS, X, R), T is R+1.
cantApariciones([E | XSS], X, T) :- E \=X, cantApariciones(XSS, X, T).

/* sacarDuplicados(L1, L2) :-  */