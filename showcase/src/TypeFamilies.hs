{-# LANGUAGE TypeFamilies #-}
module TypeFamilies where

import           Data.Char   as Char
import           Data.IntMap

-- | Class whose instances are the types we can use as keys in our
-- | generic maps.
class GMapKey k  where
  data GMap k :: * -> *
  empty :: GMap k v
  lookup :: k -> GMap k v -> Maybe v
  insert :: k -> v -> GMap k v -> GMap k v

instance GMapKey Int where
  data GMap Int v = GMapInt (Data.IntMap.IntMap v)
  empty = GMapInt Data.IntMap.empty
  lookup k (GMapInt m) = Data.IntMap.lookup k m
  insert k v (GMapInt m) = GMapInt (Data.IntMap.insert k v m)

instance GMapKey Char where
  data GMap Char v = GMapChar (Data.IntMap.IntMap v)
  empty = GMapChar Data.IntMap.empty
  lookup k (GMapChar m) = Data.IntMap.lookup (Char.ord k) m
  insert k v (GMapChar m) = GMapChar $ Data.IntMap.insert (Char.ord k) v m

-- | For unit map is just a Maybe value
instance GMapKey () where
  data GMap () v = GMapUnit (Maybe v)
  empty = GMapUnit Nothing
  lookup () (GMapUnit v) = v
  insert () v (GMapUnit _) = GMapUnit $ Just v

instance (GMapKey a, GMapKey b) =>
         GMapKey (a, b) where
  data GMap (a, b) v = GMapPair (GMap a (GMap b v))
  empty = GMapPair TypeFamilies.empty
  lookup (a, b) (GMapPair gm) =
    TypeFamilies.lookup a gm >>= TypeFamilies.lookup b
  insert (a, b) v (GMapPair gm) =
    GMapPair $
    case TypeFamilies.lookup a gm of
      Nothing ->
        TypeFamilies.insert a (TypeFamilies.insert b v TypeFamilies.empty) gm
      Just gm2 -> TypeFamilies.insert a (TypeFamilies.insert b v gm2) gm

instance (GMapKey a, GMapKey b) =>
         GMapKey (Either a b) where
  data GMap (Either a b) v = GMapEither (GMap a v) (GMap b v)
  empty = GMapEither TypeFamilies.empty TypeFamilies.empty
  lookup (Left a) (GMapEither gm1 _gm2)  = TypeFamilies.lookup a gm1
  lookup (Right b) (GMapEither _gm1 gm2) = TypeFamilies.lookup b gm2
  insert (Left a) v (GMapEither gm1 gm2) =
    GMapEither (TypeFamilies.insert a v gm1) gm2
  insert (Right b) v (GMapEither gm1 gm2) =
    GMapEither gm1 (TypeFamilies.insert b v gm2)
