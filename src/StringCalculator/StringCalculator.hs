module StringCalculator.StringCalculator
(add)
where

import           Data.Char
import           Data.List
import           Data.List.Split

add :: String -> Int
add input =
  if containsCustomDelimiter input then addWithDelimiter (extractDelimiter input) input
  else addWithDelimiters [",","\n"] input

containsCustomDelimiter :: String -> Bool
containsCustomDelimiter ""    = False
containsCustomDelimiter input = "//" `isPrefixOf` input

extractDelimiter :: String -> Char
extractDelimiter input = head (head (tail ("//" `splitOn` input)))

addWithDelimiter :: Char -> String -> Int
addWithDelimiter delimiter = addWithDelimiters [[delimiter]]

addWithDelimiters :: [String] -> String -> Int
addWithDelimiters delimiters input
    | null delimiters = 0
    | containsDelimiter [head delimiters] input = sum $ toIntList $ splitOn (head delimiters) input
    | otherwise = addWithDelimiters (tail delimiters) input

containsDelimiter :: [String] -> String -> Bool
containsDelimiter delimiters input = any (`isInfixOf` input) delimiters

toIntList :: [String] -> [Int]
toIntList strings = let filteredList = filter isANumber strings
                    in map (\i -> read i :: Int) filteredList

isANumber :: String -> Bool
isANumber "" = False
isANumber value = all isDigit value
