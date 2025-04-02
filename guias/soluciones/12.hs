data AB a = Nil | Bin (AB a) a (AB a)

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