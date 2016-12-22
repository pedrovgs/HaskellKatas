module StringCalculator.StringCalculator
(add)
where

import Data.List
import Data.List.Split

add :: String -> Int
add input
    | null input = 0
    | containsDelimiter input "\n" = sumNumbers "\n" input
    | otherwise = read input

containsDelimiter :: String -> String -> Bool
containsDelimiter input delimiter = delimiter `isInfixOf` input

sumNumbers :: String -> String -> Int
sumNumbers delimiter input = sum $ toIntList $ splitOn delimiter input

toIntList :: [String] -> [Int]
toIntList = map read
