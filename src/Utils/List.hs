module Utils.List where

containsAll :: (Eq a) => [a] -> [a] -> Bool
containsAll l1 l2 = all (`elem` l2) l1

containsOneOrNothing :: (Eq a) => a -> [a] -> Bool
containsOneOrNothing x list = length filteredList <= 1
  where filteredList = filter (\i -> x == i) list
