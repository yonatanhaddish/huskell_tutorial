-- Defining Functions


-- if else condition
abS :: Int -> Int
abS n = if n >= 0 then n else -n

isCarni :: String -> String
isCarni n = if n == "lion" then "Carni" else
    if n == "sheep" then "Herbi" else "Omni"

printNum :: Int -> String
printNum n = if n == 1 then "One" else 
    if n == 2 then "Two" else 
        if n == 3 then "Three" else
            if n == 4 then "Four" else 
                if n == 5 then "Five" else "Number Not Found on Database"