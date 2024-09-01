{- max2 no esta currificada -}
max2 :: (Float, Float) -> Float
max2 (x, y) | x >= y = x
            | otherwise = y

normaVectorial:: (Float, Float) -> Float 
normaVectorial (x, y) = sqrt(x^2 + y^2)

{- substract esta currificada. -}
substract :: Float -> Float -> Float
substract = flip (-)

{- predecesor esta currificada -}
predecesor:: Float -> Float 
predecesor = substract 1

{- Aplicacion: evaluarEnCero (\x -> x+2 == 0) -}
evaluarEnCero :: (Float -> b) -> b
evaluarEnCero = \f -> f 0
{- \f es basicamente (\x -> x+2 == 0). El parámetro x que recibe es el 0 que se envía a f en evaluarCero. -}

{- dosVeces :: (a -> a) -> (a->a)
dosVeces f = \x -> f (f x)  -}

{-Pto B: Las no currificadas las paso a curry. Yo entiendo como que las funciones currificadas te dejan mas libertad de aplicarla parcialmente. -}
max2Curry :: Float -> Float -> Float 
max2Curry x y | x >= y = x
              | otherwise = y

max2CurryA :: Float -> Float 
max2CurryA = max2Curry 2

max2CurryB :: Float -> Float 
max2CurryB a = max2CurryA a


{- Pto 2. -}

curryOwn :: ((a, b) -> c) -> (a -> (b -> c))
curryOwn f a b = f (a, b)

sumTuple :: (Float, Float) -> Float
sumTuple (x, y) = x + y

sumarCurry :: Float -> Float -> Float
sumarCurry = curryOwn sumTuple

sumarCurryDescurrificar :: (Float, Float) -> Float
sumarCurryDescurrificar = decurryOwn sumarCurry

decurryOwn :: (a -> b -> c) -> ((a, b) -> c)
decurryOwn f (a, b) = f a b 

{- Este foldr recorre solo listas. -}
sumFoldrlist :: Num a => [a] -> a 
sumFoldrlist = foldr (\x ac -> x + ac) 0

{- Este foldr recorre cualquier tipo de estructura de datos que pueda recorrerse. -}
sumFoldr :: (Foldable t, Num a) => t a -> a 
sumFoldr = foldr (\x ac -> x + ac) 0

elemFoldr :: (Foldable t, Eq a) => a -> t a -> Bool
elemFoldr y = foldr(\x acum -> (x == y) || acum) False 

concatFoldr ::  [a] -> [a] -> [a]
concatFoldr xs ys = foldr(:) ys xs 

filterFoldr :: (a -> Bool) -> [a] -> [a]
filterFoldr f = foldr (\x acc -> if f x then x : acc else acc) []
{--
mapFoldr (\x -> x+1) [1, 2, 3]
    ac = [], x = 3, f(1):ac -> ac = [4]
    ac = [2], x = 2, f(2):ac -> ac = [3, 4]
    ac = [3, 4], x = 1, f(1):ac -> ac = [2, 3, 4]
--}
mapFoldr :: (a -> b) -> [a] -> [b]
mapFoldr f = foldr(\x ac -> f(x):ac) []

{--
Tipo del acum: es un elemento de la lista, es un a. En cada llamado recursivo retorno un elemento. 
MejorSegun(>) [5, 1, 2, 4]
acc = 4, 4 > 2? si. acc = 4
acc = 4, 4 > 1? si. acc = 4
acc = 4, 4 > 5? no. acc = 5
--}
mejorSegun :: Foldable t => (a -> a -> Bool) -> t a -> a 
mejorSegun f = foldr1(\x ac -> if f x ac then x else ac) 

sumasParciales :: Num a => [a] -> [a]
sumasParciales = reverse . foldl(\acc x -> if(length acc > 0) then x+(head acc):acc else x:acc) []

