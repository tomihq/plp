data Rosetree a = Rose a [Rosetree a]

foldRose :: (a -> [b] -> b) -> Rosetree a -> b
foldRose fRose (Rose a hijos) = fRose a (map (foldRose fRose) hijos)

hojas :: Rosetree a -> [a]
hojas = foldRose(\r rec -> if (length(rec) == 0) then [r] else concat rec)

{-Pienso caso base primero: [0]-}
distancias:: (Num a) => Rosetree a -> [a]
distancias = foldRose(\_ rec -> 0:concatMap(map(+1)) rec)

altura :: (Ord a, Num a) => Rosetree a -> a
altura r = maximum(map(+1)(distancias r))