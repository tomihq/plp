{- max2 no esta currificada -}
max2 :: (Float, Float) -> Float
max2 (x, y) | x >= y = x
            | otherwise = y

normaVectorial:: (Float, Float) -> Float 
normaVectorial (x, y) = sqrt(x^2 + y^2)

{- substract esta currificada. -}
substract :: Float -> Float -> Float
substract = flip (-)

{- predecesor esta currificada -}
predecesor:: Float -> Float 
predecesor = substract 1

{- Aplicacion: evaluarEnCero (\x -> x+2 == 0) -}
evaluarEnCero :: (Float -> b) -> b
evaluarEnCero = \f -> f 0
{- \f es basicamente (\x -> x+2 == 0). El parámetro x que recibe es el 0 que se envía a f en evaluarCero. -}

{- dosVeces :: (a -> a) -> (a->a)
dosVeces f = \x -> f (f x)  -}

{-Pto B: Las no currificadas las paso a curry. Yo entiendo como que las funciones currificadas te dejan mas libertad de aplicarla parcialmente. -}
max2Curry :: Float -> Float -> Float 
max2Curry x y | x >= y = x
              | otherwise = y

max2CurryA :: Float -> Float 
max2CurryA = max2Curry 2

max2CurryB :: Float -> Float 
max2CurryB a = max2CurryA a


{- Pto 2. -}

curryOwn :: ((a, b) -> c) -> (a -> (b -> c))
curryOwn f a b = f (a, b)

sumTuple :: (Float, Float) -> Float
sumTuple (x, y) = x + y

sumarCurry :: Float -> Float -> Float
sumarCurry = curryOwn sumTuple

sumarCurryDescurrificar :: (Float, Float) -> Float
sumarCurryDescurrificar = decurryOwn sumarCurry

decurryOwn :: (a -> b -> c) -> ((a, b) -> c)
decurryOwn f (a, b) = f a b 

{- Este foldr recorre solo listas. -}
sumFoldrlist :: Num a => [a] -> a 
sumFoldrlist = foldr (\x ac -> x + ac) 0

{- Este foldr recorre cualquier tipo de estructura de datos que pueda recorrerse. -}
sumFoldr :: (Foldable t, Num a) => t a -> a 
sumFoldr = foldr (\x ac -> x + ac) 0

elemFoldr :: (Foldable t, Eq a) => a -> t a -> Bool
elemFoldr y = foldr(\x acum -> (x == y) || acum) False 

concatFoldr ::  [a] -> [a] -> [a]
concatFoldr xs ys = foldr(:) ys xs 

filterFoldr :: (a -> Bool) -> [a] -> [a]
filterFoldr f = foldr (\x acc -> if f x then x : acc else acc) []
{--
mapFoldr (\x -> x+1) [1, 2, 3]
    ac = [], x = 3, f(1):ac -> ac = [4]
    ac = [2], x = 2, f(2):ac -> ac = [3, 4]
    ac = [3, 4], x = 1, f(1):ac -> ac = [2, 3, 4]
--}
mapFoldr :: (a -> b) -> [a] -> [b]
mapFoldr f = foldr(\x ac -> f(x):ac) []

{--
Tipo del acum: es un elemento de la lista, es un a. En cada llamado recursivo retorno un elemento. 
MejorSegun(>) [5, 1, 2, 4]
acc = 4, 4 > 2? si. acc = 4
acc = 4, 4 > 1? si. acc = 4
acc = 4, 4 > 5? no. acc = 5
--}
mejorSegun :: Foldable t => (a -> a -> Bool) -> t a -> a 
mejorSegun f = foldr1(\x ac -> if f x ac then x else ac) 

sumasParciales :: Num a => [a] -> [a]
sumasParciales = reverse . foldl(\acc x -> if(length acc > 0) then x+(head acc):acc else x:acc) []
{-
sumaAlt
    [1, 2, 3]
    1 - [2, 3]
    1 - (2 - [3])
    1 - 2 - (3 - [])
            3
        2-3 = -1
    1 - (-1) = 2
-}
sumaAlt :: (Num a) => [a] -> a
sumaAlt =  foldr (-) 0

