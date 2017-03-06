{-# OPTIONS_GHC -Wall #-}

module Main where

import           ExplicitCostCenters
import           Mean
import           SimpleProfiling

main :: IO ()
main = explicitCostCenters
