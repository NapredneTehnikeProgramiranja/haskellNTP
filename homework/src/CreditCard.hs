module CreditCard where

main :: IO ()
main = do
    print (validate 4012888888881881)
    print (validate 4012888888881882)

toDigits :: Integer -> [Integer]
toDigitsRev :: Integer -> [Integer]

toDigits x 
    | x < 0 = []
    | x < 10 = [x] 
    | otherwise = toDigits (x `div` 10) ++ [x `mod` 10]

toDigitsRev x = reverse (toDigits x)

doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther (x:y:xs) = x : (y * 2) : doubleEveryOther xs
doubleEveryOther (x:_) = [x]

sumNum :: Integer -> Integer
sumNum 0 = 0
sumNum x = (mod x 10) + sumNum (div x 10)

sumDigits :: [Integer] -> Integer
sumDigits [x] = sumNum x
sumDigits (x:xs) = sumNum x + sumDigits xs

isEven :: Integer -> Bool
isEven x = x `mod` 10 == 0

validate :: Integer -> Bool
validate number = isEven . sumDigits . doubleEveryOther . reverse . toDigits $ number