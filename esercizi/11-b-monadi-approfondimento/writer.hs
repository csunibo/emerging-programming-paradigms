double :: (Int,[Char]) -> (Int,[Char])
double (n,m) =
 let m' = m ++ "\n double called" in
 (n*n, m')

f :: (Int,[Char]) -> (Int,[Char])
f (n,m) =
 let m' = m ++ "\n f called" in
 let (x,m'') = double (n,m') in
 double (x,m'')

f (2,"") === 16,"f called double called double called"


La mia monade "m a" è: (a, [Char])

return x = x,""

(x,m) >>= f =
 let (y,m') = f x in
 (y, m ++ "\n" ++ m')

tell m = (),m

==================

double n =
 do
  tell "double called"
  return (n * n)

==================

Obiettivo: scrivere funzioni che hanno un costo (in denaro) e voglio fare output in maniera write-only del costo

Uso per il costo il monoide (Int, 0, +)

trametti : Int -> Writer Int ()
trasmetti n =
 do
  tell 2  -- faccio pagare 2
  ....
  if n = 0 then return () else trametti (n - 1)

trasmetti 5 === ((), 10)

=============================

senza sintassi do:

trasmetti n =
 tell 2 >> if n = 0 then return () else trasmetti (n - 1)

senza fish:

trasmetti n =
 tell 2 >>= \_ . if n = 0 then return () else trasmetti (n - 1)

espando bind e return

trasmetti n =
 -- tell 2 è ((),2)
 let (y,v') =  (\_. if n = 0 then ((),0) else trasmetti (n - 1)) () in
 (y,2 + v')

semplifico

tramsetti n =
 let (y,v') = if n = 0 then ((),0) else trasmetti (n - 1) in
 (y, 2 + v')
