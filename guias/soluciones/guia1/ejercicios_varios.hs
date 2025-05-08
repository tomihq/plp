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

{-
    Composiciones:
    1. map . map

        Lo primero que hay que hacer es ver los tipos de ambas funciones. Y por convención, vamos a renombrar las variables de tipo para que no haya colisiones.

        map :: (d -> e) -> [d] -> [e]
        (.) :: (b -> c) -> (a -> b) -> a -> c

        Lo primero que hacemos es pasar la composición a manera prefija. Es decir, (.) map map

        Ahora sí, la composición primero comienza con (a -> b). La función que tiene a la derecha es un map. Entonces, vinculamos cada letra a los parámetros del map.

        (a -> b) al primer map equivale a: a = (d -> e) y b = ([d] -> [e]).

        Ahora, el segundo map equivale a: b = (d -> e) y c = ([d] -> [e]).

        Juntando la data que conseguimos del primer map, es decir que b = ([d] -> [e]) reemplazamos en el segundo map.

        Entonces, el segundo map nos queda: b = ([d] -> [e]) y c = ([[d]] -> [[e]]).

        Por lo tanto, el tipado final de la composición es: (d -> e) -> ([[d]] -> [[e]]).
    
    2. flip . flip
        Lo primero que hay que hacer es ver los tipos de ambas funciones. Y por convención, vamos a renombrar las variables de tipo para que no haya colisiones.
        flip :: (a -> b -> c) -> (b -> a -> c)
        (.) :: (e -> f) -> (d -> e) -> d -> f

        Pasamos a notación prefija (.) flip flip.

        El primer argumento es el segundo flip, entonces queda:
        d = (a -> b -> c) y e = (b -> a -> c).

        Ahora, nos queda el segundo flip. 
        e = (a -> b -> c) y f = (b1 -> a1 -> c1).

        Juntando las e, unificamos y nos queda 
        b -> a -> c = a1 -> b1 -> c1
        b = a1, a = b1, c = c1.

        Finalizando, nos queda (b -> a -> c) -> (b -> a -> c)


-}