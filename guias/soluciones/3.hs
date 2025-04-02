sumFoldr :: (Num a) => [a] -> a 
sumFoldr = foldr (+) 0

elemFoldr ::(Eq a) => a -> [a] -> Bool
elemFoldr e = foldr(\x rec -> if(x == e) then True else rec) False

concatOwn :: [a] -> [a] -> [a]
concatOwn = flip $ foldr (:)

filter :: (a -> Bool) -> [a] -> [a]
filter f = foldr(\x rec -> if f x then x:rec else rec) []

map :: (a -> b) -> [a] -> [b]
map f = foldr(\x rec -> (:) (f x) rec) []

{-
    foldr1: el caso base es el ultimo elemento. 
    (>) [1, 10, 3]
    if (>1(if(> 10 3) then 10 else 3)) else (if(> 10 3) then 10 else 3) -> Acá podríamos usar programación dinámica si estuvieramos en I.P.
    Todas las ramas van arrojando si o si un numero. La ejecución es lazy, pero el operador > necesita si o si dos argumentos atómicos de ambos lados, entonces resuelve hasta el caso base.

    Plega hacia la derecha según la decisión que necesite ir tomando. Acá en este caso se duplican "casos" porque el > te obliga si o si ir hasta la profundidad, obtener un resultado. El resultado después lo arma al final.

    Por ej.: recr(\x xs rec -> if(x > e) then e:x:xs else x:rec) e = 2 [1, 2, 3]
    > if(1 > 2)? Como acá ya tiene los dos argumentos calculados decide al toque. En este caso se va al else 1:(if(2 > 2)?) como la guarda es falsa, va de vuelta al else. 1:(2:(if(3 > 2))) como la guarda es verdadera, ahora sí va al then. 1:(2:(2:[3])) = [1, 2, 2, 3]
    -}

mejorSegun :: (a -> a -> Bool) -> [a] -> a 
mejorSegun f = foldr1(\x rec -> if(f x rec) then x else rec)

sumaAlt :: Num a => [a] -> a 
sumaAlt = foldr (-) 0 

{-
    Me di cuenta que en vez de hacer el ultimo menos el anteultimo es igual que hacer el anterior pero con foldl y flipeando el (-).
    Ej.: [2, 1] la idea es hacer 1-2+... para eso empezamos haciendo foldl (-) ((-) 0 2) [1] = foldl (-) 2 [1] = foldl (-) ((-) 2 1) = 1 - 2 = -1.

    La diferencia con el foldl en vez del foldr es que vamos resolviendo paso a paso, el foldr primero plega todo sin resolver, y despues de que plegó todo empieza a resolver.
-}
sumaInversaAlt :: Num a => [a] -> a 
sumaInversaAlt = foldl (flip (-)) 0