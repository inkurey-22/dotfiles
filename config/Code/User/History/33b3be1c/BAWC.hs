{-
-- EPITECH PROJECT, 2025
-- day03
-- File description:
-- Game
-}

data Item = Sword | Bow | MagicWand
    deriving (Eq)

instance Show Item where
    show Sword = "sword"
    show Bow = "bow"
    show MagicWand = "magic wand"

data Mob = Mummy
    | Skeleton Item
    | Witch (Maybe Item)
    deriving (Eq)

instance Show Mob where
    show Mummy = "mummy"
    show (Skeleton Bow) = "doomed archer"
    show (Skeleton Sword) = "dead knight"
    show (Skeleton item) = "skeleton holding a " ++ show item
    show (Witch Nothing) = "witch"
    show (Witch (Just MagicWand)) = "sorceress"
    show (Witch (Just item)) = "witch holding a " ++ show item

class HasItem a where
    getItem :: a -> Maybe Item
    hasItem :: a -> Bool
    hasItem x = case getItem x of
        Just _  -> True
        Nothing -> False

instance HasItem Mob where
    getItem Mummy = Nothing
    getItem (Skeleton item) = Just item
    getItem (Witch maybeItem) = maybeItem

createMummy :: Mob
createMummy = Mummy

createArcher :: Mob
createArcher = Skeleton Bow

createKnight :: Mob
createKnight = Skeleton Sword

createWitch :: Mob
createWitch = Witch Nothing

createSorceress :: Mob
createSorceress = Witch (Just MagicWand)

create :: String -> Maybe Mob
create "mummy" = Just createMummy
create "doomed archer" = Just createArcher
create "dead knight" = Just createKnight
create "witch" = Just createWitch
create "sorceress" = Just createSorceress
create _ = Nothing

equip :: Item -> Mob -> Maybe Mob
equip item (Skeleton _) = Just (Skeleton item)
equip item (Witch _) = Just (Witch (Just item))
equip item Mummy = Nothing

{- main :: IO ()
main = do
    print $ hasItem createMummy
    print $ hasItem createArcher
    print $ hasItem createWitch
    print $ hasItem createSorceress
    print $ getItem createKnight
    print $ getItem createWitch
    print $ getItem createSorceress -}
