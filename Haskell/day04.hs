-- List Comprehension

------------------------------------------------------------------------------------
factorS :: Int -> [Int]
factorS n = [x | x <- [1..n], n `mod` x == 0]
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
primE :: Int -> Bool
primE n = factorS n == [1,n]
------------------------------------------------------------------------------------
primeS :: Int -> [Int]
primeS n = [x | x <- [2..n], primE x]
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
oddsL :: Int -> [Int]
oddsL n = [x | x <- [1..n], x `mod` 2 == 1]
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- positionS :: Eq a => a -> [a] -> [Int]
positionS :: Int -> [Int] -> [Int]
positionS x xs = [i | (x',i) <- zip xs [0..], x' == x]
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
counT :: Char -> String -> Int
counT x xs = length [x' | x' <- xs, x == x']
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
pythS :: Int -> [(Int, Int, Int)]
pythS n = [(x', y', z') | x' <- [1..n], y' <- [1..n], z' <- [1..n], x'^2 + y'^2 == z'^2]
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
perfecT :: Int -> Bool
perfecT n = sum ([x | x <- [1..n-1], n `mod` x == 0]) == n

perfectS :: Int -> [Int]
perfectS n = [x | x <- [1..n], perfecT x]
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
scalarP :: [Int] -> [Int] -> Int
scalarP xs ys = sum [x*y | (x, y) <- zip xs ys]
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
