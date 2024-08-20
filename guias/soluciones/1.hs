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