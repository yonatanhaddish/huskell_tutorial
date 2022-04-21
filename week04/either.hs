import Data.Either

foo :: String -> String -> Either String Int
foo x y = case x of 
    Left a -> "error01"
    Right b -> case y of 
        Left c -> "error02"
        Right d -> Right (a)

