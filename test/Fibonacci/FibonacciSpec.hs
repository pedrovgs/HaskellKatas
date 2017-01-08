module Fibonacci.FibonacciSpec where

import           Data.Maybe
import           Fibonacci.Fibonacci
import           Test.Hspec
import           Test.QuickCheck

spec = describe "Fibonacci requirements" $ do
  it "tail recursive and regular implementation of the fibonacci sequence returns the same value" $
    quickCheckWith stdArgs { maxSuccess = 20 }  $ forAll smallValues (\n -> fibonacci n == fibonacciTailRec n)
  it "tail recursive implementation" $
    quickCheckWith stdArgs { maxSuccess = 200 } prop_TailRecursiveFibonacci
  it "negative numbers returns nothing as result for every implementation" $
    property prop_NegativeNumbersReturnNothing

prop_TailRecursiveFibonacci :: Property
prop_TailRecursiveFibonacci =
  forAll mediumValues $ \n -> fromJust $ do x <- fibonacciTailRec n
                                            y <- fibonacciTailRec (n - 1)
                                            z <- fibonacciTailRec (n - 2)
                                            return (x == y + z)

prop_NegativeNumbersReturnNothing :: Property
prop_NegativeNumbersReturnNothing = forAll negative $ \n -> isNothing (fibonacci n)
                                                            && isNothing (fibonacciTailRec n)

positive :: Gen Integer
positive = do n <- arbitrary
              return (abs n)

negative :: Gen Integer
negative = do n <- suchThat positive (>0)
              return (n * (-1))

smallValues :: Gen Integer
smallValues = choose (2, 21)

mediumValues :: Gen Integer
mediumValues = choose(2, 1000)
