module Fibonacci.Main where

import           Fibonacci.Fibonacci

main = do putStrLn "Fibonacci sequence numbers:"
          let x = fibonacci 5
          let y = fibonacciTailRec 50
          putStrLn ("fibonacci 5 = " ++ show x)
          putStrLn ("fibonacciTailRec 50 = " ++ show y)
