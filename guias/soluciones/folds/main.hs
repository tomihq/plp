data Operador = Sumar Int | DividirPor Int | Secuencia [Operador] deriving Show

foldOpe :: (Int -> b) -> (Int -> b) -> ([b] -> b) -> Operador -> b 
foldOpe fSuma fDiv fSec op = case op of 
    Sumar n -> fSuma n 
    DividirPor n -> fDiv n
    Secuencia ops -> fSec $ map(foldOpe fSuma fDiv fSec) ops

falla :: Operador -> Bool
falla = foldOpe(const False)(==0)(elem True)

aplanarSecuencias :: Operador -> [Operador] 
aplanarSecuencias (Secuencia ops) = ops
aplanarSecuencias ops = [ops]

aplanar :: Operador -> Operador
aplanar = foldOpe (\n -> Sumar n)(\n -> DividirPor n) (\r -> Secuencia(concatMap aplanarSecuencias r))

componerTodas :: [a -> a] -> (a -> a)
componerTodas = foldl (.) id {-((F1 . F2) . F3) con foldr seria (F1 . (F2 . (F3))). id es para que cuando llegue al caso base simplemente retorne lo que armó-}

aplicar :: Operador -> Int -> Maybe Int
aplicar op n 
    | falla op = Nothing
    | otherwise = Just (componerTodas fun n)
            where fun = reverse(foldOpe
                        (\x -> [(+ x)])
                        (\x -> [flip div x])
                        concat
                        (aplanar op))
