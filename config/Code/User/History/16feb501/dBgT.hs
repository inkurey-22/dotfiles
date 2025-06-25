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
  | x == maxBound = Nothing
  | otherwise = Just (x + 1)

safeSuccFmap :: Maybe Int -> Maybe Int
safeSuccFmap = fmap (+1)

safeSuccBind :: Maybe Int -> Maybe Int
safeSuccBind mx = mx >>= (\x -> Just (x + 1))

myLookup :: Eq a => a -> [(a, b)] -> Maybe b
myLookup _ [] = Nothing
myLookup key ((k, v):xs)
  | key == k = Just v
  | otherwise = myLookup key xs

maybeDo :: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
maybeDo _ Nothing _ = Nothing
maybeDo _ _ Nothing = Nothing
maybeDo f (Just x) (Just y) = Just (f x y)

maybeDoBind :: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
maybeDoBind f mx my =
  mx >>= (\x -> my >>= (\y -> Just (f x y)))

readInt :: String -> Maybe Int
readInt "" = Nothing
readInt ('-':xs) = fmap negate (readInt xs)
readInt ('+':xs) = readUnsigned xs
readInt xs = readUnsinged xs