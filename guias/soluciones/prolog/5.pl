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
lastAppend(L, U) :- append(_, [U], L). 

