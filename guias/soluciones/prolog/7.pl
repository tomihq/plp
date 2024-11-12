/* 
    borrar(+L, +X, -Xs)
*/
borrar([], _, []).
borrar([H | T], H, XS) :- borrar(T, H, XS).
borrar([H | T], E, [H | XS]) :- H \= E, borrar(T, E, XS). /* acá como sabemos que mi head es diferente al elemento que quiero eliminar lo agregamos en la lista resultante */ 
