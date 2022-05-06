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