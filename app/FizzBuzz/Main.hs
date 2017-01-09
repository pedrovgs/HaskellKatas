module FizzBuzz.Main where

import           FizzBuzz.FizzBuzz

main = do print "FizzBuzz:"
          print ("FizzBuzz 1 = " ++ fizzBuzz 1)
          print ("FizzBuzz 3 = " ++ fizzBuzz 3)
          print ("FizzBuzz 5 = " ++ fizzBuzz 5)
          print ("FizzBuzz 11 = " ++ fizzBuzz 11)
