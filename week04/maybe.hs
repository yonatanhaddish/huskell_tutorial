import Text.Read (readMaybe)
import Control.Monad

boo :: Int -> String
boo x = case x of 
            1 -> "A"
            2 -> "B"
            3 -> "C"
            _ -> "None"

foo :: String -> String -> String -> Maybe Int
foo x y z = case readMaybe x of
    Nothing -> Nothing
    Just k  -> case readMaybe y of
        Nothing -> Nothing
        Just l  -> case readMaybe z of
            Nothing -> Nothing
            Just m  -> Just (k + l + m)

-- bindMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b
-- bindMaybe Nothing _ = Nothing
-- bindMaybe (Just x) f = f x

-- foo' :: String -> String -> String -> Maybe Int
-- foo' x y z = readMaybe `bindMaybe` \k -> 
--              readMaybe `bindMaybe` \l ->
--              readMaybe `bindMaybe` \m ->
--                  Just(k + l + m)

-- safediv :: Integral a => a -> a -> Maybe a
safediv :: Int -> Int -> Maybe Int
safediv a b =
    if b == 0 then Nothing else Just $ div a b 
