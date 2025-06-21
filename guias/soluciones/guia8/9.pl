desde(X, X).
desde(X, Y) :- N is X+1, desde(N, Y). 

/* 
    Asumiendo desde(X, Y)
    Si X está instanciada e Y no, genera todos los números al infinito desde X. 
    Si X está instanciada e Y también hay dos casos: Si X es mas grande que Y se cuelga. Si X es mas chico que Y solo da true cuando X alcanza Y.
    Si X no está instanciada, explota.
*/

desdeReversible(X, Y) :- nonvar(Y), Y >= X.
desdeReversible(X, Y) :- var(Y), desde(X, Y).