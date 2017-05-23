module Intro where

-- this is a declaration
x :: Int
x = 23
{- this was declaration with some long long multi-line comment which
 exceeds standard line lenght in my editor
-}

-- x = 42
-- src/Intro.hs:10:1: error: …
--     Multiple declarations of ‘x’
--     Declared at: /home/novak/haskell/haskellNTP/showcase/src/Intro.hs:5:1
--                  /home/novak/haskell/haskellNTP/showcase/src/Intro.hs:10:1
-- Compilation failed.

b :: Int
b = b + 1

biggestInt, smallestInt :: Int
biggestInt = maxBound
smallestInt = minBound
-- λ> biggestInt
-- 9223372036854775807
-- λ> smallestInt
-- -9223372036854775808

bigInteger :: Integer
bigInteger = 1234567890987654321987340982334987349872349874534
-- λ> bigInteger
-- 1234567890987654321987340982334987349872349874534

reallyBig :: Integer
reallyBig = 2^(2^(2^(2^2)))

digitsNumOfReallyBig :: Int
digitsNumOfReallyBig = length (show reallyBig)
-- λ> digitsNumOfReallyBig
-- 19729

d1, d2 :: Double
d1 = 4.5387
d2 = 6.2831e-4
-- λ> d1
-- 4.5387
-- λ> d2
-- 6.2831e-4

b1, b2 :: Bool
b1 = True
b2 = False

c1, c2, c3 :: Char
c1 = 'x'
c2 = 'Ø'
c3 = 'ダ'

s :: String
s = "Hello, Haskell!"

ex01 = 3 + 2
ex02 = 19 - 27
ex03 = 2.35 * 8.6
ex04 = 8.7 / 3.1
ex05 = mod 19 3
ex06 = 19 `mod` 3
ex07 = 7 ^ 222
ex08 = (-3) * (-7)

-- badArith = x + bigInteger
-- <interactive>:73:5-14: error:
--     • Couldn't match expected type ‘Int’ with actual type ‘Integer’
--     • In the second argument of ‘(+)’, namely ‘bigInteger’
--       In the expression: x + bigInteger
--       In an equation for ‘it’: it = x + bigInteger

goodArith = x + fromInteger(bigInteger)
-- λ> goodArith
-- 7636536262163761533

-- one = x / x
-- <interactive>:80:1-5: error:
--     • No instance for (Fractional Int) arising from a use of ‘/’
--     • In the expression: x / x
--       In an equation for ‘it’: it = x / x

one = x `div` x
-- λ> one
-- 1

ex11 = True && False
ex12 = not (False || True)

ex13 = ('a' == 'a')
ex14 = (16 /= 3)
ex15 = (5 > 3) && ('p' <= 'q')
-- What is this?
ex16 = "Haskell" > "C++"

-- Compute the sum of the integers from 1 to n.
sumtorial :: Integer -> Integer
sumtorial 0 = 0
sumtorial n = n + sumtorial (n-1)

hailstone :: Integer -> Integer
hailstone n
  | n `mod` 2 == 0 = n `div` 2
  | otherwise      = 3*n + 1

foo :: Integer -> Integer
foo 0 = 16
foo 1
  | "Haskell" > "C++" = 3
  | otherwise         = 4
foo n
  | n < 0            = 0
  | n `mod` 17 == 2  = -43
  | otherwise        = n + 3
