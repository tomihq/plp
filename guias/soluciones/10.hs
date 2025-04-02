genLista :: (Integral b, Enum a) => a -> (a -> a) -> b -> [a]
genLista i f n = take (fromIntegral n :: Int) [x | x <- [i, f i..]]

desdeHasta :: (Integral a) => (a, a) -> [a]
desdeHasta (a,b) = genLista a (+1) (b - a + 1)