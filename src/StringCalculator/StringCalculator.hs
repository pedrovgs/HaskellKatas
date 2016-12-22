module StringCalculator.StringCalculator
(add, addWithDelimiter)
where

import Data.List
import Data.List.Split

add :: String -> Int
add = addWithDelimiter '\n'

addWithDelimiter :: Char -> String -> Int
addWithDelimiter delimiter = addWithDelimiters [delimiter]

addWithDelimiters :: String -> String -> Int
addWithDelimiters delimiter input
    | null input = 0
    | containsDelimiter delimiter input = sumNumbers delimiter input
    | otherwise = read input

containsDelimiter :: String -> String -> Bool
containsDelimiter delimiter input = delimiter `isInfixOf` input

sumNumbers :: String -> String -> Int
sumNumbers delimiter input = sum $ toIntList $ splitOn delimiter input

toIntList :: [String] -> [Int]
toIntList strings = let filteredList = filter (/= "") strings
                    in map read filteredList
