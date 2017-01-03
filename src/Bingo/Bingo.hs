module Bingo.Bingo
(Game(..)
, Card(..)
, usBingoNumbers
, startUSGame
, callNumber
, generateUSCard
, wins) where

import           Data.List
import           System.Random
import           Utils.List

data Game = Game {
    availableNumbers :: [Integer]
  , calledNumbers    :: [Integer]
} deriving (Eq, Show, Read)

data Card = Card {
    numbers :: [Integer]
} deriving (Eq, Show, Read)

usBingoNumbers = [1..75]

startUSGame :: Game
startUSGame = Game [1..75] []

callNumber :: StdGen -> Game -> (Integer, Game, StdGen)
callNumber gen (Game availableNumbers calledNumbers) = (bingoNumber, Game leftNumbers updatedCalledNumbers, stdGen)
                 where bingoGeneration = pickBingoAvailableNumber gen availableNumbers
                       bingoNumber = fst bingoGeneration
                       stdGen = snd bingoGeneration
                       currentGameNumbers = availableNumbers
                       leftNumbers = delete bingoNumber currentGameNumbers
                       updatedCalledNumbers = bingoNumber:calledNumbers

generateUSCard :: StdGen -> (Card, StdGen)
generateUSCard stdGen = (Card numbers, newStdGen)
  where randomValues = randomList [] usBingoNumbers 24 stdGen
        numbers = fst randomValues
        newStdGen = snd randomValues

wins :: Card -> Game -> Bool
wins card game = containsAll cardNumbers gameCalledNumbers
  where cardNumbers = numbers card
        gameCalledNumbers = calledNumbers game

pickBingoAvailableNumber :: StdGen -> [Integer] -> (Integer, StdGen)
pickBingoAvailableNumber gen availableNumbers = (bingoNumber, newStdGen)
                      where listSize = length availableNumbers
                            random = randomR (0, listSize - 1) gen
                            position = fst random
                            newStdGen = snd random
                            bingoNumber = availableNumbers !! fromIntegral position

randomList :: [Integer] -> [Integer] -> Integer -> StdGen -> ([Integer], StdGen)
randomList acc _ 0 stdGen = (acc, stdGen)
randomList acc availableNumbers n stdGen = randomList newList newAvailableNumbers (n - 1) newStdGen
  where randomValue = pickBingoAvailableNumber stdGen availableNumbers
        bingoNumber = fst randomValue
        newStdGen = snd randomValue
        newAvailableNumbers = delete bingoNumber availableNumbers
        newList = bingoNumber : acc
