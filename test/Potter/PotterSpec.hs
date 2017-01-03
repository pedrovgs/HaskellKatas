module Potter.PotterSpec where

import           Data.Fixed
import           Potter.Potter
import           Test.Hspec
import           Test.QuickCheck
import           Utils.List

spec = describe "Potter requirements" $ do
  it "an empty cart costs 0 EUR" $
    calculatePrice [] == 0.0
  it "just one book costs 8 EUR" $
    property prop_BuyJustOneBookCostsEightEuros
  it "if there are two different books the cost of every repeated book is a 5% less" $
    property prop_BuyTwoDifferentBooksReducedsThePriceA5Percent
  it "if there are three different books the cost of every repeated book is a 10% less" $
    property prop_BuyThreeDifferentBooksReducedsThePriceA10Percent
  it "if there are four different books the cost of every repeated book is a 20% less" $
    property prop_BuyFourDifferentBooksReducedsThePriceA20Percent
  it "if there are five different books the cost of every repeated book is a 25% less" $
    property prop_BuyFiveDifferentBooksReducedsThePriceA25Percent
  it "if all the books are the same there is no discount" $
    property prop_ThereIsNoDiscountIfTheBooksAreAlwaysTheSame
  it "2 book1, 2 book2, 2 book3, 1 book4 and 1 book5 costs 51.60 EUR" $
    calculatePrice [Book1, Book1, Book2, Book2, Book3, Book3, Book4, Book5] `closeEnough` 51.60
  it "2 book1, 1 book1 costs 23,2 EUR" $
    calculatePrice [Book1, Book1, Book2]  `closeEnough` 23.2

prop_BuyJustOneBookCostsEightEuros :: Property
prop_BuyJustOneBookCostsEightEuros = forAll harryPotterBook (\book  -> calculatePrice [book] `closeEnough` 8.0)

prop_BuyTwoDifferentBooksReducedsThePriceA5Percent :: Property
prop_BuyTwoDifferentBooksReducedsThePriceA5Percent =
  forAll (differentHarryPotterBooks 2) (\cart -> calculatePrice cart `closeEnough` 15.2)

prop_BuyThreeDifferentBooksReducedsThePriceA10Percent :: Property
prop_BuyThreeDifferentBooksReducedsThePriceA10Percent =
    forAll (differentHarryPotterBooks 3) (\cart -> calculatePrice cart `closeEnough` 21.6)

prop_BuyFourDifferentBooksReducedsThePriceA20Percent :: Property
prop_BuyFourDifferentBooksReducedsThePriceA20Percent =
    forAll (differentHarryPotterBooks 4) (\cart -> calculatePrice cart `closeEnough` 25.6)

prop_BuyFiveDifferentBooksReducedsThePriceA25Percent :: Property
prop_BuyFiveDifferentBooksReducedsThePriceA25Percent =
    forAll (differentHarryPotterBooks 5) (\cart -> calculatePrice cart `closeEnough` 30.0)

prop_ThereIsNoDiscountIfTheBooksAreAlwaysTheSame :: Int -> Property
prop_ThereIsNoDiscountIfTheBooksAreAlwaysTheSame n = forAll
      (sameHarryPotterBooks n) (\cart -> calculatePrice cart `mod'` 8.0 == 0)

harryPotterBook :: Gen HarryPotterBook
harryPotterBook = elements [(minBound::HarryPotterBook) .. (maxBound::HarryPotterBook)]

differentHarryPotterBooks :: Int -> Gen [HarryPotterBook]
differentHarryPotterBooks n = do book <- harryPotterBook
                                 return (generateDifferentList n book)

sameHarryPotterBooks :: Int -> Gen [HarryPotterBook]
sameHarryPotterBooks n = do book <- harryPotterBook
                            return (replicate n book)

next :: HarryPotterBook -> HarryPotterBook
next Book5 = Book1
next book  = succ book

closeEnough :: Float -> Float -> Bool
closeEnough x y = abs (x - y) <= 0.1

generateDifferentList :: Int -> HarryPotterBook -> [HarryPotterBook]
generateDifferentList 1 currentBook = [currentBook]
generateDifferentList n currentBook = currentBook : (generateDifferentList nextSize nextBook)
  where nextSize = n -1
        nextBook = next currentBook
