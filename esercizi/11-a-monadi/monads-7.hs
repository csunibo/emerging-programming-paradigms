data Exp = Plus  Exp Exp
         | Minus Exp Exp
         | Times Exp Exp
         | Div   Exp Exp
         | Sqrt  Exp
         | Const Prelude.Int

isqrt :: Int -> Int
isqrt = floor . sqrt . fromIntegral

eval :: Exp -> [Int]
eval (Plus e1 e2) =
 do
  x1 <- eval e1
  x2 <- eval e2
  return (x1 + x2)
eval (Minus e1 e2) =
 do
  x1 <- eval e1
  x2 <- eval e2
  return (x1 - x2)
eval (Times e1 e2) =
 do
  x1 <- eval e1
  x2 <- eval e2
  return (x1 * x2)
eval (Div e1 e2) =
 do
  x1 <- eval e1
  x2 <- eval e2
  return (x1 `div` x2)
eval (Sqrt e1) =
 do
  x1 <- eval e1
  [isqrt x1, -(isqrt x1)]
eval (Const i) = return i

answer = eval (Div (Plus (Sqrt (Const 4)) (Sqrt (Const 4))) (Const 2))
