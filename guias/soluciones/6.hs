{-
    sacarUna :: Eq => a -> [a] -> [a], que dados un elemento y una lista devuelve el resultado de eliminar de la lista la primera aparición del elemento si está presente.

    Acá tenemos que usar recursión primitiva porque si nos encontramos con el elemento tengo que NO agregarlo, sino devolver directamente la cola que le sigue sin tocar.

    [1, 2, 3, 2, 1]: Aca quiero borrar el primer 2.

    Entonces, el fold prepara los casos del if a medida que avanza, va plegando hacia la derecha. Cuando llega el caso del primer 2, entonces le decimos que ahi pare la recursion y solo devuelva [3, 2, 1].

    Entonces queda

    sacarUna e = recr (if(1 == 2) then [2, 3, 2, 1] else [1:recr..])
    En este momento va directo al else.
    [1: (recr(if 2 == 2) then [3, 2, 1] else [2:recr...])]

    Acá va directo al else.

    Entonces lo que termina armando es 1:xs que seria [1, 3, 2, 1]. Es decir, los elementos después de ese 2 ni los procesa.
 -}

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x : xs) = f x xs (recr f z xs)

sacarUna :: Eq a => a -> [a] -> [a]
sacarUna e = recr(\x xs rec -> if(x == e) then xs else x:rec) []    

{-
    Si el elemento actual es mayor al que quiere agregar, entonces pongo el que quiere agregar antes, luego el actual y luego la cola terminando la recursión. Esto es porque lo agrego una única vez.
    Si no se cumple la condición, agrego el elemento actual x al resultado de la recursión procesada.

    Entonces: uso xs para terminar recursión, rec para decirle, seguí haciendo el foldr pero con el elemento de la cola que sigue.
-}
insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado e = recr(\x xs rec -> if(x > e) then e:x:xs else x:rec) []

