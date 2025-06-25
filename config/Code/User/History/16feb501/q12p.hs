{-
-- EPITECH PROJECT, 2025
-- curry
-- File description:
-- doop
-}

myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem x (y:ys)
  | x == y = True
  | otherwise = myElem x ys
