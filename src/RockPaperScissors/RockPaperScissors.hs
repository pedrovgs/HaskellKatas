module RockPaperScissors where

data Gesture = Rock | Paper | Scissors deriving (Enum)

data Player = Player String Gesture

name :: Player -> String
name (Player name _ ) = name

gesture :: Player -> Gesture
gesture (Player _ gesture) = gesture

whoWins :: Player -> Player-> Gesture
whoWins player1 player2 = undefined
