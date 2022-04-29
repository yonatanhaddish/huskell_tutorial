import Data.List

interSperseA = intersperse '.' "Monkey"
interSperseB = intersperse 9 [1,2,3,4,5,6,7,8]

sumPoly = map sum $ transpose [[0,3,5,9], [10,0,0,9], [8,5,1,-1]]

concatList = concat [[1,2], [3,4], [5,6]]