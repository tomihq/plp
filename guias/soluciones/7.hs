{-
    mapPares: una versión de map que toma una función currificada  de dos argumentos y una lista de pares de valores, y devuelve la lista de aplicaciones de la función a cada par.

    mapPares :: (a -> b -> c) -> [(a, b)] -> [c]

    Ej.: mapPares (+) [(1, 2), (3, 4)] = [3, 7]

    La idea es convertir la función que nos den que toma dos argumentos a una función que tome una tupla con dos elementos.
    Luego, aplicamos esa función con un map para cada una de las tuplas iniciales.
-}

mapPares :: (a -> b -> c) -> [(a, b)] -> [c]
mapPares f = map $ uncurry f


{-
    Tomar el primer elem de la primera lista y el primero de la segunda lista.
    Esto sería "recorrer" una lista a la vez, pero la otra también sacar al mismo tiempo. 
    Para esto puedo hacer una lambda que se recorra sobre xs y otra lambda que "no recorra" pero ir sacandole elementos desde la cabeza. Es decir, al paso recursivo de xs le mando tail ys.

    Utilizar: Evaluacion Parcial y Currificacion.
    Se usa currificacion cuando no pasamos explícitamente los parámetros a la función sino que los recibe foldr al toque.  Y usamos evaluacion parcial porque podemos mandar la primera lista, y no la segunda. lo que favorece la reutilización
-}
armarPares :: [a] -> [b] -> [(a, b)]
armarPares = foldr(\x rec (y:ys) -> (x, y): rec ys) (const [])

{-
    mapDoble: Recibo una función currificada de dos argumentos, dos listas y devuelvo una lista de aplicaciones a esa lista.

    Idea: Primero tengo que unir las dos listas en forma de tuplas (uso armarPares), luego, aplico literalmente mapPares.
-}

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f l1 l2 = mapPares f $ armarPares l1 l2

{- con lambda -}
mapDoble2 :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble2 = \f l1 l2 -> mapPares f $ armarPares l1 l2