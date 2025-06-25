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
    deriving (Eq, Show)

createMummy :: Mob
createMummy = Mummy

createArcher :: Mob
createArcher = Skeleton Bow