vecino1(X, Y, [X | [Y | Ls]]).
vecino1(X, Y, [W | Ls]) :- vecino1(X, Y, Ls).

vecino2(X, Y, [W | Ls]) :- vecino2(X, Y, Ls).
vecino2(X, Y, [X | [Y | Ls]]).

/* 
La primera implementación encuentra las soluciones en orden porque primero verifica que la lista cumpla (sea un hecho), luego, si no evalúa como hecho entonces hace recursión. Esto permite que, en primer lugar, primero devuelva las soluciones en orden (izquierda a derecha) con respecto a la lista, si no vale la primera, va a la segunda. Luego vuelve a chequear la primera y así sucesivamente.

Por ejemplo, el árbol DFS sería así:
vecino(5, Y, [5, 6, 5, 3]) -> unifica con la cabeza de la primer claúsula. Encontramos la primer solución {y:=6}. Si pedimos más hace REDO y chequea si unifica con la segunda claúsula. Como unifica, llama a vecino(5, Y, [6, 5, 3])
    vecino(5, Y, [6, 5, 3]) -> no unifica la cabeza de la primer cláusula. Va directo a la segunda cláusula, y como unifica llama a vecino(5, Y, [5, 3]).
        vecino(5, Y, [5, 3]) -> unifica con la cabeza de la primera claúsula. Entonces encontramos la segunda solución {y:=3}. Si pedimos más hace REDO y chequea si unifica con la segunda cláusula. Como unifica, llama a vecino(5, Y, [3])
            vecino(5, Y, [3]) -> no unifica la cabeza de la primer claúsula. Entonces chequea si unifica con la segunda claúsula. Como unifica, llama a vecino(5, Y, [])
                vecino(5, Y, []) -> no unifica con la cabeza de la primer cláusula. Entonces chequea si unifica con la segunda cláusula. Como no unifica, entonces se acabaron las opciones, da false.

La segunda implementación primero hace DFS recursivamente. Como cae siempre en el paso recursivo, hace todo el trabajo recursivo hasta que la lista es vacía. Cuando la lista es vacía, no unifica con ningún hecho, entonces da Fail. En ese momento, hace un REDO y hace backtrack y busca qué decisiones tomadas (en el DFS) satisfacen la segunda. Si alguna satisface la segunda, devuelve esa unificación. Luego, si pedimos más hace REDO y sigue verificando si alguna más cumple hasta que no haya ninguna y de false.

Por ejemplo, el árbol DFS sería así:
vecino(5, Y, [5, 6, 5, 3])
    vecino(5, Y1, [6, 5, 3])
        vecino(5, Y2, [5, 3])
            vecino(5, Y3, [3])
                vecino(5, Y4, [])
                Como este último no unifica más con la cabeza de la cláusula recursiva da fail. Entonces hace un REDO y vuelve al paso anterior.
            vecino(5, Y3, [3]) verifica la segunda cláusula (la primera ya la probó, era la recursión) ¿unifica? no. Entonces hace FAIL y REDO.
        vecino(5, Y2, [5, 3]) ¿unifica con la segunda cláusula? sí. Entonces acá encuentra el primer resultado {y:=3}. Si pedimos más hace REDO y vuelve.
    vecino(5, Y1, [6, 5, 3]) ¿unifica con la segunda cláusula? no. Entonces hace FAIL y REDO. 
vecino(5, Y, [5, 6, 5, 3]) ¿unifica con la segunda cláusula? sí. Entonces hace {y:=6}. Si pedimos más hace REDO, y como no hay más da false. 

Si encontró solución y pedimos más hace REDO.
Si no encontró solución y tiene más chances hace FAIL + REDO
Si encontró (o no) solución y no tiene más chances hace FALSE.
*/