sumaAlt :: (Num a) => [a] -> a
sumaAlt =  fst . foldl(\(acc, isAdd) x  -> if(isAdd) then (acc+x, False) else (acc-x, True))  (0, True)

sumaAltDer :: (Num a) => [a] -> a 
sumaAltDer = fst . foldr(\x (acc, isAdd) -> if(isAdd) then (acc + x, False) else (acc - x, True)) (0, True)

{-5. La segunda es recursion estructural-}
entrelazar :: [a] -> [a] -> [a]
entrelazar = foldr(\x rec -> (\ys -> if null ys then x:rec [] else x:head ys: rec (tail ys))) id {-importantisimo el caso base: acá no es vacío sino la funcion id si es vacio.-}

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x : xs) = f x xs (recr f z xs)

{- 6a -}
sacarUna :: (Eq a) => a -> [a] -> [a]
sacarUna n = foldr(\x rec -> if x==n then rec else x:rec) [] {- recordar que siempre armo una nueva lista, entonces sacarlo seria no ponerlo-}
{- Sacar una no se puede implementar con recursión estructural pues acá necesito utilizar la cola de la lista en un lugar que no es el propio llamado recursivo. -}

insertarOrdenado :: (Ord a) => a -> [a] -> [a]
insertarOrdenado n = foldr(\x rec -> if n<=x then n:x:rec else x:rec) [] {-recordar que siempre armo una nueva lista, si encuentro el valor primero pongo el menor, luego el del paso recursivo y luego la cola -}

genLista :: a -> (a->a) -> Integer -> [a]
genLista i f n = take (fromIntegral n) (iterate f i) {- iterate f i empieza una lista desde i y le aplica f: iterate (\x -> x+2) [1, 3, 5, 7] take hace un prevent de infinity. -}

desdeHasta ::  Integer -> Integer -> [Integer]
desdeHasta n m = genLista n succ (m - n + 1) 

{-mapPares:
    Necesito una funcion map que tome dos argumentos (pueden ser o no el mismo tipo a b y lo transforma en un tipo c)
    Luego necesito tomar una lista de pares del tipo que recibira el map (a, b) y luego devuelvo transformados en el tipo c.

-}
mapPares :: (a -> b -> c) -> [(a, b)] -> [c]
mapPares f = map (uncurry f) {-mapPares (\x y -> (x+1, y+2)) [(1, 2), (3, 4)]. Nota: usamos uncurry adentro del map porque los argumentos que vamos a aplicar estan como tuplas. -}

armarPares :: [a] -> [b] -> [(a, b)]
armarPares _ [] = []
armarPares [] _ = []
armarPares (x:xs) (y:ys) = (x, y) : armarPares xs ys 
{-Probar: armarPares (desdeHasta 10 20) (desdeHasta 30 40)-}

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f l r = foldr(\x rec -> uncurry f x:rec) [] (armarPares l r)

mapDobleCorta :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDobleCorta f l r = map (uncurry f) (armarPares l r)

sumaMat :: (Int -> Int -> Int) -> [[Int]] -> [[Int]] -> [[Int]]
sumaMat _ [] _ = []
sumaMat _ _ [] = []
sumaMat f (x:xs) (y:ys) = map (uncurry f) (armarPares x y) : sumaMat f xs ys
{--x e y son listas. Caso prueba: sumaMat (\x y -> x+y) [[1, 2], [3, 4]] [[5, 6], [7, 8]]--}

{- trasponer :: [[Int]] -> [[Int]] -}
{-  
    Input: [[1, 2], [3, 4]]
        1 2 
        3 4

    Output: [[1, 3], [2, 4]]
        1 3  
        2 4 

    Necesito recorrer cada lista, tomando primero el primer elemento hasta la ultima sublista.
    1:[]
    3:[1] = [3, 1] luego reverse [3, 1] = [1, 3]

    Lo mismo con la segunda componente
    2:[]
    4:[2] = [4, 2] luego reverse [4, 2] = [2, 4]
-}

data Nat = Zero | Suc Nat

