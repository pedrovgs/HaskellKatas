module Fibonacci.Fibonacci
(fibonacci
, fibonacciTailRec) where

fibonacci :: Integer -> Integer
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 1) + fibonacci (n - 2)

fibonacciTailRec :: Integer -> Integer
fibonacciTailRec n = fibonacciTailRecInner n 1 0

fibonacciTailRecInner :: Integer -> Integer -> Integer -> Integer
fibonacciTailRecInner 0 _ b = b
fibonacciTailRecInner n a b = fibonacciTailRecInner (n - 1) (a + b) a
