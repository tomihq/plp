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

{- Ejercicio 3 
data Maybe a = Nothing | Just a -> Se suele utilizar para indicar que tipo de resultado podemos esperar dada una condición. 
Ej.: Si tengo que buscar el inverso multiplicativo pero el numero es 0 esperaria 0, es decir, tal como entró salió el valor (Nothing). Si el número NO es 0, esperaría que pase algo, es decir, que se devuelva alguna operación que involucre a a. 
Ej.: Si necesito que la entrada sea un booleano verdadero para devolver falso y caso contrario no hago nada puedo hacer que la salida QUIZÁ sea un booleano.

Nótese que el Maybe lo utilizamos cuando hay dos opciones: En una NO hago nada, en otra hago algo. 

data Either a b = Left a | Right b -> El dato se envía como parámetro indicando claramente qué tipo querés enviar. 
Ej. aEntero(Left 12) esperaría que la función devuelva algo si el argumento es del tipo a (Left)
Ej. aEntero(Right True) esperaría que la función haga algo, cuando sabe que el tipo que le llega es del tipo b y es un true. 

Nótese que en el Either siempre tenemos una salida "personalizada" de un tipo dado.
-}

inverso :: Float -> Prelude.Maybe Float 
inverso n | n == 0 = Nothing
          | otherwise = Just (1/n)

aEntero :: Either Int Bool -> Int 
aEntero (Left a) = a
aEntero (Right False) = 0
aEntero (Right True) = 1 

devolverFalsoSiVerdadero :: Bool -> Prelude.Maybe Bool 
devolverFalsoSiVerdadero b | b == False = Nothing
                           | otherwise = Just(not b)
