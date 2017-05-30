module DataDeclarations where

import           Data.Char (toUpper)

data Person =
  Person String
         String
-- λ> Person "Pera" "Peric"
-- Person "Pera" "Peric" :: Person

data Person1 =
  MkPerson String
           String
-- λ> MkPerson "Pera" "Peric"
-- MkPerson "Pera" "Peric" :: Person1

data PersonRec = PersonRec
  { name    :: String
  , surname :: String
  , age     :: Int
  }
-- λ> PersonRec "Mile" "Milic"
-- PersonRec "Mile" "Milic" :: Int -> PersonRec
-- λ> name
-- name :: PersonRec -> String
-- λ> PersonRec "Mile" "Milic" 25
-- PersonRec "Mile" "Milic" 25 :: PersonRec
-- λ> name (PersonRec "Mile" "Milic" 25)
-- "Mile"
-- λ> name $ PersonRec "Mile" "Milic" 25
-- "Mile"
-- λ> PersonRec {name = "Mile", surname = "Milic", age = 25}
-- PersonRec {name = "Mile", surname = "Milic", age = 25} :: PersonRec
-- λ> surname $ PersonRec {name = "Mile", surname = "Milic", age = 25}
-- "Milic"

data Suit
  = Club
  | Diamond
  | Heart
  | Spade

data CardValue
  = Two
  | Three
  | Four
  | Five
  | Six
  | Seven
  | Eight
  | Nine
  | Ten
  | Jack
  | Queen
  | King
  | Ace

data Card = Card
  { value :: CardValue
  , suit  :: Suit
  }
-- λ> Card Ace Club
-- Card Ace Club :: Card

data XList a
  = Cons a
         (XList a)
  | Empty
-- λ> (Cons 1 (Cons 2 Empty))
-- (Cons 1 (Cons 2 Empty)) :: Num a => XList a

newtype HTML =
  HTLM String

newtype State s a = State
  { runState :: s -> (s, a)
  }

type Name = String

uppercase :: String -> String
uppercase x = map toUpper x

uppercaseName :: Name -> Name
uppercaseName x = map toUpper x
-- λ> uppercase "Mile"
-- "MILE"
-- λ> uppercaseName "Mile"
-- "MILE"
