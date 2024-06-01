newtype Writer w a = Writer { runWriter :: (a, w) } deriving Show

instance Functor (Writer w) where
 fmap f (Writer (a,w)) = Writer (f a,w)

instance Monoid w => Applicative (Writer w) where
 pure x = Writer (x, mempty)
 Writer (f,m1) <*> Writer (x,m2) = Writer (f x, m1 `mappend` m2)

instance (Monoid w) => Monad (Writer w) where  
 return = pure
 (Writer (x,v)) >>= f = let (Writer (y, v')) = f x in Writer (y, v `mappend` v')

tell :: Monoid w => w -> Writer w ()
tell m = Writer ((),m)

double :: Int -> Writer [Char] Int
double n =
  do
     tell "double called"
     return (n * n)

f :: Int -> Writer [Char] Int
f n =
  do
     tell "f called "
     x <- double n
     double x
