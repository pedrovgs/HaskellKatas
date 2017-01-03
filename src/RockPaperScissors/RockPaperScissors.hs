module RockPaperScissors.RockPaperScissors where

data Gesture = Rock | Paper | Scissors deriving (Eq, Enum, Show)
data Player = Player String Gesture
data Result = Player1Wins | Player2Wins | Draw deriving (Eq, Enum, Show)

name :: Player -> String
name (Player name _ ) = name

gesture :: Player -> Gesture
gesture (Player _ gesture) = gesture

whoWins :: Player -> Player -> Result
whoWins (Player _ Rock) (Player _ Scissors)  = Player1Wins
whoWins (Player _ Scissors) (Player _ Paper) = Player1Wins
whoWins (Player _ Paper) (Player _ Rock)     = Player1Wins
whoWins (Player _ Rock) (Player _ Paper)     = Player2Wins
whoWins (Player _ Paper) (Player _ Scissors) = Player2Wins
whoWins (Player _ Scissors) (Player _ Rock)  = Player2Wins
whoWins _ _                                  = Draw
