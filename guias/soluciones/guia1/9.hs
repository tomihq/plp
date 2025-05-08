foldNat :: (Integer -> b -> b) -> b -> Integer -> b 
foldNat f z 0 = z
foldNat f z n = f n (foldNat f z (n-1))

{-
    n = 2 m = 3, es 2 * 2 * 2 

    2*(2*(2*(1))) = 8.
-}
potencia :: Integer -> Integer -> Integer
potencia n = foldNat(\x rec -> n * rec) 1