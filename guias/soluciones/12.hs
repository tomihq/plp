data AB a = Nil | Bin (AB a) a (AB a)
{-arbol = (Bin (Bin Nil 10 (Bin (Bin Nil 150 Nil)  100 Nil))  5 (Bin (Bin Nil 99 Nil) 10 Nil))-}
foldAB :: b -> (b -> a -> b -> b) -> AB a -> b 
foldAB z fBin Nil = z
foldAB z fBin (Bin i r d) = fBin (rec i) r (rec d)
    where rec = foldAB z fBin

recAB :: b -> (b -> a -> b -> AB a -> AB a -> b) -> AB a -> b 
recAB z fBin Nil = z
recAB z fBin (Bin i r d) = fBin (rec i) r (rec d) i d 
    where rec = recAB z fBin


esNil :: AB a -> Bool
esNil Nil = True 
esNil _ = False

altura :: AB a -> Int
altura = foldAB 0 (\ri r rd -> 1 + (max ri rd))

cantNodos :: AB a -> Int 
cantNodos = foldAB 0 (\ri r rd -> 1 + ri + rd)

mejorSegunAB :: (a -> a -> Bool) -> AB a -> a 
mejorSegunAB f (Bin i r d) =  foldAB r (\ri r rd -> if (f r ri && f r rd) then r else if (f ri rd) then ri else rd) (Bin i r d)


{- comparo raiz con toda rama izq y rama der. Despues bajo a raiz rama izq y comparo de vuelta, así mismo con derecha. -}
{- esABB :: Ord a => AB a -> Bool
esABB = recAB True (\ri r rd (Bin i2 r2 d2) (Bin i3 r3 d3) -> if(r < (esABBAux r) || r > r3) then False else ri && rd)

esABBAux :: (Ord a) => a -> AB a -> Bool 
esABBAux r = foldAB True (\ri r rd -> if()) -}

ramas :: AB a -> [[a]]
ramas = foldAB [] (\ri r rd -> if null ri && null rd then [[r]] else map (r :) ri ++ map (r :) rd)

cantHojas :: AB a -> Int 
cantHojas = foldAB 0 (\ri r rd -> (if  (== 0) ri && (== 0) rd then 1 else 0) + ri + rd)