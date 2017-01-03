module Bingo.Bingo where

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
                 where bingoGeneration = generateBingoAvailableNumber gen availableNumbers
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

generateBingoAvailableNumber :: StdGen -> [Integer] -> (Integer, StdGen)
generateBingoAvailableNumber gen list = (bingoNumber, newStdGen)
                      where listSize = length list
                            random = randomR (0, listSize - 1) gen
                            position = fst random
                            newStdGen = snd random
                            bingoNumber = list !! fromIntegral position

randomList :: [Integer] -> [Integer] -> Integer -> StdGen -> ([Integer], StdGen)
randomList acc _ 0 stdGen = (acc, stdGen)
randomList acc availableNumbers n stdGen = randomList newList newAvailableNumbers (n - 1) newStdGen
  where randomValue = generateBingoAvailableNumber stdGen availableNumbers
        bingoNumber = fst randomValue
        newStdGen = snd randomValue
        newAvailableNumbers = delete bingoNumber availableNumbers
        newList = bingoNumber : acc
