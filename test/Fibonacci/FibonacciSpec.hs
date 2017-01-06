module Fibonacci.FibonacciSpec where

import Test.Hspec
import Test.QuickCheck
import Fibonacci.Fibonacci

spec = describe "Fibonacci requirements" $ do
  it "tail recursive and regular implementation of the fibonacci sequence returns the same value" $
    property $ forAll smallValues (\n -> fibonacci n == fibonacciTailRec n)
  it "tail recursive implementation" $
    quickCheckWith stdArgs { maxSuccess = 5 } prop_TailRecursiveFibonacci
  it "non tail recursive implementation" $
    quickCheckWith stdArgs { maxSuccess = 5 } prop_NonTailRecursiveFibonacci

prop_NonTailRecursiveFibonacci :: Property
prop_NonTailRecursiveFibonacci =
  forAll smallValues
    (\n -> let x = fibonacci n
               y = fibonacci (n - 1)
               z = fibonacci (n - 2)
           in x == y + z)

prop_TailRecursiveFibonacci :: Property
prop_TailRecursiveFibonacci =
  forAll smallValues
    (\n -> let x = fibonacciTailRec n
               y = fibonacciTailRec (n - 1)
               z = fibonacciTailRec (n - 2)
           in x == y + z)

positive :: Gen Integer
positive = do n <- arbitrary
              return (abs n)

smallValues :: Gen Integer
smallValues = choose (2, 21)
