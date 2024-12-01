import Data.List

data Buffer a = Empty | Write Int a (Buffer a) | Read Int (Buffer a) deriving Show

foldBuffer :: b -> (Int -> a -> b -> b) -> (Int -> b -> b) -> Buffer a -> b
foldBuffer fBase fWrite fRead buf = case buf of 
        Empty -> fBase
        Write n a b -> fWrite n a (rec b)
        Read n b -> fRead n (rec b)
    where rec = foldBuffer fBase fWrite fRead

recBuffer :: b -> (Int -> a -> Buffer a -> b -> b) -> (Int -> Buffer a -> b -> b) -> Buffer a -> b
recBuffer fBase fWrite fRead buf = case buf of 
        Empty -> fBase
        Write n a b -> fWrite n a b (rec b)
        Read n b -> fRead n b (rec b)
    where rec = recBuffer fBase fWrite fRead

contenidoLeido :: Buffer a -> [Int]
contenidoLeido = foldBuffer [] (\b _ res -> union [b] res) (\_ res -> res)

contenido :: Int -> Buffer a -> Maybe a 
contenido buf = foldBuffer Nothing (\b v rec -> if b == buf then Just v else rec)(\b rec -> if buf == b then Nothing else rec)

{- Idea: reutilizar contenido, le mando el buffer y la cola de buffers y me fijo. Si me da Nothing entonces devuelvo false. Caso base true.
Como mi tipo no acepta Eq a, entonces no puedo usar == Nothing. Tengo que usar caso a caso en base a lo que retorna contenido.
-}
puedeCompletarLecturas :: Buffer a -> Bool
puedeCompletarLecturas = recBuffer True (\_ _ _ rec -> rec) (\b bs rec -> case contenido b bs of
        Nothing -> False 
        Just _  -> rec)



