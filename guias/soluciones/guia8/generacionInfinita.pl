% La idea es hacer ejercicios para practicar resolución + prolog ;) 
natural(cero). %{natural(cero)}
natural(suc(N)) :- natural(N).  %forall N . (natural(N) => natural(suc(N))) equiv {-natural(N) or natural(suc(N))}

%collatz(+N, -S) si n es par el siguiente numero es n/2. Si n es impar, el siguiente numero es 3n+1. La secuencia termina cuando n=1.
/* 
Esta version es la que habia hecho en el parcial. Estaba casi perfecta. Le erré en el caso base. Porque nunca me va a devolver nada, porque nunca "instanciaba" el valor de N en el de S. La idea era que como cada numero de la secuencia era una posible respuesta, entonces en cada recursion si o si caia en el caso base diciendole vos S ahora tenes el valor de N. Si me piden más soluciones, andá abajo y fijate que onda N.
collatz(1, _).
collatz(N, S) :- N>1, N mod 2 =:= 0, M is N / 2, collatz(M, S).
collatz(N, S) :- N>1, N mod 2 =\= 0, M is 3*N+1, collatz(M, S). */

collatz(N, N).
collatz(N, S) :-
    N > 1,
    N mod 2 =:= 0,
    M is N // 2,
    collatz(M, S).
collatz(N, S) :-
    N > 1,
    N mod 2 =\= 0,
    M is 3 * N + 1,
    collatz(M, S).


collatzMayor(N, M) :- collatz(N, M), not((collatz(N, M2), M2 > M)).

%decreciente(+N, -S) que genere todos los numeros desde N hacia 1. uno a uno.
%En cada paso tengo que asignar a S el valor de N entonces un caso base es decreciente(N, N) con N>=1.
%El caso recursivo es decreciente(N, S) :- M is N-1, decreciente(M, S) la S se va a ir asignando cuando llegue a la cláusula "que hace de caso base"

decreciente(N, N) :- N >= 1.
decreciente(N, S) :- N > 1, M is N-1, decreciente(M, S).

%potencias2(+N, -S): que genera todas las potencias de 2 hasta 2^N.
potencias2(0, 1).
potencias2(N, S) :-
    N > 0,
    N1 is N - 1,
    potencias2(N1, S).      
potencias2(N, S) :-
    N > 0,
    S is 2^N.              
