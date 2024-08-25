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