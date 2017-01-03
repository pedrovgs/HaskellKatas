module Utils.List where

containsAll :: (Eq a) => [a] -> [a] -> Bool
containsAll l1 l2 = all (`elem` l2) l1
