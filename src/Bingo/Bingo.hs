module Bingo.Bingo where

import           Data.List
import           System.Random

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
                 where bingoGeneration = generateValidInt gen availableNumbers
                       bingoNumber = fst bingoGeneration
                       stdGen = snd bingoGeneration
                       currentGameNumbers = availableNumbers
                       leftNumbers = delete bingoNumber currentGameNumbers
                       updatedCalledNumbers = bingoNumber:calledNumbers

generateCard :: Card
generateCard = undefined

isWinner :: Card -> Game -> Bool
isWinner = undefined

generateValidInt :: StdGen -> [Integer] -> (Integer, StdGen)
generateValidInt gen list = (toInteger (fst result), snd result)
                      where listSize = length list
                            result = randomR (1, listSize) gen
