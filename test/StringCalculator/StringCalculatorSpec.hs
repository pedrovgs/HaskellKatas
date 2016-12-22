module StringCalculator.StringCalculatorSpec where

import           StringCalculator.StringCalculator
import           Test.Hspec
import           Test.QuickCheck

spec = describe "StringCalculator requirements" $ do
    it "returns 0 if the input is empty" $
      add "" `shouldBe` 0

    it "returns 3 if the input contains just the number 3" $
      add "3" `shouldBe` 3

    it "returns 5 if the input contains a 2 and a 5 separated by a \n" $
      add "3\n2" `shouldBe` 5
