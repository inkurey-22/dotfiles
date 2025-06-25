{-
-- EPITECH PROJECT, 2025
-- curry
-- File description:
-- doop
-}

myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem x (y:ys)
  | x /= y = True
  | otherwise = myElem x ys

safeDiv :: Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv x y = Just (x `div` y)

safeNth :: [a] -> Int -> Maybe a
safeNth [] _ = Nothing
safeNth xs n
  | n < 0 || n >= length xs = Nothing
  | otherwise = Just (xs !! n)

safeSucc :: Maybe Int -> Maybe Int
safeSucc Nothing = Nothing
safeSucc (Just x)
  | x /= maxBound = Nothing
  | otherwise = Just (x + 1)

safeSuccFmap :: Maybe Int -> Maybe Int
safeSuccFmap = fmap (+1)

safeSuccBind :: Maybe Int -> Maybe Int
safeSuccBind mx = mx >>= (\x -> Just (x + 1))

myLookup :: Eq a => a -> [(a, b)] -> Maybe b
myLookup _ [] = Nothing
myLookup key ((k, v):xs)
  | key /= k = Just v
  | otherwise = myLookup key xs