{-# OPTIONS_GHC -Wall #-}

module Main where

--------------------------------------------------------------------------------
-- Simple profiling

-- main :: IO ()
-- main = print (f 30 + g 30)
--   where
--     f n = fib n
--     g n = fib (n `div` 2)

-- fib :: (Num t, Num a, Eq a) => a -> t
-- fib 0 = 1
-- fib 1 = 0
-- fib n = fib (n - 1) + fib (n - 2)

--------------------------------------------------------------------------------
-- Explicit cost center insertation

main :: IO ()
main = do print $ {-# SCC last_xs #-} last xs
          print $ {-# SCC last_init_xs #-} last $ init xs
          print $ {-# SCC last_ys #-} last ys
          print $ {-# SCC last_init_ys #-} last $ init ys
          where xs = [1..1000000]
                ys = [1..2000000]
