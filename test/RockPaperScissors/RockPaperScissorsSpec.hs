module RockPaperScissors.RockPaperScissorsSpec where

import           RockPaperScissors.RockPaperScissors
import           Test.Hspec
import           Test.QuickCheck

spec = describe "RockPaperScissors requirements" $ do
    it "rock beat scissors" $
      Player "p1" Rock `whoWins` Player "p2" Scissors == Player1Wins
    it "paper beat rock" $
      Player "p1" Paper `whoWins` Player "p2" Rock == Player1Wins
    it "scissors beat paper" $
      Player "p1" Scissors `whoWins` Player "p2" Paper == Player1Wins
    it "scissors loses rock" $
      Player "p1" Scissors `whoWins` Player "p2" Rock == Player2Wins
    it "rock loses paper" $
      Player "p1" Rock `whoWins` Player "p2" Paper == Player2Wins
    it "paper loses scissors" $
      Player "p1" Paper `whoWins` Player "p2" Scissors == Player2Wins
    it "if the gesture is the same the result is draw" $
      property prop_theResultIsDrawIfTheGestureIsAlwaysTheSame

prop_theResultIsDrawIfTheGestureIsAlwaysTheSame :: Property
prop_theResultIsDrawIfTheGestureIsAlwaysTheSame =
        forAll singleGesture (\gest -> Player "p1" gest `whoWins` Player "p2" gest == Draw)

singleGesture :: Gen Gesture
singleGesture = elements [Rock, Paper, Scissors]
