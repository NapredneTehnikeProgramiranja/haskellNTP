module SimpleProfiling
  ( simpleProfiling
  ) where

simpleProfiling = print (f 30 + g 30)
  where
    f n = fib n
    g n = fib (n `div` 2)

fib :: (Num t, Num a, Eq a) => a -> t
fib 0 = 1
fib 1 = 0
fib n = fib (n - 1) + fib (n - 2)
