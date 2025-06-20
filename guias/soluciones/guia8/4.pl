juntar([], L2, L2).
juntar([H | T], L2, [H | L3]) :- juntar(T, L2, L3). 

/* 
El caso base es que la lista L1 esté vacía. En ese momento hemos construido una lista L3 que tiene todos los elementos de L1, falta concatenar la cola (L2).

OJO: Si en el caso base no pondríamos juntar([]) y pusiéramos juntar(_) entonces estaríamos indicando que da igual el tamaño de L1, el resultado de L3 siempre será como queda la lista final agregando cada uno de los elementos de L1 a L2.
Es decir, si tuviesemos [1, 2], [3, 4] sería: [3,4] (esta es porque unifica directo con el caso base), [1, 3, 4] y [1, 2, 3, 4]


*/