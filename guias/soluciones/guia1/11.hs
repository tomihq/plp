data Polinomio a = X | Cte a | Suma (Polinomio a) (Polinomio a) | Prod (Polinomio a) (Polinomio a) deriving Show

foldPoli :: b -> (a -> b) -> (b -> b -> b) -> (b -> b -> b) -> Polinomio a -> b 
foldPoli fx fCte fSum fProd pol = case pol of 
    x -> fx 
    Cte a -> fCte a 
    Suma a b -> fSum (rec a) (rec b) 
    Prod a b -> fProd (rec a) (rec b)
    where rec = foldPoli fx fCte fSum fProd 

evaluar :: Num a => a -> Polinomio a -> a
evaluar n = foldPoli n id (+) (*)