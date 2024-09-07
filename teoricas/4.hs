data Val = VN Int | VB Bool | VS String deriving Eq

type Id = String 

data Env a = EmptyEnv | ExtendEnv (Env a) Id a 

emptyEnv :: Env a
emptyEnv = EmptyEnv

lookupEnv :: Env a -> Id -> a
lookupEnv  EmptyEnv _ = error "Variable no encontrada en el entorno"
lookupEnv (ExtendEnv env y val)  x
    | x == y    = val
    | otherwise = lookupEnv env x

extendEnv :: Env a -> Id -> a -> Env a
extendEnv env key value = ExtendEnv env key value

addVal :: Val -> Val -> Val 
addVal (VN n) (VN m) = VN (n+m)
addVal _ _ = error "Algún sumando no es numérico"

instance Show Val where 
    show = showVal 
        where 
            showVal :: Val -> String 
            showVal (VN n) = show n
            showVal (VB b) = show b
            showVal (VS s) = show s
data Expr = EConstNum Int 
            | EConstBool Bool 
            | EAdd Expr Expr  
            | ELet Id Expr Expr 
            | EVar Id

instance Show Expr where
    show = showExpr
      where 
        showExpr :: Expr -> String 
        showExpr (EConstNum n) = show n
        showExpr (EConstBool b) = show b 
        showExpr (EAdd e1 e2) = "(" ++ show e1 ++ "+" ++ show e2 ++ ")"
        showExpr (ELet x e1 e2) = "let " ++ x ++ " = " ++ show e1 ++ " in " ++ show e2
        showExpr (EVar x) = x

evalExpr :: Expr -> Env Val -> Val
evalExpr (EConstNum n) _  = VN n
evalExpr (EConstBool b) _ = VB b
evalExpr (EAdd n m) env = addVal (evalExpr n env) (evalExpr m env)
evalExpr (EVar x) env = lookupEnv env x
evalExpr (ELet x e1 e2) env = 
                let v = evalExpr e1 env 
                    env' = extendEnv env x v 
                in evalExpr e2 env'