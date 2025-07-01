gcd(X, 0, X) :- X > 0.
gcd(X, Y, G) :-
    Y > 0,
    R is X mod Y,
    gcd(Y, R, G).


desde(X, X).
desde(X, Y) :- N is X+1, desde(N, Y). 

/* mi solucion vieja es parcialmente erronea porque genera todos los del plano superior pero la idea esta ok.
    (1,1), (2,1), (2,2), (3,1), (3,2), (3,3) pero me faltan los casos (1, 2), (1, 3) pero nunca los agarro.
*/
coprimosOld(X, Y) :- desde(0, S), X is S, between(1, S, Y), X >0, Y > 0, gcd(S, Y, P), P is 1.

/* 
    N = 1 → (1,0), (0,1)
    N = 2 → (2,0), (1,1), (0,2)
    N = 3 → (3,0), (2,1), (1,2), (0,3)
    luego se filtran los que cumplen X > 0, Y > 0 y gcd(X, Y) = 1.
*/

%coprimos(-X, -Y)
coprimos(X, Y) :- generarPares(X, Y), X > 0, Y > 0, gcd(X, Y, P), P is 1.

%generarPares(-X, -Y)
generarPares(X, Y) :- desde(0, N), paresQueSuman(N, X, Y).

%paresQueSuman(+N, -X, -Y)
paresQueSuman(N, X, Y) :- between(0, N, X), Y is N-X.