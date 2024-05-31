data Exp = Plus  Exp Exp
         | Minus Exp Exp
         | Times Exp Exp
         | Div   Exp Exp
         | Const Int

eval :: Exp -> Maybe Int
eval (Plus  e1 e2) =
 case eval e1 of
    Nothing -> Nothing
    Just x1 ->
        case eval e2 of
           Nothing -> Nothing
           Just x2 -> Just (x1 + x2)
eval (Minus  e1 e2) =
 case eval e1 of
    Nothing -> Nothing
    Just x1 ->
        case eval e2 of
           Nothing -> Nothing
           Just x2 -> Just (x1 - x2)
eval (Times  e1 e2) =
 case eval e1 of
    Nothing -> Nothing
    Just x1 ->
        case eval e2 of
           Nothing -> Nothing
           Just x2 -> Just (x1 * x2)
eval (Div  e1 e2) =
 case eval e1 of
    Nothing -> Nothing
    Just x1 ->
        case eval e2 of
           Nothing -> Nothing
           Just x2 ->
              if x2 == 0 then Nothing else Just (x1 `div` x2)
eval (Const i)     = Just i

answer = eval (Div (Plus (Const 4) (Const 2)) (Const 3))
