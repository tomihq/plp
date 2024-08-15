valorAbsoluto :: Float -> Float
valorAbsoluto n | n>=0 = n
                | otherwise = -n

esAnioBisiesto :: Int -> Bool 
esAnioBisiesto n = mod n 4 == 0

factorial :: Int -> Int 
factorial n | n == 1 = 1
            | otherwise = n * factorial(n-1)

esPrimoAux :: Int -> Int -> Bool
esPrimoAux n m | n == 1 = False
               | m == 1 = True  
               | mod n m == 0 = False 
               | otherwise = esPrimoAux n (m-1)

cantDivisoresPrimos :: Int -> Int 
cantDivisoresPrimos n = cantDivisoresPrimosAux n n

cantDivisoresPrimosAux:: Int -> Int -> Int 
cantDivisoresPrimosAux n m | n == 1 = 0
                           | m == 1 = 0
                           | n == m = 0 + cantDivisoresPrimosAux n (m-1)
                           | mod n m /= 0 = 0 + cantDivisoresPrimosAux n (m-1)
                           | not(esPrimoAux m (m-1)) = 0 + cantDivisoresPrimosAux n (m-1) 
                           | otherwise = 1 + cantDivisoresPrimosAux n (m-1) 
                            