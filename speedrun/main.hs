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


data Componente = Contenedor | Motor | Escudo | Cañon deriving Eq
data NaveEspacial = Módulo Componente NaveEspacial NaveEspacial | Base Componente deriving Eq 

recNave :: (Componente -> NaveEspacial -> NaveEspacial -> b -> b -> b) -> (Componente -> b) -> NaveEspacial -> b 
recNave fNave fBase nave = case nave of  
    Módulo c n1 n2 -> fNave c n1 n2 (rec n1) (rec n2)
    Base c -> fBase c 
    where rec = recNave fNave fBase

foldNave :: (Componente -> b -> b -> b) -> (Componente -> b) -> NaveEspacial -> b 
foldNave fModulo fBase = recNave(\c _ _ n1 n2 -> fModulo c n1 n2) fBase

espejo :: NaveEspacial -> NaveEspacial
espejo = foldNave(\c n1 n2 -> Módulo c n2 n1) Base

{- Dada dos naves. Indica si la primera esta contenido dentro de la segunda.
    Debe suceder que la NaveEspacial (primera) este en la segunda nave como subarboles sin otros componentes mas abajo, y ademas, no tienen que ser iguales a la segunda nave.
-}
esSubnavePropia :: NaveEspacial -> NaveEspacial -> Bool 
esSubnavePropia n1 = recNave(\_ sn1 sn2 r1 r2 -> sn1 == n1 || sn2 == n1 || r1 || r2) (const False) 

truncar :: NaveEspacial -> Integer -> NaveEspacial
truncar = recNave(\c sn1 sn2 r1 r2 -> (\i -> (if i == 0 then (Base c) else Módulo c (r1 (i-1)) (r2 (i-1))))) (\c -> (\i -> (Base c)))