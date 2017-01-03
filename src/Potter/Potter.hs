module Potter.Potter where

data HarryPotterBook = Book1 | Book2 | Book3 | Book4 | Book5 deriving (Enum, Bounded, Show)

calculatePrice :: [HarryPotterBook] -> Float
calculatePrice [] = 0.0
calculatePrice [x] = 8.0
