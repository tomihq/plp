max2 :: (Float, Float) -> Float
max2 (x,y) | x >= y = x    
           | otherwise = y

normaVectorial:: (Float, Float) -> Float 
normaVectorial (x, y) = sqrt(x^2 + y^2)

substract :: Float -> Float -> Float
substract = flip (-)

predecesor:: Float -> Float 
predecesor = substract 1

evaluarEnCero :: (Float -> b) -> b
evaluarEnCero = \f -> f 0

{- dosVeces :: (a -> b) -> (a -> b)
dosVeces = \f -> f . f -}

flipAll :: [a -> b -> c] -> [b -> a -> c]
flipAll = map flip

{- flipRaro :: (a -> b -> c) -> (b -> a -> c)
flipRaro = flip flip  -}

max2Curry :: Float -> Float -> Float 
max2Curry x y | x >= y = x
              | otherwise = y

normaVectorialCurry :: Float -> Float -> Float 
normaVectorialCurry x y = sqrt(x^2 + y^2)   

