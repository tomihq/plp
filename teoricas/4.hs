data Val = VN Int | VB Bool deriving Eq

addVal :: Val -> Val -> Val 
addVal (VN n) (VN m) = VN (n+m)
addVal _ _ = error "Algún sumando no es numérico"

instance Show Val where 
    show = showVal 
        where 
            showVal :: Val -> String 
            showVal (VN n) = show n
            showVal (VB b) = show b

data Expr = EConstNum Int | EConstBool Bool | EAdd Expr Expr  

instance Show Expr where
    show = showExpr
      where 
        showExpr :: Expr -> String 
        showExpr (EConstNum n) = show n
        showExpr (EConstBool b) = show b 
        showExpr (EAdd e1 e2) = "(" ++ show e1 ++ "+" ++ show e2 ++ ")"

evalExpr :: Expr -> Val
evalExpr (EConstNum n)  = VN n
evalExpr (EConstBool b) = VB b
evalExpr (EAdd n m) = addVal (evalExpr n) (evalExpr m)