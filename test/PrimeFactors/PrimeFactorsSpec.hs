module PrimeFactors.PrimeFactorsSpec where

import           PrimeFactors.PrimeFactors
import           Test.Hspec
import           Test.QuickCheck

spec = describe "PrimeFactors requirements" $ do
  it "positive numbers have at least one prime factor" $
    property prop_AtLeastCotainsOnePrimeFactor
  it "prime numbers have just one prime factor equal to the prime number" $
    property prop_PrimeNumbersContainJustOnePrimeFactor
  it "the product of a number prime factors is equal to the number" $
    property prop_TheProductOfPrimeFactorsIsEqualToTheNumber
  it "if the number is not prime the number of prime factors is at least two" $
    property prop_NonPrimeNumbersContainsAtLeastTwoPrimeFactors

prop_AtLeastCotainsOnePrimeFactor :: Property
prop_AtLeastCotainsOnePrimeFactor = forAll positive
  (\n -> let factors = primeFactors n
             numberOfPrimeFactors = length factors
         in numberOfPrimeFactors >= 1)

prop_PrimeNumbersContainJustOnePrimeFactor :: Property
prop_PrimeNumbersContainJustOnePrimeFactor = forAll prime
  (\n -> let factors = primeFactors n
             numberOfPrimeFactors = length factors
         in numberOfPrimeFactors == 1 && factors == [n])

prop_TheProductOfPrimeFactorsIsEqualToTheNumber :: Property
prop_TheProductOfPrimeFactorsIsEqualToTheNumber = forAll positive
  (\n -> let factors = primeFactors n
             factorsProduct = product factors
         in factorsProduct == n)

prop_NonPrimeNumbersContainsAtLeastTwoPrimeFactors :: Property
prop_NonPrimeNumbersContainsAtLeastTwoPrimeFactors = forAll positiveNotPrime
  (\n -> let factors = primeFactors n
             numberOfPrimeFactors = length factors
         in numberOfPrimeFactors >= 2)

prop_NegativeNumbersDoesNotHavePrimeFactors :: Property
prop_NegativeNumbersDoesNotHavePrimeFactors = forAll negative
  (\n -> let factors = primeFactors n
         in null factors)

positive :: Gen Integer
positive = do i <- arbitrary
              return (abs i + 2)

negative :: Gen Integer
negative = do i <- positive
              return (i * (-1))

prime :: Gen Integer
prime = do i <- arbitrary
           return (primes !! abs i)

positiveNotPrime :: Gen Integer
positiveNotPrime = suchThat positive (not . isPrime)

isPrime :: Integer -> Bool
isPrime k = null [ x | x <- [2..k - 1], k `mod` x == 0]

primes :: [Integer]
primes = infinitePrimes [2..]
  where infinitePrimes (p:xs) = p : infinitePrimes [x|x <- xs, x `mod` p > 0]
