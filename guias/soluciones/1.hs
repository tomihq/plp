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
sumasParciales = reverse . foldl(\acc x -> x + (if length acc >= 1 then head acc else 0) : acc) []

sumaAlt :: (Num a) => [a] -> a
sumaAlt =  fst . foldl(\(acc, isAdd) x  -> if(isAdd) then (acc+x, False) else (acc-x, True))  (0, True)

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
genLista i f n = take (fromIntegral n) (iterate f i) {-genLista 2 (\x -> x+3) 5-}

desdeHasta :: Enum a => a -> Integer -> [a]
desdeHasta n m = genLista n succ m {-Como la funcion genLista es generica y no solo de numeros no puedo usar funciones especificas para numeros -}

{-mapPares:
    Necesito una funcion map que tome dos argumentos (pueden ser o no el mismo tipo a b y lo transforma en un tipo c)
    Luego necesito tomar una lista de pares del tipo que recibira el map (a, b) y luego devuelvo transformados en el tipo c.

-}
mapPares :: (a -> b -> c) -> [(a, b)] -> [c]
mapPares f = map (uncurry f) {-mapPares (\x y -> (x+1, y+2)) [(1, 2), (3, 4)]. Nota: usamos uncurry adentro del map porque los argumentos que vamos a aplicar estan como tuplas. -}
