module PrimeFactors.PrimeFactors
(primeFactors)
where

primeFactors :: Integer -> [Integer]
primeFactors n
  | n == 1 = []
  | null nextFactor = [n]
  | otherwise = nextFactor ++ primeFactors (n `div` head nextFactor)
  where nextFactor = take 1 $ primesLowerThanN n

primesLowerThanN :: Integer -> [Integer]
primesLowerThanN n = filter (\x -> (n `mod` x) == 0) [2..n - 1]
