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

curryOwn :: ((a, b) -> c) -> a -> b -> c
curryOwn f a b = f (a, b)

uncurryOwn :: (a -> b -> c) -> (a, b) -> c
uncurryOwn f (a, b) = f a b

sumFoldr :: Num a => [a] -> a
sumFoldr = foldr (+) 0

elemFoldr :: Eq a => a -> [a] -> Bool
elemFoldr e = foldr(\x rec -> if e == x then True else rec) False

filterOwn :: (a -> Bool) -> [a] -> [a]
filterOwn f = foldr(\e rec -> if f e then e:rec else rec) []

mapOwn :: (a -> b) -> [a] -> [b]
mapOwn f = foldr(\e rec -> f e : rec) [] 

{- mejorSegun :: (a -> a -> Bool) -> [a] -> a 
mejorSegun f l = foldr1(\e rec -> if f e mejorSegun(f, l) then e else rec) -}

sumasParciales :: Num a => [a] -> [a]
sumasParciales l = reverse (foldr(\e rec -> if(length rec > 0) then e + head(rec) : rec else e:rec) [] (reverse l))

sumaAlt :: Num a => [a] -> a 
sumaAlt = foldr (-) 0 
-- P1 - P2 + P3 -P4 + P5 = [1, 2, 3] = 2 - 3 = -1, 1 - (-1) = 2

sumaInversaAlt :: Num a => [a] -> a 
sumaInversaAlt = foldl (flip (-)) 0