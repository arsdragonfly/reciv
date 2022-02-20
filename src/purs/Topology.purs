module Topology where

import Prelude

import Data.Bifunctor (bimap)
import Data.Maybe (Maybe)
import Data.Monoid.Additive (Additive(..), Additive)
import Data.Newtype (class Newtype, ala)
import Data.Tuple (Tuple(..), Tuple)
import Data.Typelevel.Num (D2)
import Data.Vec (Vec(..), Vec, empty, (+>))

class (Semigroup i) <= NaiveTopology i where
  neighbors :: Array i

class (NaiveTopology i) <= CardinalNaiveTopology i where
  cardinalNeighbors :: Array i

class (Semigroup i) <= NormalizableIndex i j where
  normalize :: i -> Maybe j
  project :: j -> i

type Vec2 = Vec D2 (Additive Int)

newtype SquarePoint = SquarePoint Vec2
derive newtype instance semigroupSquarePoint :: Semigroup SquarePoint

newtype IsoSquarePoint = IsoSquarePoint Vec2
derive newtype instance semigroupIsoSquarePoint :: Semigroup IsoSquarePoint

newtype HexPoint = HexPoint Vec2
derive newtype instance semigroupHexPoint :: Semigroup HexPoint

instance squareNaiveTopology :: NaiveTopology SquarePoint where
  neighbors = map SquarePoint (map (map Additive) ([
    1 +> 0 +> empty,
    1 +> 1 +> empty,
    0 +> 1 +> empty,
    (-1) +> 1 +> empty,
    (-1) +> 0 +> empty,
    (-1) +> (-1) +> empty,
    0 +> (-1) +> empty,
    1 +> (-1) +> empty
  ]))

instance squareCardinalNaiveTopology :: CardinalNaiveTopology SquarePoint where
  cardinalNeighbors = map SquarePoint (map (map Additive) ([
    1 +> 0 +> empty,
    0 +> 1 +> empty,
    (-1) +> 0 +> empty,
    0 +> (-1) +> empty
  ]))

instance isoSquareNaiveTopology :: NaiveTopology IsoSquarePoint where
  neighbors = map IsoSquarePoint (map (map Additive) ([
    1 +> 0 +> empty,
    1 +> 1 +> empty,
    0 +> 1 +> empty,
    (-1) +> 1 +> empty,
    (-1) +> 0 +> empty,
    (-1) +> (-1) +> empty,
    0 +> (-1) +> empty,
    1 +> (-1) +> empty
  ]))

instance isoSquareCardinalNaiveTopology :: CardinalNaiveTopology IsoSquarePoint where
  cardinalNeighbors = map IsoSquarePoint (map (map Additive) ([
    1 +> 1 +> empty,
    (-1) +> 1 +> empty,
    (-1) +> (-1) +> empty,
    1 +> (-1) +> empty
  ]))

instance hexNaiveTopology :: NaiveTopology HexPoint where
  neighbors = map HexPoint (map (map Additive) ([
    1 +> 0 +> empty,
    0 +> 1 +> empty,
    (-1) +> 1 +> empty,
    (-1) +> 0 +> empty,
    0 +> (-1) +> empty,
    1 +> (-1) +> empty
  ]))

instance hexCardinalNaiveTopology :: CardinalNaiveTopology HexPoint where
  cardinalNeighbors = map HexPoint (map (map Additive) ([
    1 +> 0 +> empty,
    0 +> 1 +> empty,
    (-1) +> 1 +> empty,
    (-1) +> 0 +> empty,
    0 +> (-1) +> empty,
    1 +> (-1) +> empty
  ]))