module StringCalculator.Main where

import           StringCalculator.StringCalculator

main = do print "String calculator:"
          let result1 = add "\n1\n4\n"
              result2 = add "1,4,67,"
              result3 = add "//x12x3x55x"
          print ("Adding using \\n as separator = " ++ show result1)
          print ("Adding using , as separator = " ++ show result2)
          print ("Adding using x as custom separator = " ++ show result3)
