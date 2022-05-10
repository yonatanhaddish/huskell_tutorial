add :: (Int, Int) -> Int
add (x,y) = x + y

-- Curried Function
add' :: Int -> (Int -> Int)
add' x y = x + y