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
    | Skeleteon Item
    | Witch (Maybe Item)
    deriving (Eq, Show)

