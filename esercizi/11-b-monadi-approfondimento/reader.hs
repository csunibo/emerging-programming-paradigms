f :: Int -> State -> String
f n stato =
 let y = g (n + 1) stato in
 return "ciao"

tutte le funzione come ultimo argomento prendono lo stato

ovvero

f :: Int -> State -> String

prende un intero e lo stato e restituisce una stringa

che posso vedere com

f :: Int -> ((->) State String)
             ^^^^^^^^^^
             è la monade!
             e state è la mia r, ovvero il tipo di quello che leggo

========================

return x = \stato -> x
-- h :: m a       ovvero  h :: stato -> a
-- f :: a -> m b  ovvero  f :: a -> stato -> b
-- h >> f :: m b  ovvero  h >> f :: stato -> b
h >> f = \stato -> f (h stato) stato

-- read :: m stato  ovvero read :: stato -> stato
read stato = stato


family =
 do
  x <- age "Claudio" 
  y <- age "Barbara" 
  return (x,y)

ovvero

family =
 age "Claudio" >>= \x.
 age "Barbara" >>= \y.
 return (x,y)

ovvero

family =
 \stato.
   (\x.
     \stato'.
       (\y.\stato''. (x,y))
       (age "Barbara" stato') stato')
   (age "Claudio" stato) stato

ovvero

family stato =
  (\y. \stato''. (age "Claudio" stato , y))
  (age "Barbara" stato) stato

ovvero

family stato =  (age "Claudio" stato , age "Barbara" stato)
