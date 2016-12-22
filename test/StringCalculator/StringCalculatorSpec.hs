module StringCalculator.StringCalculatorSpec where

import           Data.Char
import           StringCalculator.StringCalculator
import           Test.Hspec
import           Test.QuickCheck

spec = describe "StringCalculator requirements" $ do
    it "returns 0 if the input is empty" $
      add "" `shouldBe` 0

    it "returns 3 if the input contains just the number 3" $
      add "3" `shouldBe` 3

    it "returns 5 if the input contains a 2 and a 5 separated by a '\n'" $
      add "3\n2\n" `shouldBe` 5

    it "returns 5 if the input contains a 2 and a 5 separated by a ',''" $
      add "3\n2\n" `shouldBe` 5

    it "returns zero or greater than zero if every number is positive" $
      verboseCheck prop_sumIsAlwaysGreaterThanZeroIfInputContainsPositiveNumbers

prop_sumIsAlwaysGreaterThanZeroIfInputContainsPositiveNumbers :: Property
prop_sumIsAlwaysGreaterThanZeroIfInputContainsPositiveNumbers =
  forAll inputWithPositivesAndDelimiters (\input -> uncurry addWithDelimiter input >= 0)

inputWithPositivesAndDelimiters :: Gen (Char, String)
inputWithPositivesAndDelimiters =
         do del <- delimiter
            numberOfItems <- positive
            positives <- listOfPositives numberOfItems
            return (del, mixDelimiterAndPositives del positives)

positive :: Gen Int
positive = abs `fmap` (arbitrary :: Gen Int) `suchThat` (> 0)

listOfPositives :: Int ->  Gen [Int]
listOfPositives size = vectorOf size positive

delimiter :: Gen Char
delimiter = suchThat arbitrary (/= ' ')

mixDelimiterAndPositives :: Char -> [Int] -> String
mixDelimiterAndPositives del positives =
      let listOfChars = generateListOfChars (length positives) del
          positivesAsChar = toCharArray positives
          tuples = zip positivesAsChar listOfChars;
      in concatMap (\(a,b) -> [a,b]) tuples

generateListOfChars :: Int -> Char -> String
generateListOfChars numberOfItems del = map (const del) [1..numberOfItems]

toCharArray :: [Int] -> String
toCharArray numbers = concatMap show numbers
