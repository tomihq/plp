{-
    mapPares: una versión de map que toma una función currificada  de dos argumentos y una lista de pares de valores, y devuelve la lista de aplicaciones de la función a cada par.

    mapPares :: (a -> b -> c) -> [(a, b)] -> [c]

    Ej.: mapPares (+) [(1, 2), (3, 4)] = [3, 7]

    La idea es convertir la función que nos den que toma dos argumentos a una función que tome una tupla con dos elementos.
    Luego, aplicamos esa función con un map para cada una de las tuplas iniciales.
-}

mapPares :: (a -> b -> c) -> [(a, b)] -> [c]
mapPares f = map $ uncurry f

