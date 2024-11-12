/* partesQueSuma(+L, +S, -P)
La idea es que las listas permutadas que se generen sean menores a S.
Primero hago un predicado que haga la suma de los elementos, luego partes, y luego junto que la suma de los elementos de la partes sea igual a mi S. 
*/
partes([], []).
partes([H|T], [H|Rest]) :- partes(T, Rest).
partes([_|T], Rest) :- partes(T, Rest).

sum([], 0).
sum([H | T], Res) :- sum(T, Rest), Res is Rest + H.

partesQueSuma(L, S, Res) :- partes(L, Res),sum(Res, Suma), Suma =:= S.   

