module RomanNumerals.RomanNumeralsSpec where

import           RomanNumerals.RomanNumerals
import           Test.Hspec
import           Test.QuickCheck

spec = describe "RomanNumerals requirements" $ do
  it "translates 1 as I" $
    toRoman 1 == "I"
  it "translates 3 as III" $
    toRoman 3 == "III"
  it "translates 5 as V" $
    toRoman 5 == "V"
  it "translates 0 as empty" $
    null $ toRoman 0
  it "translates 100 as C" $
    toRoman 100 == "C"
  it "translates 1990 as MCMXC" $
    toRoman 1990 == "MCMXC"
