import Text.Read (readMaybe)

safeDive :: Integral a => a -> a -> Either String a
safeDive _ 0 = Left "You can not divide by 0"
safeDive x y = Right $ x `div` y

