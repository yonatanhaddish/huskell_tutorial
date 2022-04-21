
import Text.Read ( readMaybe )

foo :: String -> String -> String -> Maybe Int
foo x y z = case readMaybe x of
    Nothing -> Nothing
    Just k  -> case readMaybe y of
        Nothing -> Nothing
        Just l  -> case readMaybe z of
            Nothing -> Nothing
            Just m  -> Just (k + l + m)

-- main :: IO ()
-- main = putStrLn "Hello World!"

-- nameDo :: IO ()
-- nameDo = do putStr "What is your first name? "
--             first <- getLine
--             putStr "And your last name? "
--             last <- getLine
--             let full = first ++ " " ++ last
--             putStrLn ("Pleased to meet you, " ++ full ++ "!")

-- bar :: IO ()
-- bar = getLine >>= \s -> 
--       getLine >>= \t -> 
--       putStrLn ("Output: " ++ s ++ " " ++ t)

