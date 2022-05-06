data redeemer = Maybe Int

function1 :: Integer -> Maybe Integer
function1 x = Just x | Nothing
case redeemer of 
    Nothing -> "blah blah blah"
    Just x -> "Not blah blah blah"