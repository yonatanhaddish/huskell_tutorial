-- last element of a list myLast [1,2,3,4] will be 4
myLast :: [a] -> a
myLast [] = "Empty list"
myLast [x] = x
myLast (_:xs) = myLast xs

