module RomanNumerals.RomanNumerals
( RomanNumeral(..)
, toRoman)
where

data RomanNumeral =  I | IV | V | IX | X | L | XC | C | D | CM | M
  deriving (Enum, Eq, Ord, Bounded, Show)

toRoman :: Int -> String
toRoman n = toString $ toRomanInner n []

-- toArabic

toRomanInner :: Int -> [RomanNumeral] -> [RomanNumeral]
toRomanInner 0 acc = acc
toRomanInner n acc = toRomanInner (n - closerRomanValue) (acc++[closerRoman])
  where closerRoman = extractCloserRoman n
        closerRomanValue = romanValue closerRoman

extractCloserRoman :: Int -> RomanNumeral
extractCloserRoman n = last $ takeWhile (`canExtract` n) romanNumerals

canExtract :: RomanNumeral -> Int -> Bool
canExtract roman n = n - romanValue roman >= 0

romanNumerals :: [RomanNumeral]
romanNumerals =  [minValue..maxValue]
  where maxValue = maxBound::RomanNumeral
        minValue = minBound::RomanNumeral

romanValue :: RomanNumeral -> Int
romanValue I  = 1
romanValue IV = 4
romanValue V  = 5
romanValue IX = 9
romanValue X  = 10
romanValue L  = 50
romanValue XC = 90
romanValue C  = 100
romanValue D  = 500
romanValue CM = 900
romanValue M  = 1000

toString :: [RomanNumeral] -> String
toString = foldr ((++) . show) ""
