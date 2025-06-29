arbol(bin(bin(bin(nil,4,nil),2,bin(nil,5,bin(nil,6,nil))),1,bin(bin(nil,7,nil),3,nil))).

% definir rama(+A, -C) que es verdadero cuando C es un camino desde la raiz del arbol A hasta alguna de sus hojas.
% Sabemos que por definición las ramas del árbol se consiguen yendo o todo para la derecha, o todo para la izquierda o mezclando. Esto significa que hay una especie de decisión en cada paso y no es simplemente un traversal de una única ecuación. Sabemos que el caso base es llegar hasta una hoja, es decir, a un árbol del tipo bin(nil, R, nil) el cual el camino terminaría con esa hoja. Lo cual implica que el caso base es (bin(nil, R, nil), [R]) pues la salida de cada camino es una lista.
%En el caso recursivo tenemos dos casos: O bien vamos a buscar recursivamente rama(I, C) o bien rama(R, C). Luego, el resultado es cada C. 

rama(bin(nil, R, nil), [R]).
rama(bin(I, R, _), [R | C]) :- rama(I, C).
rama(bin(_, R, D), [R | C]) :- rama(D, C). 

%definir ramaMasLarga(+A, -C): La idea es buscar todas las posibles ramas (con el predicado anterior) y decir que length C es la mas grande de todas. Es decir, NO hay otra rama con mayor longitud.
ramaMasLarga(A, C) :- rama(A, C), length(C, MG), not((rama(A, D), length(D, MC), MC > MG)).


%definir ramaUnicaDeLong(+A, +N, -C): Simil al anterior. Digo que existe una rama que tiene longitud N y que no puede existir otra rama de longitud N que sean diferentes.
ramaUnicaDeLong(A, N, C) :- rama(A, C), length(C, N), not((rama(A, D), length(D, N), C\=D)).
