/* 
Considerar el siguiente predicado:
 desde(X,X).
 desde(X,Y) :- N is X+1, desde(N,Y).

 i. Cómo deben instanciarse los parámetros para que el predicado funcione? (Es decir, para que no se cuelgue
 ni produzca un error). ¿Por qué?
 
 ii. Dar una nueva versión del predicado que funcione con la instanciación desdeReversible(+X,?Y), tal que
 si Y está instanciada, sea verdadero si Y es mayor o igual que X, y si no lo está genere todos los Y de X en
 adelante.
 
 El operador is lo que hace es primero resolver la operación de la derecha, y luego lo unifica con la variable de la izquierda.
 En este caso, para que N is X+1 no falle, X debe estar instanciado, y ser un número.

 También hay otro problema, el caso base es X, X osea que solo finalizará si X es mas chico que y pero si N llegase a ser mayor que Y se cuelga (esto sucede cuando hacemos Backtracking)

 Ej.: desdeReversible(10, 20) = True porque 20 >= 10
      desdeReversible(10, Y) = Y = 10, Y = 11, Y = 12, Y = 13
 
 */ 

desdeFalla(X,X).
desdeFalla(X,Y) :- N is X+1, desdeFalla(N,Y).

desdeReversible(X, Y) :- var(Y), Y = X. 
desdeReversible(X, Y) :- nonvar(Y), X =< Y. 
desdeReversible(X, Y) :- var(Y), X1 is X + 1, desdeReversible(X1, Y). 