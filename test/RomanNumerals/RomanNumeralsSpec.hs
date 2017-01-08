module RomanNumerals.RomanNumeralsSpec where

import           RomanNumerals.RomanNumerals
import           Test.Hspec
import           Test.QuickCheck
import           Utils.List
import           Data.Either.Extra

spec = describe "RomanNumerals requirements" $ do
  it "translate from arabic to numeral and back to roman should return the same value" $
    property prop_TranslateBackToArabic
  it "arabic numbers greater than zero returns non empty strings" $
    property prop_NonEmptyStrings
  it "roman numerals V, D or L can never be repeated" $
    property prop_VDLAreNotRepeated
  it "translate from arabic to numeral using negative values returns an error" $
    property prop_NegativeArabicReturnsAnError
  it "translate from arabic to numeral using greater than 3000 values returns an error" $
    property prop_GreatherThan3000ReturnsAnError

prop_TranslateBackToArabic :: Property
prop_TranslateBackToArabic = forAll numberBetweenZeroAndThreeThousand (\n -> toArabic (fromRight $ toRoman n) == n)

prop_NonEmptyStrings :: Property
prop_NonEmptyStrings = forAll nonZeroArabicNumber $ not . null . toRoman

prop_VDLAreNotRepeated :: Property
prop_VDLAreNotRepeated = forAll numberBetweenZeroAndThreeThousand
  (\n -> let translation = fromRight $ toRoman n
      in containsJustOne translation V
      && containsJustOne translation D
      && containsJustOne translation L)

prop_NegativeArabicReturnsAnError :: Property
prop_NegativeArabicReturnsAnError = forAll negative (\n -> toRoman n == Left NegativeNumberNotSupported)

prop_GreatherThan3000ReturnsAnError :: Property
prop_GreatherThan3000ReturnsAnError = forAll greaterThanThreeThousand
  (\n -> toRoman n == Left NumberGreaterThan3000NotSupported)

numberBetweenZeroAndThreeThousand :: Gen Integer
numberBetweenZeroAndThreeThousand = do i <- arbitrary
                                       return (abs i `mod` 3001)

nonZeroArabicNumber :: Gen Integer
nonZeroArabicNumber = suchThat numberBetweenZeroAndThreeThousand (>0)

negative :: Gen Integer
negative = do n <- suchThat arbitrary (>0)
              return (n * (-1))

greaterThanThreeThousand :: Gen Integer
greaterThanThreeThousand = do n <- numberBetweenZeroAndThreeThousand
                              return (n + 3001)

containsJustOne :: String -> RomanNumeral -> Bool
containsJustOne string roman = containsOneOrNothing (head $ show roman) string
