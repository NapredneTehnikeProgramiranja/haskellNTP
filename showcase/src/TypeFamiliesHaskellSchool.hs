{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies          #-}
{-|
Module: TypeFamiliesHaskellSchool
Description: Type families examples
License: same as The School Of Haskell

This module is actually Type Families and Pokemon from The School Of
Haskell. See
https://www.schoolofhaskell.com/school/to-infinity-and-beyond/pick-of-the-week/type-families-and-pokemon
-}
module TypeFamiliesHaskellSchool where

import           Data.Tuple (swap)

data Fire
  = Charmander
  | Charmeleon
  | Charizard
  deriving (Show)

data Water
  = Squirtle
  | Wartortle
  | Blastoise
  deriving (Show)

data Grass
  = Bulbasaur
  | Ivysaur
  | Venusaur
  deriving (Show)

class (Show pokemon, Show (Move pokemon)) => Pokemon pokemon where
  data Move pokemon :: *
  pickMove :: pokemon -> Move pokemon

instance Pokemon Fire where
  data Move Fire = Ember
               | FlameThrower
               | FireBlast
               deriving Show
  pickMove Charmander = Ember
  pickMove Charmeleon = FlameThrower
  pickMove Charizard  = FireBlast

instance Pokemon Water where
  data Move Water = Bubble
                | WaterGun
                deriving Show
  pickMove Squirtle = Bubble
  pickMove _        = WaterGun

instance Pokemon Grass where
  data Move Grass = VineWhip
                deriving Show
  pickMove _ = VineWhip

class (Show (Winner pokemon foe), Pokemon pokemon, Pokemon foe) =>
      Battle pokemon foe  where
  type Winner pokemon foe :: *
  type Winner pokemon foe = pokemon

  battle :: pokemon -> foe -> IO ()
  battle pokemon foe = do
    printBattle
      (show pokemon)
      (show pokemonMove)
      (show foe)
      (show foeMove)
      (show winner)
    where
      pokemonMove = pickMove pokemon
      foeMove = pickMove foe
      winner = pickWinner pokemon foe

  pickWinner :: pokemon -> foe -> (Winner pokemon foe)

instance Battle Water Fire where
  pickWinner water fire = water

instance Battle Fire Water where
  type Winner Fire Water = Water
  pickWinner = flip pickWinner

instance Battle Grass Water where
  pickWinner pokemon foe = pokemon

instance Battle Water Grass where
  type Winner Water Grass = Grass
  pickWinner = flip pickWinner

instance Battle Fire Grass where
  pickWinner pokemon foe = pokemon

instance Battle Grass Fire where
  type Winner Grass Fire = Fire
  pickWinner = flip pickWinner

printBattle :: String -> String -> String -> String -> String -> IO ()
printBattle pokemonOne moveOne pokemonTwo moveTwo winner = do
  putStrLn $ pokemonOne ++ " used " ++ moveOne
  putStrLn $ pokemonTwo ++ " used " ++ moveTwo
  putStrLn $ "Winner is: " ++ winner ++ "\n"

-- λ> battle Squirtle Bulbasaur
-- Squirtle used Bubble
-- Bulbasaur used VineWhip
-- Winner is: Bulbasaur

-- λ> battle Squirtle Wartortle
-- <interactive>:105:1-25: error:
--     • No instance for (Battle Water Water)
--         arising from a use of ‘battle’
--     • In the expression: battle Squirtle Wartortle
--       In an equation for ‘it’: it = battle Squirtle Wartortle
