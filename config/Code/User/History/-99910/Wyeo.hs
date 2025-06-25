{-
-- EPITECH PROJECT, 2025
-- day03
-- File description:
-- Tree
-}

data Tree a = Empty | Node (Tree a) a (Tree a)
    deriving (Show)

{- instance Show a => Show (Tree a) where
    show Empty = "Empty"
    show (Node left val right) =
        "Node " ++ show left ++ " " ++ show val ++ " " ++ show right -}

addInTree :: Ord a => a -> Tree a -> Tree a
addInTree x Empty = Node Empty x Empty
addInTree x (Node left val right)
    | x < val   = Node (addInTree x left) val right
    | x > val   = Node left val (addInTree x right)
    | otherwise = Node left val right