module RockPaperScissors.Main where

import           RockPaperScissors.RockPaperScissors

main = do print "Rock paer or scissors:"
          let result1 = whoWins (Player "A" Rock) (Player "B" Paper)
          let result2 = whoWins (Player "A" Scissors) (Player "B" Rock)
          let result3 = whoWins (Player "A" Rock) (Player "B" Rock)
          print ("First game resul = " ++ show result1)
          print ("Second game resul = " ++ show result2)
          print ("Third game resul = " ++ show result3)
