-- Defining Functions


-- if else condition
abS :: Int -> Int
abS n = if n >= 0 then n else -n

------------------------------------------------------------------------------------
isCarni :: String -> String
isCarni n = if n == "lion" then "Carni" else
    if n == "sheep" then "Herbi" else "Omni"

-- guarded condition
isCarni' :: String -> String
isCarni' n | n == "lion" = "Carni"
           | n == "sheep" = "Herbi"
           | otherwise    = "Omni"
------------------------------------------------------------------------------------
printNum :: Int -> String
printNum n = if n == 1 then "One" else 
    if n == 2 then "Two" else 
        if n == 3 then "Three" else
            if n == 4 then "Four" else 
                if n == 5 then "Five" else "Number Not Found on Database"

printNum' :: Int -> String
printNum' n | n == 1 = "One"
            | n == 2 = "Two"
            | n == 3 = "Three"
            | n == 4 = "Four"
            | n == 5 = "Five"
            | otherwise = "Number not found on database"
------------------------------------------------------------------------------------
-- Normal expression
addA :: Int -> Int -> Int
addA x y = x + y

-- Lambda Expressions
addL :: Int -> Int -> Int
addL = \x -> \y -> x + y
------------------------------------------------------------------------------------
