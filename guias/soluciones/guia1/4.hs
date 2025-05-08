{-
    prefijos: [1, 2, 3] = [[], [1] [1, 2], [1, 2, 3]]  
    Caso base: Quedarme sin elementos por recorrer: []
    Al principio debería hacer [] : [] = [[]].
    La segunda vez, el foldr tiene como e = 1. Entonces debería hacer [1] : [[]] = [[1], []].
    La tercera vez, el foldr tiene como e = 2. Entonces debería agarrar de rec, la cabeza de al lista que es [1] y hacer [e: head rec].
-}

prefijos :: [a] -> [[a]]
prefijos = foldr(\e rec -> [e] : map (e:) rec) []