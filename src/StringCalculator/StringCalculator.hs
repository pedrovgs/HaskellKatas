module StringCalculator.StringCalculator
(add, addWithDelimiter)
where

import Data.List
import Data.List.Split

add :: String -> Int
add = addWithDelimiter '\n'

addWithDelimiter :: Char -> String -> Int
addWithDelimiter delimiter input
    | null input = 0
    | containsDelimiter delimiter input = sumNumbers delimiter input
    | otherwise = read input

containsDelimiter :: Char -> String -> Bool
containsDelimiter delimiter input = [delimiter] `isInfixOf` input

sumNumbers :: Char -> String -> Int
sumNumbers delimiter input = sum $ toIntList $ splitOn [delimiter] input

toIntList :: [String] -> [Int]
toIntList strings = let filteredList = filter (/= "") strings
                    in map read filteredList
