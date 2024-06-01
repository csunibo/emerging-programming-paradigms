f :: IO ()
f =  putStrLn "Hello" >> putStrLn "Hello" >> putStrLn "World"

g :: IO ()
g =
  let x = putStrLn "Hello"
  in x >> x >> putStrLn "World"

main :: IO ()
main = f >> g
