module Potter.PotterSpec where

import           Potter.Potter
import           Test.Hspec
import           Test.QuickCheck

spec = describe "Potter requirements" $ do
  it "an empty cart costs 0 EUR" $
    calculatePrice [] == 0.0
  it "just one book costs 8 EUR" $
    property prop_BuyJustOneBookCostsEightEuros


prop_BuyJustOneBookCostsEightEuros :: Property
prop_BuyJustOneBookCostsEightEuros = forAll harryPotterBook (\book  -> calculatePrice [book] == 8.0)

harryPotterBook :: Gen HarryPotterBook
harryPotterBook = elements [(minBound::HarryPotterBook) .. (maxBound::HarryPotterBook)]
