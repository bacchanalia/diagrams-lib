{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies     #-}

-----------------------------------------------------------------------------
-- |
-- Module      :  Diagrams.Points
-- Copyright   :  (c) 2011 diagrams-lib team (see LICENSE)
-- License     :  BSD-style (see LICENSE)
-- Maintainer  :  diagrams-discuss@googlegroups.com
--
-- Points in space.  For more tools for working with points and
-- vectors, see "Data.AffineSpace" and "Diagrams.Coordinates".
--
-----------------------------------------------------------------------------

module Diagrams.Points
       ( -- * Points
         Point (..), origin, (*.)

         -- * Point-related utilities
       , centroid
       , pointDiagram
       , _pIso, lensP
       ) where

import           Diagrams.Core          (pointDiagram)
import           Diagrams.Core.Points

import           Control.Lens           (Iso', iso)

import Linear.Affine
import Linear.Vector
import Data.Foldable as F

-- Point v <-> v
_pIso :: Iso' (Point v n) (v n)
_pIso = iso (\(P a) -> a) P

-- | The centroid of a set of /n/ points is their sum divided by /n/.
centroid :: (Additive v, Fractional n) => [Point v n] -> Point v n
centroid = meanV

meanV :: (Foldable f, Additive v, Fractional a) => f (v a) -> v a
meanV = uncurry (^/) . F.foldl' (\(s,c) e -> (e ^+^ s,c+1)) (zero,0)
{-# INLINE meanV #-}

