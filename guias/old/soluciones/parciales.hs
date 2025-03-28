data Prop = Var String | No Prop | Y Prop Prop | O Prop Prop | Imp Prop Prop 
type Valuacion = String -> Bool 

foldProp :: (String -> a) -> (a -> a) -> (a -> a -> a) -> (a -> a -> a) -> (a -> a -> a) -> Prop -> a
foldProp fvar _ _ _ _ (Var s) = fvar s
foldProp fvar fnot fand for fimp (prop) = case prop of 
    (No p) -> fnot (recn p)
    (Y p1 p2) -> fand (recn p1) (recn p2) 
    (O p1 p2) -> for (recn p1) (recn p2)
    (Imp p1 p2) -> fimp (recn p1) (recn p2)
    where recn = foldProp fvar fnot fand for fimp 

recProp :: (String -> a) -> (Prop -> a -> a) -> (Prop -> Prop -> a -> a -> a) -> (Prop -> Prop -> a -> a -> a) -> (Prop -> Prop -> a -> a -> a) -> Prop -> a 
recProp fvar _ _ _ _ (Var s) = fvar s 
recProp fvar fnot fand for fimp (prop) = case prop of 
    (No p) -> fnot p (recn p)
    (Y p1 p2) -> fand p1 p2 (recn p1) (recn p2) 
    (O p1 p2) -> for p1 p2 (recn p1) (recn p2)
    (Imp p1 p2) -> fimp p1 p2 (recn p1) (recn p2)
    where recn = recProp fvar fnot fand for fimp 

nub :: Eq a => [a] -> [a]
nub [] = []
nub (x:xs) = x : filter(\y -> x /= y) (nub xs)

variables :: Prop -> [String]
variables = foldProp(\s -> [s]) id f f f 
            where f = (\p1 p2 -> p1 ++ p2)

variablesSinRep :: Prop -> [String]
variablesSinRep p = nub (variables p)


data AT a = Nil | Tri a (AT a) (AT a) (AT a)
foldAT :: (a -> b -> b -> b -> b) -> b -> AT a -> b
foldAT _ b Nil = b 
foldAT f b (Tri r i c d) = f r (foldAT f b i) (foldAT f b c) (foldAT f b d)

preorder::AT a -> [a]
preorder = foldAT(\r i c d -> r:(i++c++d)) []

nivel :: AT a -> Int -> [a]
nivel = foldAT(\r i c d -> \n -> if n == 0 then [r] else ((i n-1) ++ (c n-1) ++ (d n-1))) (const [])