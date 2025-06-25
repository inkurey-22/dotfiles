{-
-- EPITECH PROJECT, 2025
-- curry
-- File description:
-- doop
-}

import Data.Char (isDigit)
import Data.Maybe (fromMaybe)
import System.Environment (getArgs)
import System.Exit (exitWith, ExitCode(ExitFailure))

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

readUnsigned :: String -> Maybe Int
readUnsigned "" = Nothing
readUnsigned xs
  | all isDigit xs = Just (foldl (\acc d -> acc * 10 + digitToInt d) 0 xs)
  | otherwise = Nothing
  where
    digitToInt c = fromEnum c - fromEnum '0'

readInt :: String -> Maybe Int
readInt "" = Nothing
readInt ('-':xs) = fmap negate (readInt xs)
readInt ('+':xs) = readUnsigned xs
readInt xs = readUnsigned xs

getLineLength :: IO Int
getLineLength = fmap length getLine

printAndGetLength :: String -> IO Int
printAndGetLength str = putStrLn str >> return (length str)

printBody :: Int -> IO ()
printBody width = putStrLn ("|" ++ replicate width ' ' ++ "|")

printBox :: Int -> IO ()
printBox n
  | n < 2 = return ()
  | otherwise =
      let width = n * 2 - 2
      in  putStrLn ("*" ++ replicate width '-' ++ "*")
          >> mapM_ (const (printBody width)) [1 .. n - 2]
          >> putStrLn ("*" ++ replicate width '-' ++ "*")

concatLines :: Int -> IO String
concatLines n
  | n <= 0 = return ""
  | otherwise = do
      line <- getLine
      rest <- concatLines (n - 1)
      return (line ++ rest)

getInt :: IO (Maybe Int)
getInt = do
  input <- getLine
  return (readInt input)

doOp :: Int -> String -> Int -> Maybe Int
doOp x "+" y = Just (x + y)
doOp x "-" y = Just (x - y)
doOp x "*" y = Just (x * y)
doOp x "/" y = safeDiv x y
doOp x "%" y = if y == 0 then Nothing else Just (x `mod` y)
doOp _ _ _   = Nothing

parseArgs :: [String] -> Maybe (Int, String, Int)
parseArgs [a, op, b] = do
  x <- readInt a
  y <- readInt b
  return (x, op, y)
parseArgs _ = Nothing

main :: IO ()
main = do
  args <- getArgs
  case parseArgs args of
    Just (x, op, y) ->
      case doOp x op y of
        Just res -> print res
        Nothing  -> exitWith (ExitFailure 8)
    Nothing -> exitWith (ExitFailure 8)