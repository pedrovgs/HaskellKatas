module StringCalculator.StringCalculatorSpec where

import           Data.Char
import           Data.Tuple.Select
import           StringCalculator.StringCalculator
import           Test.Hspec
import           Test.QuickCheck

spec = describe "StringCalculator requirements" $ do
    it "returns 0 if the input is empty" $
      add "" == 0

    it "returns 3 if the input contains just the number 3" $
      add "3," == 3

    it "returns 5 if the input contains a 2 and a 5 separated by a '\\n'" $
      add "3\n2\n" == 5

    it "returns 5 if the input contains a 2 and a 5 separated by a ',''" $
      add "3,2," == 5

    it "return 0 if the delimiter is customized but there are no numbers" $
      add "//x" == 0

    it "return 1 if the delimiter is customized and the number inside the string is 1" $
      add "//x1x" == 1

    it "returns zero or greater than zero if every number is positive" $
      property prop_sumIsAlwaysGreaterThanZeroIfInputContainsPositiveNumbers

    it "returns the sum of the positive numbers if every value is positive" $
      property prop_sumContainsTheSumOfThePositiveValuesIfInputContainsPositiveNumbers

prop_sumIsAlwaysGreaterThanZeroIfInputContainsPositiveNumbers :: Property
prop_sumIsAlwaysGreaterThanZeroIfInputContainsPositiveNumbers =
  forAll inputWithPositivesAndDelimiters (\input -> add (sel2 input) >= 0)

prop_sumContainsTheSumOfThePositiveValuesIfInputContainsPositiveNumbers :: Property
prop_sumContainsTheSumOfThePositiveValuesIfInputContainsPositiveNumbers =
  forAll inputWithPositivesAndDelimiters (\input -> add (sel2 input) == sum (sel3 input))

inputWithPositivesAndDelimiters :: Gen (Char, String, [Int])
inputWithPositivesAndDelimiters =
  do del <- delimiter
     numberOfItems <- positive
     positives <- listOfPositives numberOfItems
     return (del, mixDelimiterAndPositives del positives, positives)

positive :: Gen Int
positive = abs `fmap` (arbitrary :: Gen Int) `suchThat` (> 0)

listOfPositives :: Int ->  Gen [Int]
listOfPositives size = vectorOf size positive

delimiter :: Gen Char
delimiter = suchThat arbitrary (\n -> n /= ' ' && not (isDigit n))

mixDelimiterAndPositives :: Char -> [Int] -> String
mixDelimiterAndPositives del positives =
      let listOfChars = generateListOfChars (length positives) del
          positivesAsChar = toCharArray positives
          tuples = zipWith (\a b -> a ++ [b]) positivesAsChar listOfChars;
      in "//" ++ [del] ++ concat tuples

generateListOfChars :: Int -> Char -> String
generateListOfChars numberOfItems del = map (const del) [1..numberOfItems]

toCharArray :: [Int] -> [String]
toCharArray = map show
