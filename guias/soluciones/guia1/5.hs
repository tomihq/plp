{-
    Recursion Estructural: Solo usa la cabeza de la lista. El xs pasa directo a la función recursiva, pero no a otra función.

    elementosEnPosicionesPares NO es recursion estructural porque se esta llamando (tail xs) en el llamado recursivo y solo debería usar xs. No debería poder hacer una función sobre xs. También se usa en la guarda del if, por lo tanto no valdría tampoco.

    entrelazar ES recursión estructural porque como la recursión se hace sobre (x:xs), xs no se usa nunca como subestructura, sino que solamente se la pasa al llamado recursivo.
-}

entrelazar :: [a] -> [a] -> [a]
entrelazar = foldr(\e rec ys -> (if null ys then e:rec [] else e:(head ys) : rec (tail ys) )) (const [])