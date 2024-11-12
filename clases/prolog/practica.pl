natural(cero).
natural(suc(X)) :- natural(X).

/* escribir un predicado menor(X,Y) que es verdadero cuando X es menor que Y.
La idea es que si X es cero, Y = suc(_) entonces es menor. 
Esto es porque inductivamente los naturales se arman como cero, suc(X) y por lo tanto un numero X siempre va a ser menor si tiende mas rapido a cero que un numero Y. 
menor (+X, +Y)
*/
menor(cero, suc(_)).
menor(suc(X), suc(Y)) :- menor(X, Y).

/* entre(+X, +Y, -Z) */
entre(X, Y, Z) :- between(X, Y, Z).

/* solucion a mano: X es menor o igual a Y, Z es menor o igual a Y. Debo instanciar Z si o si, como a X lo voy incrementando, entonces unificaria con el mismo valor que Z. */
entre2(X, Y, X) :- X =< Y.
entre2(X, Y, Z) :- X =< Y, Z1 is X + 1, entre2(Z1, Y, Z).

/* 
    Definir el predicado long(+XS, -L)
*/
long([], 0). 
long([_ | T], L) :- long(T, Z), L is Z+1.