/* Implementar esPrimo(n) que dice si un numero es primo o no.
    ¿Que es lo que tiene que pasar? 
    Bueno, primero instancio un nuevo N2 para poder usarlo dentro de un between. Como N va a estar instanciado, N2 is N-1 literalmente le asigna a N2 el valor de N-1.
    N2 si o si va a ser N-1.
    Luego, tengo que generar todos los numeros desde 2 a N2 y guardarlo en otra variable Z.

    Posteriormente, not(n mod z =:= 0)
*/
/* esPrimo(+N) */
esPrimo(N) :- N>1, N2 is N-1, between(2, N2, D), not(mod(N, D) =:= 0).

/* Implementar coprimos que genere todos los numeros (X,Y) que son coprimos entre si. 
Generación Infinita?: Sí. Entonces el generador infinito debe estar a la izquierda y de alguna manera ir parando los resultados que consigue.
Consideraciones: dos numeros son coprimos si y solo sí 1 is gcd(x,y) es true.
¿Qué criterio debo tener cuenta entre x e y? En vez de generar numeros de 1 a infinito que se cuelga, debo generar N, N2 al mismo tiempo.
Para eso, el predicado que tengo que usar debe ser reversible en dos parametros.
*/

coprimos(X,Y) :- nonvar(X), nonvar(Y), 1 is gcd(X,Y).
coprimos(X, Y) :- desdeReversible(1, S), between(1, S, X), Y is S-X, 1 is gcd(X, Y). 