qSort [] = []
qSort (x:xs)  = qSort ys ++ [x] ++ qSort zs
                where
                    ys = [a | a <- xs, a <= x]
                    zs = [b | b <- xs, b > x]