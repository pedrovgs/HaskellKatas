module FizzBuzz.FizzBuzz (fizzBuzz) where

fizzBuzz n
    | isMultipleOfTwoValues n 3 5 = "FizzBuzz"
    | isMultipleOf n 3 = "Fizz"
    | isMultipleOf n 5 = "Buzz"
    | otherwise = show n

isMultipleOf x y = x `mod`y == 0
isMultipleOfTwoValues x y z = isMultipleOf x y && isMultipleOf x z
