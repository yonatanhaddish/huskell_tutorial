-- Quick Sort 
qSort [] = []
qSort (x:xs)  = qSort ys ++ [x] ++ qSort zs
                where
                    ys = [a | a <- xs, a <= x]
                    zs = [b | b <- xs, b > x]

heaD [] = []
heaD (x:xs) = [x]

doubleX :: Int -> Int
doubleX x = x + x

quadrapleY :: Int -> Int
quadrapleY y = doubleX (doubleX y)

factoriaL :: Int -> Int
factoriaL x = product [1..x]

-- averagE :: a -> Int
averagE u = sum u `div` length u