{-
sumaAltDer
    [1, 2, 3, 4] solo con foldl(-)
    (foldl(-) 0 [1, 2, 3, 4])
    (foldl(-) -1 [2, 3, 4]) 
    (foldl(-) -3 [3, 4])
    (foldl(-) -6 [4])
    (foldl(-) -10 [])

    Esto me esta haciendo 1-2-3-4. Yo necesito 4-3+2-1 = 2
    Lo que me produce foldl(flip(-)) es lo siguiente
    [1, 2, 3, 4]
    (foldl(flip(-)) 0 [1, 2, 3, 4])
    (foldl(flip(-)) 1-0 = 1 [2, 3, 4])
    (foldl(flip(-)) 2 - 1 = 2 [3, 4])
    (foldl(flip(-)) 3-1 = 2 [4])
    (foldl(flip(-)) 4-2 = 2 [])
-}
sumaAltDer :: (Num a) => [a] -> a 
sumaAltDer = foldl (flip (-)) 0 

{-5. La segunda es recursion estructural-}
entrelazar :: [a] -> [a] -> [a]
entrelazar = foldr(\x rec -> (\ys -> if null ys then x:rec [] else x:head ys: rec (tail ys))) id {-importantisimo el caso base: acá no es vacío sino la funcion id si es vacio.-}

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x : xs) = f x xs (recr f z xs)

{- 6a -}
sacarUna :: (Eq a) => a -> [a] -> [a]
sacarUna n = recr(\x xs rec  -> if x==n then xs else x:rec) [] {- recordar que siempre armo una nueva lista, entonces sacarlo seria no ponerlo-}
{- Sacar una no se puede implementar con recursión estructural pues acá necesito utilizar la cola de la lista en un lugar que no es el propio llamado recursivo. -}

sacarTodos :: (Eq a) => a -> [a] -> [a]
sacarTodos n = foldr(\x rec -> if x /= n then x:rec else rec) []

insertarOrdenado :: (Ord a) => a -> [a] -> [a]
insertarOrdenado n = foldr(\x rec -> if n<=x then n:x:rec else x:rec) [] {-recordar que siempre armo una nueva lista, si encuentro el valor primero pongo el menor, luego el del paso recursivo y luego la cola -}

genLista :: a -> (a->a) -> Integer -> [a]
genLista i f n = take (fromIntegral n) (iterate f i) {- iterate f i empieza una lista desde i y le aplica f: iterate (\x -> x+2) [1, 3, 5, 7] take hace un prevent de infinity. -}

desdeHasta ::  Integer -> Integer -> [Integer]
desdeHasta n m = genLista n succ (m - n + 1) 

{-mapPares:
    Necesito una funcion map que tome dos argumentos (pueden ser o no el mismo tipo a b y lo transforma en un tipo c)
    Luego necesito tomar una lista de pares del tipo que recibira el map (a, b) y luego devuelvo transformados en el tipo c.

-}
mapPares :: (a -> b -> c) -> [(a, b)] -> [c]
mapPares f = map (uncurry f) {-mapPares (\x y -> (x+1, y+2)) [(1, 2), (3, 4)]. Nota: usamos uncurry adentro del map porque los argumentos que vamos a aplicar estan como tuplas. -}

armarPares :: [a] -> [b] -> [(a, b)]
armarPares _ [] = []
armarPares [] _ = []
armarPares (x:xs) (y:ys) = (x, y) : armarPares xs ys 

{-
    Foldr: Solo puede recorrer una lista a la vez. Es importante saber que si nosotros mandamos más de un argumento que no entre dentro del foldr, esos argumentos tendrán que ir dentro del acumulador del caso recursivo.
    

    Es decir, en este ejercicio tenemos [a] -> [b] -> [(a, b)]. El foldr hace recursion sobre [a] pero ¿qué pasa con [b]? En este caso el caso recursivo espera que se envie por parámetro una lista [b]. Por lo tanto el tipo de rec es [b] -> [(a, b)]

    Por lo tanto, en este caso podemos ir "recorriendo" ambas listas al mismo tiempo porque podemos manipular la cabeza de la segunda lista y la primera a la vez, y como tenemos garantizado que el foldr va recorriendo la primera lista, lo que podemos hacer para ir achicando la segunda es mandar la cola de la segunda lista por argumento de la recursión.
-}
armarParesEst :: [a] -> [b] -> [(a, b)]
armarParesEst = foldr (\x rec l2 -> if null l2 then [] else (x, head l2) : rec (tail l2))(const [])

