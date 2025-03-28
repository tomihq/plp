max2 :: (Float, Float) -> Float
max2 (x,y) | x >= y = x    
           | otherwise = y

max2Curry :: Float -> Float -> Float 
max2Curry x y | x >= y = x
              | otherwise = y

curryOwn :: ((a, b) -> c) -> a -> b -> c
curryOwn = \f x y -> f (x,y)

uncurryOwn :: (a -> b -> c) -> (a, b) -> c
uncurryOwn = \f (x, y) -> f x y

componer :: (a -> b) -> (c -> a) -> c ->  b 
componer = \f g x -> (f.g) x

triple :: Float -> Float 
triple = \e -> e * 3

tripleShort :: Float -> Float 
tripleShort = (*) 3

flipOwn :: (a -> b -> c) -> b -> a -> c
flipOwn = \f a b -> f b a

-- $
dollarOwn :: (a -> b) -> a -> b
dollarOwn = \f e -> f e

constOwn :: a -> b -> a 
constOwn = \x y -> x

productoCartesiano :: [a] -> [b] -> [(a, b)]
productoCartesiano xs ys = [(a, b) | a <- xs, b <- ys]

tuplasPares :: Integral a => Integral b => [a] -> [b] -> [(a, b)]
tuplasPares xs ys = [(x, y) | x <- xs, y <- ys, even x, even y]

takeNPares :: Int -> [Int]
takeNPares = \n -> take n [2, 4..]

functionConcat :: (Int -> Int) -> [[Int]] -> [Int]
functionConcat f l = concat $ (map (map f)) l

