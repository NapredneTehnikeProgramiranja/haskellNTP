{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses  #-}

module FunDeps where

-- Abstrakcija raspakivanja
class Unpack packaging content  where
  unpack :: packaging -> content

data Carton = Carton
  { volume :: Double
  } deriving (Eq, Show)

data Milk = Milk
  { kind :: String
  , desc :: String
  } deriving (Show)

-- Carton i Milk instanca raspakivanja, kada se raspakuje mpleko iz
-- kartona
instance Unpack Carton Milk where
  unpack p = Milk "cow milk" $ "carton of " ++ (show . volume $ p) ++ " volume."

c :: Carton
c = Carton 500

-- try = unpack c
-- src/FunDeps.hs:25:7-14: error: …
--     • Ambiguous type variable ‘content0’ arising from a use of ‘unpack’
--       prevents the constraint ‘(Unpack
--                                   Carton content0)’ from being solved.
--       Relevant bindings include
--         try :: content0
--           (bound at haskellNTP/showcase/src/FunDeps.hs:25:1)
--       Probable fix: use a type annotation to specify what ‘content0’ should be.
--       These potential instance exist:
--         instance Unpack Carton Milk
--           -- Defined at haskellNTP/showcase/src/FunDeps.hs:19:10
--     • In the expression: unpack c
--       In an equation for ‘try’: try = unpack c
-- Compilation failed.

-- Jer može i ovo:

data Yogurt = Yogurt
  { density :: String
  } deriving (Show)

instance Unpack Carton Yogurt where
  unpack c = Yogurt $ "rare yogurt in carton of " ++ (show . volume $ c) ++ "."

-- λ> unpack c :: Yogurt
-- Yogurt {density = "rare yogurt in carton of 500.0."}

-- λ> :set -XFlexibleContexts
-- λ> unpack c
-- unpack c :: Unpack Carton content => content

--------------------------------------------------------------------------------
-- Kada želimo da pojasnimo da se samo jedna namirnica može pakovati u
-- jednu ambalažu. Dakle, u karton može da se pakuje samo mleko

class Unpack' packaging content  | packaging -> content where
  unpack' :: packaging -> content

instance Unpack' Carton Milk where
  unpack' p =
    Milk "cow milk" $ "carton of " ++ (show . volume $ p) ++ " volume."

-- λ> unpack' c
-- Milk {kind = "cow milk", desc = "carton of 500.0 volume."}

data GlassBottle = GlassBottle
  { shape :: String
  } deriving (Show)

data Beer = Beer
  { feel :: String
  } deriving (Show)

instance Unpack' GlassBottle Beer where
  unpack' p = Beer $ "Fresh bear from the " ++ shape p ++ "."

b = GlassBottle "curvy bottle"

-- λ> unpack' b
-- Beer {feel = "Fresh bear from the curvy bottle."}

data EnergyDrink = EnergyDrink
  { caffeineRate :: Int
  } deriving (Show)

-- instance Unpack' GlassBottle EnergyDrink where
--   unpack' p = EnergyDrink 12
-- src/FunDeps.hs:78:10-33: error: …
--     Functional dependencies conflict between instance declarations:
--       instance Unpack' GlassBottle Beer
--         -- Defined at /home/novak/haskell/haskellNTP/showcase/src/FunDeps.hs:78:10
--       instance Unpack' GlassBottle EnergyDrink
--         -- Defined at /home/novak/haskell/haskellNTP/showcase/src/FunDeps.hs:90:10
-- Compilation failed.
