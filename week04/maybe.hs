import Text.Read (readMaybe)

foo :: Int -> String
foo x = case x of
    1 -> "One"
    2 -> "Two"
    3 -> "Three"
    _ -> "Other"

foo' :: String -> String -> Maybe Int
foo' x y = case readMaybe x of
    Nothing -> Nothing
    Just m -> case readMaybe y of 
        Nothing -> Nothing
        Just n -> Just (m + n)

foo'' :: String -> String -> String -> Maybe Int
foo'' x y z = case readMaybe x of
    Nothing -> Nothing
    Just k -> case readMaybe y of 
        Nothing -> Nothing
        Just l -> case readMaybe z of 
            Nothing -> Nothing
            Just m -> Just (m + k + l)

