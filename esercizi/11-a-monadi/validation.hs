-- Prima possibilità: mi interessa solo il primo errore
data maybe_error e a =
   Just a
 | Error e


instance Monad (maybe_error e) where
  return :: a -> maybe_error e a
  return x = Just x

  (>>=) :: maybe_error e a -> (a -> maybe_error e b) -> maybe_error e b
  Error y >>= f = Error y
  Just a >>= f = f a


valida_nome :: string -> maybe_error string string
valida_nome [] = Error "la stringa è vuota"
valida_nome s = return s

valida_password :: string -> maybe_error string string
...

valida :: string -> string -> maybe_error string (string,string)
valida nome password =
 do
  x <- valida_nome nome
  y <- valida_password passwd
  return (x,y)

-- Seconda possibilità: mi interessano una combinazione di tutti gli errori
-- esempi: tutti, solo i primi 3, il più critico, etc.

data maybe_errorl e a =
   Errorl e a
 | Justl a

instance SemiGroup e => Monad (maybe_errorl e) where
  return :: a -> maybe_errorl e a
  return x = Justl x

  (>>=) :: maybe_errorl e a -> (a -> maybe_errorl e b) -> maybe_errorl e b
  Errorl e a >> f =
   case f a where
     Justl x -> Errorl e x
   | Errorl e' x -> Errorl (e `op` e') x
  Justl x >>= f = f x

-- esempio: tengo solo i primi 2 errori
instance SemiGroup [a] where
 `op` :: [a] -> [a] -> [a]
 op [] l = l
 op [x] [] = [x]
 op [x] (y:_) = [x,y]
 op (x:y:_) _ = [x,y]

valida :: string -> string -> maybe_errorl [string] (string,string)
...
