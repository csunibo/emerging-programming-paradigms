data Exp = Plus  Exp Exp
         | Minus Exp Exp
         | Times Exp Exp
         | Div   Exp Exp
         | Const Int

eval :: Exp -> Int
eval (Plus  e1 e2) = (eval e1) + (eval e2)
eval (Minus e1 e2) = (eval e1) - (eval e2)
eval (Times e1 e2) = (eval e1) * (eval e2)
eval (Div   e1 e2) = (eval e1) `div` (eval e2)
eval (Const i)     = i

answer = eval (Div (Plus (Const 4) (Const 2)) (Const 3))
