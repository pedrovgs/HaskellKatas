module Fibonacci.FibonacciSpec where

import           Data.Maybe
import           Fibonacci.Fibonacci
import           Test.Hspec
import           Test.QuickCheck

spec = describe "Fibonacci requirements" $ do
  it "tail recursive and regular implementation of the fibonacci sequence returns the same value" $
    verboseCheckWith stdArgs { maxSuccess = 20 }  $ forAll smallValues (\n -> fibonacci n == fibonacciTailRec n)
  it "tail recursive implementation" $
    verboseCheckWith stdArgs { maxSuccess = 200 } prop_TailRecursiveFibonacci

prop_TailRecursiveFibonacci :: Property
prop_TailRecursiveFibonacci =
  forAll mediumValues $ \n -> fromJust $ do x <- fibonacciTailRec n
                                            y <- fibonacciTailRec (n - 1)
                                            z <- fibonacciTailRec (n - 2)
                                            return (x == y + z)

positive :: Gen Integer
positive = do n <- arbitrary
              return (abs n)

smallValues :: Gen Integer
smallValues = choose (2, 21)

mediumValues :: Gen Integer
mediumValues = choose(2, 1000)
