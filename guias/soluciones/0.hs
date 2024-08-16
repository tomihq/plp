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

aEntero2 :: Either Int Bool -> Int 
aEntero2 a = case a of 
             (Left a) -> a 
             (Right a) -> if a then 1 else 0 

devolverFalsoSiVerdadero :: Bool -> Prelude.Maybe Bool 
devolverFalsoSiVerdadero b | b == False = Nothing
                           | otherwise = Just(not b)


{- Ejercicio 4. 

limpiar :: String → String → String, que elimina todas las apariciones de cualquier carácter de la primera
cadena en la segunda. Por ejemplo, limpiar ``susto'' ``puerta'' evalúa a ``pera''. Nota: String es un
renombre de [Char]. La notación ``hola'' es equivalente a [`h',`o',`l',`a'] y a `h':`o':`l':`a':[].

Idea: Recorro las letras del primer string, por cada letra, veo si esta en la segunda, y si esta, la elimino (es decir), devuelvo una lista completamente nueva.
Es decir, cada vez que borro 1 letra, es una lista nueva. "Deberia ir concatenando, las letras que son diferentes en una nueva lista"

difPromedio :: [Float] → [Float] que dada una lista de números devuelve la diferencia de cada uno con el
promedio general. Por ejemplo, difPromedio [2, 3, 4] evalúa a [-1, 0, 1].

todosIguales :: [Int] -> Bool: Que indica si todos los elementos de una lista son iguales.
mi idea va a ser que: el caso base sea [] = []
    Ahora la idea es que a partir del segundo recorrido chequee el elemento enviado anteriormente es igual a la cabeza de ese momento. Si la lista es vacia es true (todos iguales) pues queda un elemento, caso contrario chequeo si el elemento que me mandaron por parametro es igual a mi cabeza actual, si es asi lo dejo pasar, sino retorno false.
-}

{- limpiar :: [Char] -> [Char] -> [Char]
limpiar [] p2 = p2
limpiar p1 p2 = limpiarAux (head p1) p2 []

limpiarAux :: Char -> [Char] -> [Char] -> [Char] 
limpiarAux e p2 l | p2 == [] = l
                  | head(p2) == e = limpiarAux e (tail p2) l 
                  | otherwise = e : l  -}

cantidadElementos :: [Float] -> Float 
cantidadElementos [] = 0
cantidadElementos l = 1 + cantidadElementos (tail l);

sumatoria :: [Float] -> Float 
sumatoria [] = 0
sumatoria l = (head l) + sumatoria(tail l)

promedio :: [Float] -> Float 
promedio l = sumatoria l / cantidadElementos l
{- Nota, usé / porque div es para enteros. Ver :t div y :t (/) -}

difPromedio :: [Float] -> [Float]
difPromedio l = difPromedioAux l (promedio l) []

difPromedioAux :: [Float] -> Float -> [Float] -> [Float]
difPromedioAux l1 prom l2 | l1 == [] = l2 
                          | otherwise = (head l1) - prom : difPromedioAux (tail l1) prom []
                                {- Voy creando una nueva lista con los elementos en cada paso recursivo.-}
                    

todosIguales :: [Int] -> Bool 
todosIguales l = todosIgualesAux l (head l)

todosIgualesAux :: [Int] -> Int -> Bool 
todosIgualesAux l e | l == [] = True
                    | head(l) /= e = False
                    | otherwise = todosIgualesAux (tail l) (head l)