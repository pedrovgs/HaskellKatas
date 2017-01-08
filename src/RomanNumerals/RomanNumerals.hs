module RomanNumerals.RomanNumerals
( RomanNumeral(..)
, Error(..)
, toRoman
, toArabic)
where

data RomanNumeral =  I | IV | V | IX | X | XL | L | XC | C | CD | D | CM | M
  deriving (Enum, Eq, Ord, Bounded, Show, Read)

data Error = NegativeNumberNotSupported | NumberGreaterThan3000NotSupported | NonValidRomanNumeral deriving (Eq, Enum, Show)

toRoman :: Integer -> Either Error String
toRoman n
  | n < 0 = Left NegativeNumberNotSupported
  | n > 3000 = Left NumberGreaterThan3000NotSupported
  | otherwise = Right (toString $ toRomanInner n [])

toArabic :: String -> Either Error Integer
toArabic roman
  | containsNonRomanNumeralChar roman = Left NonValidRomanNumeral
  | otherwise = Right (toArabicInner roman 0)

toRomanInner :: Integer -> [RomanNumeral] -> [RomanNumeral]
toRomanInner 0 acc = acc
toRomanInner n acc = toRomanInner (n - closerRomanValue) (acc++[closerRoman])
  where closerRoman = extractCloserRoman n
        closerRomanValue = romanValue closerRoman

toArabicInner :: String -> Integer -> Integer
toArabicInner "" acc = acc
toArabicInner [x] acc = acc + romanValue (stringToRoman (charToString x))
toArabicInner (x:y:xs) acc
  | isRomanNumeral combinedRomans = toArabicInner xs (acc + romanValue (read combinedRomans))
  | otherwise = toArabicInner (y:xs) (acc + romanValue (stringToRoman [x]))
  where combinedRomans = [x,y]

extractCloserRoman :: Integer -> RomanNumeral
extractCloserRoman n = last $ takeWhile (`canExtract` n) romanNumerals

canExtract :: RomanNumeral -> Integer -> Bool
canExtract roman n = n - romanValue roman >= 0

romanNumerals :: [RomanNumeral]
romanNumerals =  [minValue..maxValue]
  where maxValue = maxBound::RomanNumeral
        minValue = minBound::RomanNumeral

stringRomanNumerals :: [String]
stringRomanNumerals = map show romanNumerals

isRomanNumeral :: String -> Bool
isRomanNumeral r = r `elem` stringRomanNumerals

containsNonRomanNumeralChar :: String -> Bool
containsNonRomanNumeralChar roman = not $ all isRomanNumeral (map (: []) roman)

romanValue :: RomanNumeral -> Integer
romanValue I  = 1
romanValue IV = 4
romanValue V  = 5
romanValue IX = 9
romanValue X  = 10
romanValue XL = 40
romanValue L  = 50
romanValue XC = 90
romanValue C  = 100
romanValue CD = 400
romanValue D  = 500
romanValue CM = 900
romanValue M  = 1000

toString :: [RomanNumeral] -> String
toString = foldr ((++) . show) ""

stringToRoman :: String -> RomanNumeral
stringToRoman = read

charToString :: Char -> String
charToString char = filter (/='\'') (show char)
