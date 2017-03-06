module ExplicitCostCenters
  ( explicitCostCenters
  ) where

explicitCostCenters :: IO ()
explicitCostCenters = do print $ {-# SCC last_xs #-} last xs
                         print $ {-# SCC last_init_xs #-} last $ init xs
                         print $ {-# SCC last_ys #-} last ys
                         print $ {-# SCC last_init_ys #-} last $ init ys
                           where xs = [1..1000000]
                                 ys = [1..2000000]
