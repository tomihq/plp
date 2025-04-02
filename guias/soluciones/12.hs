data AB a = Nil | Bin (AB a) a (AB a)
{-arbol = (Bin (Bin Nil 10 (Bin (Bin Nil 150 Nil)  100 Nil))  5 (Bin (Bin Nil 99 Nil) 10 Nil))-}
foldAB :: b -> (b -> a -> b -> b) -> AB a -> b 
foldAB z fBin Nil = z
foldAB z fBin (Bin i r d) = fBin (rec i) r (rec d)
    where rec = foldAB z fBin

recAB :: b -> (b -> a -> AB a -> AB a -> b -> b) -> AB a -> b 
recAB z fBin Nil = z
recAB z fBin (Bin i r d) = fBin (rec i) r i d (rec d)
    where rec = recAB z fBin


esNil :: AB a -> Bool
esNil Nil = True 
esNil _ = False

altura :: AB a -> Int
altura = foldAB 0 (\ri r rd -> 1 + (max ri rd))

cantNodos :: AB a -> Int 
cantNodos = foldAB 0 (\ri r rd -> 1 + ri + rd)

{- mejorSegunAB :: (a -> a -> Bool) -> AB a -> a 
mejorSegunAB f (Bin i r d) = foldAB(\ri r rd -> if f ri rd then (if f r ri then r else ri) else (if f r rd then r else rd)) (Bin i r d) -}

ramas :: AB a -> [[a]]
ramas = foldAB [] (\ri r rd -> if null ri && null rd then [[r]] else map (r :) ri ++ map (r :) rd)

cantHojas :: AB a -> Int 
cantHojas = foldAB 0 (\ri r rd -> (if  (== 0) ri && (== 0) rd then 1 else 0) + ri + rd)