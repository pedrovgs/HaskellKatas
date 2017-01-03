module Potter.Potter where

import           Data.List

data HarryPotterBook = Book1 | Book2 | Book3 | Book4 | Book5 deriving (Enum, Bounded, Show, Eq)

calculatePrice :: [HarryPotterBook] -> Float
calculatePrice []  = 0.0
calculatePrice [x] = 8.0
calculatePrice cart = calculatePriceWithDiscount $ map length (group cart)

calculatePriceWithDiscount :: [Int] -> Float
calculatePriceWithDiscount groupedBooks
  | differentBooks == 0 = 0
  | differentBooks == 1 = oneBookPrice * fromIntegral (head groupedBooks)
  | differentBooks == 2 = oneBookPrice * 2.0 * 0.95 + calculatePriceWithDiscount (removeBooksFromCart groupedBooks)
  | differentBooks == 3 = oneBookPrice * 3.0 * 0.90 + calculatePriceWithDiscount (removeBooksFromCart groupedBooks)
  | differentBooks == 4 = oneBookPrice * 4.0 * 0.80 + calculatePriceWithDiscount (removeBooksFromCart groupedBooks)
  | differentBooks == 5 = oneBookPrice * 5.0 * 0.75 + calculatePriceWithDiscount (removeBooksFromCart groupedBooks)
  where differentBooks = length groupedBooks

oneBookPrice = 8.0

removeBooksFromCart :: [Int] -> [Int]
removeBooksFromCart groupedBooks = filter (>0) updatedGroups
  where updatedGroups = map (\x -> x - 1) groupedBooks