armarTriplasEst :: [a] -> [b] -> [c] -> [(a, b, c)]
armarTriplasEst = foldr(\x rec l2 l3 -> if null l2 then [] else (if null l3 then [] else (x, head l2, head l3):rec (tail l2) (tail l3))) (const (const []))

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f l r = mapPares f (armarParesEst l r)

sumaMatCorta :: (Int -> Int -> Int) -> [[Int]] -> [[Int]] -> [[Int]]
sumaMatCorta f = mapDoble(mapDoble(f))

{--x e y son listas. Caso prueba: sumaMat (\x y -> x+y) [[1, 2], [3, 4]] [[5, 6], [7, 8]]--}

{- trasponer :: [[Int]] -> [[Int]] -}
{-  
    Input: [[1, 2], [3, 4]]
        1 2 
        3 4

    Output: [[1, 3], [2, 4]]
        1 3  
        2 4 

    Necesito recorrer cada lista, tomando primero el primer elemento hasta la ultima sublista.
    1:[]
    3:[1] = [3, 1] luego reverse [3, 1] = [1, 3]

    Lo mismo con la segunda componente
    2:[]
    4:[2] = [4, 2] luego reverse [4, 2] = [2, 4]
-}
{-Definir y dar el tipo del esquema de recursión foldNat sobre los naturales. Utilizar el tipo Integer de
 Haskell

 Recordemos la estructura de foldr: (a -> b -> b) -> b -> t a -> b 
 Donde b es el caso base y a es la lista de elementos.
 En este caso yo voy a obtener un numero natural (una función) y otro natural. Esta funcion se aplica entre los dos naturales.
 -}
data Nat = Zero | Succ Nat

foldNat :: Integer -> (Integer -> Integer) -> Integer -> Integer 
foldNat base _ 0 = base 
foldNat base f n = f (foldNat base f (n-1))

multiplicacion :: Integer -> Integer -> Integer
multiplicacion n m = foldNat 0 (+n) m 

potencia :: Integer -> Integer -> Integer 
potencia n m = foldNat 1 (multiplicacion n) m

{-¿Como puedo generalizar esto usando Nat? Ej.: 2 \equiv Succ(Succ Zero) -}

data Polinomio a = X | Cte a | Suma (Polinomio a) (Polinomio a) | Prod (Polinomio a) (Polinomio a)
{-
Importante: Como tengo 4 constructores del tipo tengo 4 casos que considerar en la recursión. Lo mismo a la hora de probar.
x^2 + 5x + 1 
(Prod X X)
(Prod (Cte 5) X)
(Cte 1)

x^2 + 5x = (Suma (Prod X X) (Prod (Cte 5) X))
x^2 + 5x + 1 = Suma (Suma (Prod X X) (Prod (Cte 5) X)) (Cte 1) 

-}

{-foldPoli (1) id (devuelve el mismo valor que tiene en ese lugar) (+) (*) ((Suma (Prod X X) (Prod (Cte 5) X)))-}
foldPoli :: (b) -> (a -> b) -> (b -> b -> b) -> (b->b->b) -> Polinomio a -> b
foldPoli fx fcte fsuma fprod pol = case pol of 
                                   x -> fx 
                                   Cte c -> fcte c 
                                   Suma p q -> fsuma (rec p) (rec q)
                                   Prod p q -> fprod (rec p) (rec q)
            where rec = foldPoli fx fcte fsuma fprod
    
evaluar2 :: Num a => a -> Polinomio a -> a
evaluar2 x = foldPoli x id (+) (*)

