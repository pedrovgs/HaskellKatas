module PrimeFactors.Main where

import           PrimeFactors.PrimeFactors

main = do print "Prime factors:"
          let factorsOf1 = primeFactors 1
          let factorsOf11 = primeFactors 11
          let factorsOf66 = primeFactors 66
          let factorsOfNegatie = primeFactors (-1)
          print ("Prime factors of 1 = " ++ show factorsOf1)
          print ("Prime factors of 11 = " ++ show factorsOf11)
          print ("Prime factors of 66 = " ++ show factorsOf66)
          print ("Prime factors of a negative number = " ++ show factorsOfNegatie)
