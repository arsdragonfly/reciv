module Topology where

import Prelude

import Data.Array (catMaybes, (..))
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Monoid.Additive (Additive(..), Additive)
import Data.Newtype (class Newtype, unwrap)
import Data.Tuple (Tuple(..), Tuple)
import Data.Typelevel.Num (D2, d0, d1)
import Data.Vec (Vec(..), Vec, (!!), empty, (+>))

class (Semigroup i) <= NaiveTopology i where
  neighbors :: Array i

class (NaiveTopology i) <= CardinalNaiveTopology i where
  cardinalNeighbors :: Array i

class (Semigroup i) <= FiniteTopology context i where
  normalize :: context -> i -> Maybe i
  allPositions :: context -> Array i

normalizedNeighbors :: forall context i. NaiveTopology i => FiniteTopology context i => context -> i -> Array i
normalizedNeighbors ctx i = catMaybes $ do
  n <- neighbors
  pure (normalize ctx (i <> n))

normalizedCardinalNeighbors :: forall context i. CardinalNaiveTopology i => FiniteTopology context i => context -> i -> Array i
normalizedCardinalNeighbors ctx i = catMaybes $ do
  n <- cardinalNeighbors
  pure (normalize ctx (i <> n))

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

newtype NowrapSquareGridContext = NowrapSquareGridContext ({
  xlen :: Int,
  ylen :: Int
})

instance nowrapSquareTopology :: FiniteTopology NowrapSquareGridContext SquarePoint where
  normalize (NowrapSquareGridContext c) (SquarePoint pos) = let
                                        x = unwrap (pos !! d0)
                                        y = unwrap (pos !! d1)
                                     in if x < 0 || x >= c.xlen || y < 0 || y >= c.ylen
                                        then Nothing
                                        else Just (SquarePoint ((Additive x) +> (Additive y) +> empty))
  allPositions (NowrapSquareGridContext c) = do
    x <- 0..(c.xlen - 1)
    y <- 0..(c.ylen - 1)
    pure (SquarePoint ((Additive x) +> (Additive y) +> empty))