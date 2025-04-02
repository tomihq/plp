sumFoldr :: (Num a) => [a] -> a 
sumFoldr = foldr (+) 0

elemFoldr ::(Eq a) => a -> [a] -> Bool
elemFoldr e = foldr(\x rec -> if(x == e) then True else rec) False

concatOwn :: [a] -> [a] -> [a]
concatOwn = flip $ foldr (:)