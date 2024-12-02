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

data Prop = Var String | No Prop | Y Prop Prop | O Prop Prop | Imp Prop Prop

type Valuacion = String -> Bool

foldProp :: (String -> b) -> (b -> b) -> (b -> b -> b) -> (b -> b -> b) -> (b -> b -> b) -> Prop -> b
foldProp fBase fNot fAnd fOr fImp prop = case prop of 
        Var s -> fBase s
        No p -> fNot (rec p)
        Y p1 p2 -> fAnd (rec p1) (rec p2)
        O p1 p2 -> fOr (rec p1) (rec p2)
        Imp p1 p2 -> fImp (rec p1) (rec p2)

    where rec = foldProp fBase fNot fAnd fOr fImp

recProp :: (String -> b) -> (Prop -> b -> b) -> (Prop -> Prop -> b -> b -> b) -> (Prop -> Prop -> b -> b -> b) -> (Prop -> Prop -> b -> b -> b) -> Prop -> b
recProp fBase fNot fAnd fOr fImp prop = case prop of 
        Var s -> fBase s
        No p -> fNot p (rec p)
        Y p1 p2 -> fAnd p1 p2 (rec p1) (rec p2)
        O p1 p2 -> fOr p1 p2 (rec p1) (rec p2)
        Imp p1 p2 -> fImp p1 p2 (rec p1) (rec p2)

    where rec = recProp fBase fNot fAnd fOr fImp

{- La funcion que necesito es agregar las variables (no tiene rec, es caso base). Como el constructor No Prop
Es recursivo pero solamente devuelve una unica cosa, uso un id es decir, que no haga practicamente nada.
Ahora, los demas casos recursivos, tengo que de alguna manera "concatenar" las llamadas recursivas sin hacer nada.
Para hacer eso, simplemente hago la union (es decir, voy bajando por la rama de ese constructor hasta llegar un valor que matchee con el caso base y lo agrego en la lista)
 -}
variables :: Prop -> [String]
variables = foldProp(\s -> [s]) id union union union

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
data AT a = NilT | Tri a (AT a) (AT a) (AT a)

at1 = Tri 1 (Tri 2 NilT NilT NilT) (Tri 3 (Tri 4 NilT NilT NilT) NilT NilT) (Tri 5 NilT NilT NilT)

foldAt :: b -> (a -> b -> b -> b -> b) -> AT a -> b 
foldAt fBase fTri at = case at of 
        NilT -> fBase
        Tri r i m d -> fTri r (rec i) (rec m) (rec d)
    where rec = foldAt fBase fTri

preorder :: AT a -> [a]
preorder = foldAt [] (\r i m d -> [r] ++ i ++ m ++ d)

mapAT :: (a -> b) -> AT a -> AT b 
mapAT f = foldAt NilT (\r i m d -> Tri (f r) i m d)

{- solo me hace falta agregar la raiz de cada rama cuando baje hasta donde quiero. 
    Ej.: Si no es el nivel 0 (raiz), entonces abro 3 ramas. Cuando las 3 ramas lleguen al n deseado, simplemente agrego la raiz de esa rama recursiva.
-}
{- nivel :: AT a -> Int -> [a] -}
{- nivel = foldAt (const []) (\r i m d -> (\n -> if n == 0 then [r] else ((i n-1) ++ (m n-1) ++ (d n-1) ))) -}

