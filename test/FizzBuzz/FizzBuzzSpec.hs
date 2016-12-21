module FizzBuzz.FizzBuzzSpec where

import           FizzBuzz.FizzBuzz
import           Test.Hspec
import           Test.QuickCheck

spec = describe "FizzBuzz requirements" $ do
    it "returns Fizz if the number is 3" $
      fizzBuzz 3 `shouldBe` "Fizz"

    it "returns Buzz if the number is 5" $
      fizzBuzz 5 `shouldBe` "Buzz"

    it "returns FizzBuzz if the number is 15" $
      fizzBuzz 15 `shouldBe` "FizzBuzz"

    it "returns 1 as String if the number is 1" $
      fizzBuzz 1 `shouldBe` "1"

    it "returns Fizz if the input is a multiple of 3 and not 5" $
      verboseCheck prop_justMultipleOfThree

    it "returns Buzz if the input is a a multiple of 5 and not 3" $
      property prop_justMultipleOfFive

    it "returns FizzBuzz if the input is a a multiple of 3 and 5" $
      property prop_multipleOfThreeAndFive

    it "returns the number as String if the input is not a a multiple of 3 or 5" $
      property prop_multipleOfThreeAndFive

prop_justMultipleOfThree :: Property
prop_justMultipleOfThree = forAll justMultipleOfThree (\n -> fizzBuzz n == "Fizz")

prop_justMultipleOfFive :: Property
prop_justMultipleOfFive = forAll justMultipleOfFive (\n -> fizzBuzz n == "Buzz")

prop_multipleOfThreeAndFive :: Property
prop_multipleOfThreeAndFive = forAll multipleOfThreeAndFive (\n -> fizzBuzz n == "FizzBuzz")

prop_anyNumberNotMultipleOfThreeOrFive :: Property
prop_anyNumberNotMultipleOfThreeOrFive = forAll multipleOfThreeAndFive (\n -> fizzBuzz n == show n)

justMultipleOfThree :: Gen Int
justMultipleOfThree = suchThat arbitrary (\n -> n `mod` 3 == 0 && n `mod` 5 /= 0)
justMultipleOfFive :: Gen Int
justMultipleOfFive = suchThat arbitrary (\n -> n `mod` 5 == 0 && n `mod` 3 /= 0)
multipleOfThreeAndFive :: Gen Int
multipleOfThreeAndFive = suchThat arbitrary (\n -> n `mod` 5 == 0 && n `mod` 3 == 0)
anyNumberNotMultipleOfThreeOrFive :: Gen Int
anyNumberNotMultipleOfThreeOrFive = suchThat arbitrary (\n -> n `mod` 5 /= 0 && n `mod` 3 /= 0)
