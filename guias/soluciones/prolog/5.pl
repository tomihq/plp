/* last(?L, ?U) 
    last([], 1) false.
    last([1, 2], 1) false.
    last([1, 2, 3, 1], 1) true 
    last([1, 2, 3, 1], E) -> true sii E = 1.
    last(L, E) -> es practicamente infinito.

    Caso base: Es verdadero si y solo si la lista tiene 1 elemento restante y es igual al enviado.

    Ahora que se hacerla sin append, la pienso con append
*/

last([U], U). 
last([_|T], U) :- last(T, U).
/*
    Append: . append([1], A, [1, 2]) A toma el valor que le falte a la lista original para unificar con [1, 2]
            . append([1], [2], A) A toma el valor que resulta de juntar ambas listas.
            . append(A, [3], [2, 3]) A toma el valor que le falta a la lista de [3] para ser [2, 3]. En este caso A = [2]. IMPORTANTE, aca sirve porque los elementos se van agregando adelante los de la A a [3].
*/
lastAppend(L, U) :- append(_, [U], L). 

/*
reverse: La idea es sacar todos los elementos, e ir colocando desde el ultimo sacado crear listas nuevas.
*/
reverse([], []).
reverse([H | T], L) :- reverse(T, R), append(R, [H], L).

prefijo(L1, L2) :- append(L1, _, L2).
sufijo(L1, L2) :- append(_, L1, L2).

/* pertenece(H, [H | _]). 
pertenece(E, [H | T]) :- E \= H, pertenece(E, T).  */
pertenece(E, L) :- append(_, [E | _], L). 
