module Fibonacci.Fibonacci
(fibonacci
, fibonacciTailRec) where

fibonacci :: Integer -> Maybe Integer
fibonacci 0 = Just 0
fibonacci 1 = Just 1
fibonacci n = if n < 0 then Nothing
              else do a <- fibonacci (n - 1)
                      b <- fibonacci (n - 2)
                      Just (a + b)

fibonacciTailRec :: Integer -> Maybe Integer
fibonacciTailRec n
  | n < 0 = Nothing
  | otherwise = Just (fibonacciTailRecInner n 1 0)

fibonacciTailRecInner :: Integer -> Integer -> Integer -> Integer
fibonacciTailRecInner 0 _ b = b
fibonacciTailRecInner n a b = fibonacciTailRecInner (n - 1) (a + b) a
