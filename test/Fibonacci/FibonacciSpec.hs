module Fibonacci.FibonacciSpec where

import           Fibonacci.Fibonacci
import           Test.Hspec
import           Test.QuickCheck

spec = describe "Fibonacci requirements" $ do
  it "tail recursive and regular implementation of the fibonacci sequence returns the same value" $
    quickCheckWith stdArgs { maxSuccess = 20 }  $ forAll smallValues (\n -> fibonacci n == fibonacciTailRec n)
  it "non tail recursive implementation" $
    quickCheckWith stdArgs { maxSuccess = 5 } prop_NonTailRecursiveFibonacci
  it "tail recursive implementation" $
    quickCheckWith stdArgs { maxSuccess = 200 } prop_TailRecursiveFibonacci

prop_NonTailRecursiveFibonacci :: Property
prop_NonTailRecursiveFibonacci =
  forAll smallValues
    (\n -> let x = fibonacci n
               y = fibonacci (n - 1)
               z = fibonacci (n - 2)
           in x == y + z)

prop_TailRecursiveFibonacci :: Property
prop_TailRecursiveFibonacci =
  forAll mediumValues
    (\n -> let x = fibonacciTailRec n
               y = fibonacciTailRec (n - 1)
               z = fibonacciTailRec (n - 2)
           in x == y + z)

positive :: Gen Integer
positive = do n <- arbitrary
              return (abs n)

smallValues :: Gen Integer
smallValues = choose (2, 21)

mediumValues :: Gen Integer
mediumValues = choose(2, 1000)
