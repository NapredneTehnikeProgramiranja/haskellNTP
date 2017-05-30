module Functions where

aFoo :: (String, Integer) -> [Integer] -> [Integer]
aFoo _ []      = []
aFoo (x, xx) y = map (* xx) y
-- λ> aFoo ("dsa", 22) [1,2,3]
-- [22,44,66]

aFoo1 _ [] = []
aFoo1 (x, xx) y =
  case y of
    y:[]      -> [y]
    otherwise -> map (* xx) y
-- λ> aFoo1 ("", 2) [3]
-- [3]
-- λ> aFoo1 ("", 2) [3, 4, 5]
-- [6,8,10]

aFoo2 :: (String, Integer) -> [Integer] -> [Integer]
aFoo2 _ [] = []
aFoo2 (x, xx) y =
  case y of
    _
      | length y == 1 -> y
      | otherwise -> map (* xx) y
-- λ> aFoo2 ("", 2) [3]
-- [3]
-- λ> aFoo2 ("", 2) [3, 4, 5]
-- [6,8,10]

aFoo3 :: (String, Integer) -> [Integer] -> [Integer]
aFoo3 (x, xx) y =
  case y of
    [] -> []
    y:ys
      | length ys == 0 -> [y]
    otherwise -> map (* xx) y
-- λ> aFoo3 ("", 2) [3]
-- [3]
-- λ> aFoo3 ("", 2) [3, 4, 5]
-- [6,8,10]
