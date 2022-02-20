module Topology where

import Prelude

import Data.Bifunctor (bimap)
import Data.Maybe (Maybe)
import Data.Monoid.Additive (Additive(..), Additive)
import Data.Newtype (class Newtype, ala)
import Data.Tuple (Tuple(..), Tuple)

class (Semigroup i) <= NaiveTopology i where
  neighbors :: Array i

class (NaiveTopology i) <= CardinalNaiveTopology i where
  cardinalNeighbors :: Array i

class (Semigroup i) <= NormalizableIndex i j where
  normalize :: i -> Maybe j
  project :: j -> i

newtype SquarePoint = SquarePoint (Tuple (Additive Int) (Additive Int))
derive newtype instance semigroupSquarePoint :: Semigroup SquarePoint

newtype IsoSquarePoint = IsoSquarePoint (Tuple (Additive Int) (Additive Int))
derive newtype instance semigroupIsoSquarePoint :: Semigroup IsoSquarePoint

newtype HexPoint = HexPoint (Tuple (Additive Int) (Additive Int))
derive newtype instance semigroupHexPoint :: Semigroup HexPoint

instance squareNaiveTopology :: NaiveTopology SquarePoint where
  neighbors = map SquarePoint (map (bimap Additive Additive) [Tuple 1 0, Tuple 1 1, Tuple 0 1, Tuple (-1) 1, Tuple (-1) 0, Tuple (-1) (-1), Tuple 0 (-1), Tuple 1 (-1)])

instance squareCardinalNaiveTopology :: CardinalNaiveTopology SquarePoint where
  cardinalNeighbors = map SquarePoint (map (bimap Additive Additive) [Tuple 1 0, Tuple 0 1, Tuple (-1) 0, Tuple 0 (-1)])

instance isoSquareNaiveTopology :: NaiveTopology IsoSquarePoint where
  neighbors = map IsoSquarePoint (map (bimap Additive Additive) [Tuple 1 0, Tuple 1 1, Tuple 0 1, Tuple (-1) 1, Tuple (-1) 0, Tuple (-1) (-1), Tuple 0 (-1), Tuple 1 (-1)])

instance isoSquareCardinalNaiveTopology :: CardinalNaiveTopology IsoSquarePoint where
  cardinalNeighbors = map IsoSquarePoint (map (bimap Additive Additive) [Tuple 1 1, Tuple (-1) 1, Tuple (-1) (-1), Tuple 1 (-1)])

instance hexNaiveTopology :: NaiveTopology HexPoint where
  neighbors = map HexPoint (map (bimap Additive Additive) [Tuple 1 0, Tuple 0 1, Tuple (-1) 1, Tuple (-1) 0, Tuple 0 (-1), Tuple 1 (-1)])

instance hexCardinalNaiveTopology :: CardinalNaiveTopology HexPoint where
  cardinalNeighbors = map HexPoint (map (bimap Additive Additive) [Tuple 1 0, Tuple 0 1, Tuple (-1) 1, Tuple (-1) 0, Tuple 0 (-1), Tuple 1 (-1)])