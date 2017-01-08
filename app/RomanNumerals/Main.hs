module RomanNumerals.Main where

import           RomanNumerals.RomanNumerals

main = do putStrLn "Translate arabic to roman and roman to arabic:"
          let x = toRoman 8
          let y = toArabic "VII"
          putStrLn ("toRoman 8 = " ++ show x)
          putStrLn ("toArabic \"VII\" = " ++ show y)
