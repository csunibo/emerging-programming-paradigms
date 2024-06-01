Nothing >>= f = Nothing
(Just x) >> f = f x

return x = Just x


return x >> f = Just x >>= f = f x

  m >>= return
= case m of
     Nothing -> Nothing
   | Just x -> return x
= case m of
     Nothing -> Nothing
   | Just x -> Just x
= m


(m >>= f) >>= g
= (case m of
     Nothing -> Nothing
   | Just x -> f x) >>= g
= case m of
     Nothing -> Nothing >>= g
   | Just x -> f x >>= g
= case m of
     Nothing -> Nothing
   | Just x -> (\x. f x >>= g) x
= m >>= \x. f x >>= g
