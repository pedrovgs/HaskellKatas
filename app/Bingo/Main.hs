module Bingo.Main where

import           Bingo.Bingo
import           System.Random

main = do print "Bingo time!"
          let game = startUSGame
          let (card, newStdGen) = generateUSCard $ mkStdGen 11
          let (calledNumber, game', _) = callNumber newStdGen game
          let winnerCard = wins card game'
          print ("Initial game = " ++ show game)
          print ("Number called = " ++ show calledNumber)
          print ("Game after the first number call = " ++ show game')
          print ("Is the card a winner = " ++ show winnerCard)
