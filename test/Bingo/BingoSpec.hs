module Bingo.BingoSpec where

import           Bingo.Bingo
import           Data.List
import           Data.Tuple.Select
import           System.Random
import           Test.Hspec
import           Test.QuickCheck
import           Utils.List

spec = describe "Bingo requirements" $ do
    it "when I call a number the number is between 1 and 75" $
        property prop_CallingForANumberAlwaysGeneratesNumbersBetween1And75
    it "when I call a number this is moved form the available numbers list to the called numbers list" $
        property prop_TheNumberExtractedIsMovedToTheCalledNumberList
    it "when a card is generated contains 24 numbers between 1 and 75" $
        property prop_TheNumbersInsideACardShouldBeBetween1And75
    it "when a card is generated does not contain repeated numbers" $
        property prop_TheNumbersInsideACardShouldNotBeRepeated
    it "when a card contains every called number then is a winner card" $
        property prop_ACardWinsTheBingoIfEveryNumberCalledIsContainedByTheCard
    -- In the future we will rewrite this Kata using the State Monad.
    it "wins if every number has been called" $
        playNTimesAndExpectToWin 75
    it "does not win if just 23 numbers are called" $
        playNTimesAndExpectToLose 23


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

prop_TheNumbersInsideACardShouldBeBetween1And75 :: StdGen -> Bool
prop_TheNumbersInsideACardShouldBeBetween1And75 stdGen =
  length cardNumbers == 24
  && all (>=1) cardNumbers
  && all(<=75) cardNumbers
  where generatedCard = generateUSCard stdGen
        cardNumbers = numbers $ fst generatedCard

prop_TheNumbersInsideACardShouldNotBeRepeated :: StdGen -> Bool
prop_TheNumbersInsideACardShouldNotBeRepeated stdGen =
  not (any (>1) groupedNumbers)
  where groupedNumbers = map length $ group cardNumbers
        generatedCard = generateUSCard stdGen
        cardNumbers = numbers $ fst generatedCard

prop_ACardWinsTheBingoIfEveryNumberCalledIsContainedByTheCard :: Game -> Card -> Bool
prop_ACardWinsTheBingoIfEveryNumberCalledIsContainedByTheCard game card
  | containsAll cardNumbers gameCalledNumbers = wins card game
  | otherwise = not $ wins card game
  where cardNumbers = numbers card
        gameCalledNumbers = calledNumbers game

instance Arbitrary StdGen where
  arbitrary = do seed <- arbitrary
                 return (mkStdGen seed)

instance Arbitrary Game where
  arbitrary = do randomInt <- arbitrary
                 let splitPoint = randomInt `mod` (length usBingoNumbers - 1) + 1
                 let splittedNumbers = splitAt splitPoint usBingoNumbers
                 return (Game (sel1 splittedNumbers) (sel2 splittedNumbers))

instance Arbitrary Card where
  arbitrary = do randomStdGen <- arbitrary
                 return $ fst $ generateUSCard randomStdGen

playNTimesAndExpectToWin :: Int -> Bool
playNTimesAndExpectToWin n = playNTimesAndExpect n True

playNTimesAndExpectToLose :: Int -> Bool
playNTimesAndExpectToLose n = playNTimesAndExpect n False

playNTimesAndExpect :: Int -> Bool -> Bool
playNTimesAndExpect n expectedResult = wins card game == expectedResult
    where initialGame = startUSGame
          stdGen = mkStdGen 1
          (card, stdGen') = generateUSCard stdGen
          game = callNumberNTimes n stdGen' initialGame

callNumberNTimes :: Int -> StdGen -> Game -> Game
callNumberNTimes 0 stdGen game = game
callNumberNTimes n stdGen game = callNumberNTimes (n - 1) newStdGen newGame
  where (_, newGame, newStdGen) = callNumber stdGen game
