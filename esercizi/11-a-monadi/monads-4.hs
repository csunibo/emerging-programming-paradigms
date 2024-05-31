data Exp = Plus  Exp Exp
         | Minus Exp Exp
         | Times Exp Exp
         | Div   Exp Exp
         | Const Prelude.Int

eval :: Exp -> Maybe Int
eval (Plus  e1 e2) =
 do
  x1 <- eval e1
  x2 <- eval e2
  return (x1 + x2)
eval (Minus  e1 e2) =
 do
  x1 <- eval e1
  x2 <- eval e2
  return (x1 - x2)
eval (Times  e1 e2) =
 do
  x1 <- eval e1
  x2 <- eval e2
  return (x1 * x2)
eval (Div  e1 e2) =
 do
  x1 <- eval e1
  x2 <- eval e2
  if x2 == 0 then Nothing else return (x1 `div` x2)
eval (Const i) = return i

answer = eval (Div (Plus (Const 4) (Const 2)) (Const 3))
