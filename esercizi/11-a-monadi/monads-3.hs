import Prelude hiding (return, (>>=))

data Exp = Plus  Exp Exp
         | Minus Exp Exp
         | Times Exp Exp
         | Div   Exp Exp
         | Const Prelude.Int

-- >>= is spelled "bind"
(>>=) :: Maybe a -> (a -> Maybe b) -> Maybe b
Nothing >>= f = Nothing
Just a >>= f = f a

return :: a -> Maybe a
return x = Just x

eval :: Exp -> Maybe Int
eval (Plus  e1 e2) =
 eval e1 >>= \x1 ->
 eval e2 >>= \x2 ->
 return (x1 + x2)
eval (Minus  e1 e2) =
 eval e1 >>= \x1 ->
 eval e2 >>= \x2 ->
 return (x1 - x2)
eval (Times  e1 e2) =
 eval e1 >>= \x1 ->
 eval e2 >>= \x2 ->
 return (x1 * x2)
eval (Div  e1 e2) =
 eval e1 >>= \x1 ->
 eval e2 >>= \x2 ->
 if x2 == 0 then Nothing else return (x1 `div` x2)
eval (Const i) = return i

answer = eval (Div (Plus (Const 4) (Const 2)) (Const 3))
