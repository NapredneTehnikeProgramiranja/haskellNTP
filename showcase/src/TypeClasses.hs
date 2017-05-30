module TypeClasses where

import           Data.Char (ord)

data Foo
  = I Int
  | C Char

instance Eq Foo where
  (I x) == (I y) = x == y
  (C x) == (C y) = x == y
  (C x) == (I y) = ord x == y
  (I x) == (C y) = x == ord y
-- λ> C 'a' == I 97
-- True
-- λ> C 'a' == I 99
-- False

data Bar a =
  B [a]
  deriving (Eq, Show)
-- λ> B [1, 2, 3] == B [1, 2, 3]
-- True
-- λ> B [1, 2, 3] == B [1, 2, 3, 3]
-- False
