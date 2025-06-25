{- 
-- EPITECH PROJECT, 2024
-- pool2 [WSL: archlinux]
-- File description:
-- my.hs
-}

mySucc :: Int -> Int
mySucc x = x + 1

myIsNeg :: Int -> Bool
myIsNeg x = x < 0

myAbs :: Int -> Int
myAbs x = if myIsNeg x then -x else x

myMin :: Int -> Int -> Int
myMin x y
  | x < y = x
  | otherwise = y

myMax :: Int -> Int -> Int
myMax x y
  | x > y = x
  | otherwise = y

myTuple :: a -> b -> (a, b)
myTuple x y = (x, y)

myTruple :: a -> b -> c -> (a, b, c)
myTruple x y z = (x, y, z)

myFst :: (a, b) -> a
myFst (x, _) = x

mySnd :: (a, b) -> b
mySnd (_, y) = y

mySwap :: (a, b) -> (b, a)
mySwap (x, y) = (y, x)

myHead :: [a] -> a
myHead [] = error "Empty list"
myHead (x:_) = x

myTail :: [a] -> [a]
myTail [] = error "Empty list"
myTail (_:xs) = xs

myLast :: [a] -> a
myLast [] = error "Empty list"
myLast xs = myNth xs (myLength xs - 1)

myLength :: [a] -> Int
myLength [] = 0
myLength (_:xs) = 1 + myLength xs

myNth :: [a] -> Int -> a
myNth [] _ = error "Index out of bounds"
myNth (x:_) 0 = x
myNth (_:xs) n
  | n < 0 = error "Index out of bounds"
  | otherwise = myNth xs (n - 1)

myTake :: Int -> [a] -> [a]
myTake _ [] = []
myTake 0 _ = []
myTake n (x:xs)
  | n <= 0 = []
  | otherwise = x : myTake (n - 1) xs

myDrop :: Int -> [a] -> [a]
myDrop _ [] = []
myDrop n xs
  | n <= 0 = xs
  | otherwise = myDrop (n - 1) (myTail xs)

myAppend :: [a] -> [a] -> [a]
myAppend [] ys = ys
myAppend (x:xs) ys = x : myAppend xs ys

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myAppend (myReverse xs) [x]

myInit :: [a] -> [a]
myInit [] = error "Empty list"
myInit xs = myTake (myLength xs - 1) xs

myZip :: [a] -> [b] -> [(a, b)]
myZip [] _ = []
myZip _ [] = []
myZip (x:xs) (y:ys) = (x, y) : myZip xs ys

myUnzip :: [(a, b)] -> ([a], [b])
myUnzip [] = ([], [])
myUnzip ((x, y):xs) = let (xs', ys') = myUnzip xs in (x:xs', y:ys')

myMap :: (a -> b) -> [a] -> [b]
myMap _ [] = []
myMap f (x:xs) = f x : myMap f xs

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter _ [] = []
myFilter p (x:xs)
  | p x = x : myFilter p xs
  | otherwise = myFilter p xs

main :: IO ()
main = do
  putStrLn "Testing mySucc 5:"
  print (mySucc 5)
  putStrLn "Testing myIsNeg (-3):"
  print (myIsNeg (-3))
  putStrLn "Testing myAbs (-10):"
  print (myAbs (-10))
  putStrLn "Testing myMin 4 7:"
  print (myMin 4 7)
  putStrLn "Testing myMax 4 7:"
  print (myMax 4 7)
  putStrLn "Testing myTuple 1 'a':"
  print (myTuple 1 'a')
  putStrLn "Testing myTruple 1 'a' True:"
  print (myTruple 1 'a' True)
  putStrLn "Testing myFst (1,2):"
  print (myFst (1,2))
  putStrLn "Testing mySnd (1,2):"
  print (mySnd (1,2))
  putStrLn "Testing mySwap (1,2):"
  print (mySwap (1,2))
  putStrLn "Testing myHead [1,2,3]:"
  print (myHead [1,2,3])
  putStrLn "Testing myTail [1,2,3]:"
  print (myTail [1,2,3])
  putStrLn "Testing myLast [1,2,3]:"
  print (myLast [1,2,3])
  putStrLn "Testing myLength [1,2,3]:"
  print (myLength [1,2,3])
  putStrLn "Testing myNth [10,20,30,40] 2:"
  print (myNth [10,20,30,40] 2)
  putStrLn "Testing myTake 2 [5,6,7,8]:"
  print (myTake 2 [5,6,7,8])
  putStrLn "Testing myDrop 2 [5,6,7,8]:"
  print (myDrop 2 [5,6,7,8])
  putStrLn "Testing myAppend [1,2] [3,4]:"
  print (myAppend [1,2] [3,4])
  putStrLn "Testing myReverse [1,2,3]:"
  print (myReverse [1,2,3])
  putStrLn "Testing myInit [1,2,3]:"
  print (myInit [1,2,3])
  putStrLn "Testing myZip [1,2] ['a','b']:"
  print (myZip [1,2] ['a','b'])
  putStrLn "Testing myUnzip [(1,'a'),(2,'b')]:"
  print (myUnzip [(1,'a'),(2,'b')])
