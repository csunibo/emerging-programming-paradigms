newtype State s a = State { runState :: s -> (a,s) }  

instance Functor (State s) where
  fmap f (State g) = State (\s -> let (a,s') = g s in (f a,s'))

instance Applicative (State s) where
  pure = return
  (State f) <*> (State x) =
     State (\s ->
       let (g,s') = f s
           (y,s'') = x s'
       in (g y, s''))

instance Monad (State s) where  
    return x = State $ \s -> (x,s)  
    (State h) >>= f = State $ \s -> let (a, newState) = h s  
                                        (State g) = f a  
                                    in  g newState 

get :: State s s
get = State (\s -> (s,s))

put :: s -> State s ()
put s = State (\_ -> ((),s))

incr :: State Int ()
incr =
 do
    n <- get
    put (n + 1)

f :: State Int (Int,Int)
f =
 do
  m <- get
  incr
  incr
  n <- get
  return (m,n)

answer :: (Int,Int)
answer =
 let (State g) = f
     (r,_) = g 3
 in r
