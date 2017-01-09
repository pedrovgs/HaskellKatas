module Potter.Main where

import           Potter.Potter

main = do print "Kata Potter:"
          let cartPrice = calculatePrice [Book1, Book2, Book3, Book4]
              cartPrice' = calculatePrice [Book1, Book1, Book2]
          print ("Cart 1 price = " ++ show cartPrice)
          print ("Cart 2 price = " ++ show cartPrice')
