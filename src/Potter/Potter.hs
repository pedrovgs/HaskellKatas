module Potter.Potter
( HarryPotterBook(..)
, calculatePrice
, oneBookPrice
)where

import           Data.List

data HarryPotterBook = Book1 | Book2 | Book3 | Book4 | Book5 deriving (Enum, Bounded, Show, Eq)

calculatePrice :: [HarryPotterBook] -> Float
calculatePrice books = calculatePriceInner groupedBooks
  where groupedBooks = map length (group books)

calculatePriceInner :: [Int] -> Float
calculatePriceInner groupedBooks
  | differentBooks == 0 = 0
  | differentBooks == 1 = oneBookPrice * fromIntegral (head groupedBooks)
  | differentBooks == 2 = oneBookPrice * 2.0 * 0.95 + calculatePriceInner (removeBooksFromCart groupedBooks)
  | differentBooks == 3 = oneBookPrice * 3.0 * 0.90 + calculatePriceInner (removeBooksFromCart groupedBooks)
  | differentBooks == 4 = oneBookPrice * 4.0 * 0.80 + calculatePriceInner (removeBooksFromCart groupedBooks)
  | differentBooks == 5 = oneBookPrice * 5.0 * 0.75 + calculatePriceInner (removeBooksFromCart groupedBooks)
  where differentBooks = length groupedBooks

oneBookPrice = 8.0

removeBooksFromCart :: [Int] -> [Int]
removeBooksFromCart groupedBooks = filter (>0) updatedGroups
  where updatedGroups = map (\x -> x - 1) groupedBooks
