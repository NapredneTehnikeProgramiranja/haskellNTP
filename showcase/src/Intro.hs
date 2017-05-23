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
