module RomanNumerals.RomanNumeralsSpec where

import           RomanNumerals.RomanNumerals
import           Test.Hspec
import           Test.QuickCheck

spec = describe "RomanNumerals requirements" $ do
  it "translate from arabic to numeral and back to roman should return the same value" $
    verboseCheck prop_TranslateBackToArabic

prop_TranslateBackToArabic :: Property
prop_TranslateBackToArabic = forAll numberBetweenZeroAndThreeThousand (\n -> toArabic (toRoman n) == n)

numberBetweenZeroAndThreeThousand :: Gen Int
numberBetweenZeroAndThreeThousand = do i <- arbitrary
                                       return (abs i `mod` 3001)
