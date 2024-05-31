data Exp = Plus  Exp Exp
         | Minus Exp Exp
         | Times Exp Exp
         | Div   Exp Exp
         | Sqrt  Exp
         | Const Int

isqrt :: Int -> Int
isqrt = floor . sqrt . fromIntegral

eval :: Exp -> [Int]
eval (Plus e1 e2) = [ x1 + x2 | x1 <- eval e1, x2 <- eval e2 ]
eval (Minus e1 e2) = [ x1 - x2 | x1 <- eval e1, x2 <- eval e2 ]
eval (Times e1 e2) = [ x1 * x2 | x1 <- eval e1, x2 <- eval e2 ]
eval (Div e1 e2) = [ x1 `div` x2 | x1 <- eval e1, x2 <- eval e2 ]
eval (Sqrt e1) = let l1 = eval e1 in [ isqrt x1 | x1 <- l1 ] ++ [ -(isqrt x1) | x1 <- l1 ]
eval (Const i) = [i]

answer = eval (Div (Plus (Sqrt (Const 4)) (Sqrt (Const 4))) (Const 2))
