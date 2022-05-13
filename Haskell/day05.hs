-- Recursive Functions

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
fac n = if n <= 0 then 1 else 
    n * fac (n-1)
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- product of numbers in a list
producT :: [Int] -> Int
producT [] = 1
producT (n:ns) = n * producT ns
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- length of a list
lengtH :: [Int] -> Int
lengtH [] = 0
lengtH (x:xs) = 1 + lengtH xs
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- reverse of a list
reversE :: [a] -> [a]
reversE [] = []
reversE (x:xs) = reversE xs ++ [x]
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