data AB a = Nil | Bin (AB a) a (AB a) deriving Show

foldAB ::  (b -> a -> b -> b) -> b -> AB a  -> b 
foldAB _ b Nil = b 
foldAB f b (Bin i r d)  = f  (foldAB f b i) r (foldAB f b d)

{-La recursión primitiva sobre arboles es aplicarle la funcion a la rama izquierda y derecha-}
recAB :: b -> (a -> AB a -> AB a -> b -> b -> b) -> AB a -> b 
recAB z _ Nil = z
recAB z f (Bin izq r der) = f r izq der (recAB z f izq) (recAB z f der)

esNil :: AB a -> Bool 
esNil Nil = True 
esNil _ = False

altura :: AB a -> Integer  
altura = foldAB(\ri r rd -> 1 + max ri rd) 0

{-cantNodos (Bin Nil 1 (Bin Nil 2 Nil)) = 2-}
cantNodos :: AB a -> Integer 
cantNodos = foldAB (\ri r rd -> 1 + ri + rd) 0

{-Aca uso recursion primitiva porque me basta solamente con hacer un fold de ambos lados e ir comparando con la raiz. Es decir, me voy para un lado u otro segun corresponda. Si tengo que buscar el mayor voy hacia la derecha, si tengo que buscar el min voy hacia la izquierda-}
mejorSegunAB :: (a -> a -> Bool) -> AB a -> a 
mejorSegunAB f (Bin izq r der) = foldAB(\ri r rd -> if f r ri && f r rd then r else if f ri rd then ri else rd) r (Bin izq r der)

{- En este ejercicio necesito recursion primitiva porque necesito los subarboles izquierdo y derecho con sus valores respectivos para poder comparar con la raiz. -} 
esABB :: Ord a => AB a -> Bool 
esABB = recAB True (\r recIzq recDer ri rd -> menor r recDer && mayor r recIzq && ri && rd) 
    where mayor _ Nil = True 
          mayor r (Bin i r2 d) = r >= r2
          menor _ Nil  = True 
          menor  r (Bin i r2 d) = r <= r2

ramas :: AB a -> [[a]]
ramas = recAB [] (\r izq der caminosIzq caminosDer ->
    if null caminosIzq && null caminosDer
      then [[r]]
      else map (r:) caminosIzq ++ map (r:) caminosDer)

cantHojas :: AB a -> Int 
cantHojas = foldAB(\ri _ rd -> if ri == 0 && rd == 0 then 1 else ri + rd) 0 

espejo :: AB a -> AB a 
espejo  = foldAB(\ri r rd -> Bin rd r ri) Nil 

data AIH a = Hoja a | BinAIH (AIH a) (AIH a) deriving Show

{-
    b: Rec izq
    b: Rec der 
    b: Res 
    a: Hoja
    AIH a: Input
    b: res
-}
foldAIH :: (b -> b -> b) -> b -> AIH a -> b 
foldAIH _ b (Hoja v)  = b
foldAIH f b (BinAIH i d) = f (foldAIH f b i) (foldAIH f b d)

alturaAIH :: AIH a -> Int 
alturaAIH = foldAIH(\ri rd -> 1 + max ri rd) 0

tamaño :: AIH a -> Int 
tamaño = foldAIH(\ri rd -> ri + rd) 1 {-cuando llego a una hoja devuelvo 1-}

data RoseTree a = RT (a, [RoseTree a])
{-  
    La funcion va a recibir el valor de a.
    La funcion recursiva va a recibir n hijos (resueltos por un map, [b]).
    Devuelve un resultado b. 
    Necesito un caso base (b)
    El parametor de RoseTree a 
    Devuelve un b.

    La primera recursion termina anidando los primeros hijos
-}
foldRT :: (a -> [b] -> b)  -> RoseTree a -> b
foldRT f (RT (value, children)) = f value (map (foldRT f) children)

hojasRT :: RoseTree a -> [a]
hojasRT = foldRT(\v hijos -> if length hijos == 0 then [v] else concat hijos) {-como cada RT tiene mas de 1 hijo, el concat los aplana-}
