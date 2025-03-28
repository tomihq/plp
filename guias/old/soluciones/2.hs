nub :: Eq a => [a] -> [a]
nub [] = []
nub (x:xs) = x : filter(\y -> x /= y) (nub xs)

union :: Eq a => [a] -> [a] -> [a]
union xs ys = nub (xs++ys)

mapNoFoldr :: (a -> b) -> [a] -> [b]
mapNoFoldr f [] = []
mapNoFoldr f (x:xs) = f x : mapNoFoldr f xs

data AB a = Nil | Bin (AB a) a (AB a) deriving Show

{- Elimina los n niveles contando desde el ultimo -}
truncar:: AB a -> Int -> AB a 
truncar Nil _ = Nil 
truncar (Bin i r d) n = if n == 0 then Nil else Bin (truncar i (n-1)) r (truncar d (n-1))