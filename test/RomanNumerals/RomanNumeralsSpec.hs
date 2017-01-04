module RomanNumerals.RomanNumeralsSpec where

import           RomanNumerals.RomanNumerals
import           Test.Hspec
import           Test.QuickCheck
import           Utils.List

spec = describe "RomanNumerals requirements" $ do
  it "translate from arabic to numeral and back to roman should return the same value" $
    property prop_TranslateBackToArabic
  it "arabic numbers greater than zero returns non empty strings" $
    property prop_NonEmptyStrings
  it "roman numerals V, D or L can never be repeated" $
    property prop_VDLAreNotRepeated

prop_TranslateBackToArabic :: Property
prop_TranslateBackToArabic = forAll numberBetweenZeroAndThreeThousand (\n -> toArabic (toRoman n) == n)

prop_NonEmptyStrings :: Property
prop_NonEmptyStrings = forAll nonZeroArabicNumber $ not . null . toRoman

prop_VDLAreNotRepeated :: Property
prop_VDLAreNotRepeated = forAll numberBetweenZeroAndThreeThousand
  (\n -> let translation = toRoman n
      in containsJustOne translation V
      && containsJustOne translation D
      && containsJustOne translation L)

numberBetweenZeroAndThreeThousand :: Gen Integer
numberBetweenZeroAndThreeThousand = do i <- arbitrary
                                       return (abs i `mod` 3001)

nonZeroArabicNumber :: Gen Integer
nonZeroArabicNumber = suchThat numberBetweenZeroAndThreeThousand (>0)

containsJustOne :: String -> RomanNumeral -> Bool
containsJustOne string roman = containsOneOrNothing (head $ show roman) string
