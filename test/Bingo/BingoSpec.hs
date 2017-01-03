module Bingo.BingoSpec where

import           Bingo.Bingo
import           Test.Hspec
import           Test.QuickCheck
import           System.Random
import           Data.Tuple.Select
import           Data.List
import           Control.Monad.Identity

spec = describe "Bingo requirements" $ do
    it "when I call a number the number is between 1 and 75" $
        property prop_CallingForANumberAlwaysGeneratesNumbersBetween1And75
    it "when I call a number this is moved form the available numbers list to the called numbers list" $
        property prop_TheNumberExtractedIsMovedToTheCalledNumberList

prop_CallingForANumberAlwaysGeneratesNumbersBetween1And75 :: StdGen -> Bool
prop_CallingForANumberAlwaysGeneratesNumbersBetween1And75 stdGen =
  calledNumber >= 1 && calledNumber <= 75
  where game = startUSGame
        (calledNumber, newGame, _) = callNumber stdGen game

prop_TheNumberExtractedIsMovedToTheCalledNumberList :: StdGen -> Game -> Bool
prop_TheNumberExtractedIsMovedToTheCalledNumberList stdGen game =
  containsAll allNumbers [1..75]
  where (number, finalGame, _) = callNumber stdGen game
        finalAvailableNumbers = availableNumbers finalGame
        finalCalledNumbers = calledNumbers finalGame
        allNumbers = finalAvailableNumbers ++ finalCalledNumbers

instance Arbitrary StdGen where
  arbitrary = do seed <- arbitrary
                 return (mkStdGen seed)

instance Arbitrary Game where
  arbitrary = do randomInt <- arbitrary
                 let splitPoint = (randomInt `mod` (length usBingoNumbers - 1) + 1)
                 let splittedNumbers = splitAt splitPoint usBingoNumbers
                 return (Game (sel1 splittedNumbers) (sel2 splittedNumbers))

containsAll :: (Eq a) => [a] -> [a] -> Bool
containsAll l1 l2 = all (`elem` l2) l1
