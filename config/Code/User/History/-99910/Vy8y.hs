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
    | otherwise = Node left val (addInTree x right)

instance Functor Tree where
    fmap _ Empty = Empty
    fmap f (Node left val right) =
        Node (fmap f left) (f val) (fmap f right)

listToTree :: Ord a => [a] -> Tree a
listToTree = foldr addInTree Empty

treeToList :: Tree a -> [a]
treeToList Empty = []
treeToList (Node left val right) = treeToList left ++ [val] ++ treeToList right

treeSort :: Ord a => [a] -> [a]
treeSort = treeToList . listToTree

instance Foldable Tree where
    foldMap _ Empty = mempty
    foldMap f (Node left val right) =
        foldMap f left <> f val <> foldMap f right

        main :: IO ()
        main = do
            let values = [5, 3, 8, 1, 4, 7, 9]
            let tree = listToTree values
            putStrLn "Original list:"
            print values
            putStrLn "\nTree (using Show instance):"
            print tree
            putStrLn "\nTree to list (in-order traversal):"
            print (treeToList tree)
            putStrLn "\nTree sorted:"
            print (treeSort values)
            putStrLn "\nTree after fmap (*2):"
            print (fmap (*2) tree)
            putStrLn "\nSum of all elements in the tree (using Foldable):"
            print (sum tree)