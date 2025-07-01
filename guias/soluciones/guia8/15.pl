%del ejercicio 9
desde(X, X).
desde(X, Y) :- N is X+1, desde(N, Y). 

%esTriangulo(+T)%
esTriangulo(tri(A, B, C)) :- valido(A, B, C), valido(B, C, A), valido(C, A, B).

%valido(+A, +B, +C)
valido(A, B, C) :-A < B + C.


%perimetro(?T, ?P). Necesito usar esTriangulo(T) que recibe un tri(A, B, C). Unifico el T con el tri(A, B, C) (la variable T ahora es igual a tri(A, B, C)) para también tener los lados desestructurados. 
%Caso -T -P: Tengo que indicar cuál es la relación entre tri(A, B, C) y un P no instanciado. La idea sería generar P infinitos. Luego, generar las combinaciones de A + B + C que arman ese P e instanciar el triangulo. Esto es generate and test porque genero todos los triangulos y luego filtro. La idea es que no se cuelgue, es decir, cuando me da uno, pueda seguir pidiendo más. Como tengo garantizado que el segundo no está instanciado puedo usar el desde común.
%
perimetro(T, P) :- nonvar(P), ground(T), T = tri(A, B, C), esTriangulo(T), P is A + B + C. % caso +T +P
perimetro(T, P) :- nonvar(P), triplasQueSuman(A, B, C, P), T = tri(A, B, C), esTriangulo(T). % caso -T +P
perimetro(T, P) :- ground(T), var(P), T = tri(A, B, C), P is A+B+C.                               % caso +T -P
perimetro(T, P) :- not(ground(T)), var(P), % c.i
                   triplasQueSuman(A, B, C, P),    % generate
                   T = tri(A, B, C), esTriangulo(T).                 % test (como A + B + C están generados en base al posible perimetro, vale.)                    


%Si el perimetro está dado tengo que encontrar nros A + B + C que sumen P. Cada uno es máximo P.
triplasQueSuman(A, B, C, P) :- desde(0, P), between(0, P, A), between(0, P, B), C is P-A-B, C>0.

%triangulo(-T) genera todos los triangulos
triangulo(T) :- perimetro(T, _).