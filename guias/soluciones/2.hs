nub :: Eq a => [a] -> [a]
nub [] = []
nub (x:xs) = x : filter(\y -> x /= y) (nub xs)

union :: Eq a => [a] -> [a] -> [a]
union xs ys = nub (xs++ys)

mapNoFoldr :: (a -> b) -> [a] -> [b]
mapNoFoldr f [] = []
mapNoFoldr f (x:xs) = f x : mapNoFoldr f xs