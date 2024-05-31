import Prelude hiding (read)

{- In the standard library, cannot be overridden

instance Monad ((->) r) where  
    return :: a -> (r -> a)
    return x = \_ -> x  

    >>= :: (r -> a) -> (a -> r -> b) -> r -> b
    h >>= f = \w -> f (h w) w
    -- h ha tipo  (r -> a)
    -- f ha tipo  (a -> r -> b)
    -- w ha tipo r
    -- (h w) ha tipo a
    -- f (h w) w ha tipo b

-}

read :: r -> r
read = id

age :: String -> [(String,Int)] -> Int
age x =
 do
   m <- read
   let a = case lookup x m of Just x -> x ; Nothing -> -1
   return a

family :: [(String,Int)] -> (Int,Int,Int)
family =
 do
   x <- age "Claudio"
   y <- age "Barbara"
   z <- age "Pietro"
   return (x,y,z)

answer :: (Int,Int,Int)
answer =
 let persons = [("Claudio",41),("Fabrizio",41),("Pietro",10),("Barbara",40)] in
 family persons
