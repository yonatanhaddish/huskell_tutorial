f x y = x + y

double x = x + x
quadruple x = double (double x)

factorial n = product [1..n]

average ns = sum ns `div` length ns

sumf n= sum [1..n]

odds n = map f [0..n-1] where f x = x * 2 + 1

oddsk n = map(\x -> x * 2 + 1)[0..n-1]

evenc n = map(\x -> x * 2 + 2)[0..n-1]

factors n= [x | x <- [1..n], n `mod` x == 0]

prime n = factors n == [1,n]

primes n= [x | x <- [2..n], prime x]

count x xs= length [y | y <- xs, x == y]

pyths n = [(x,y,z) | x <- [1..n], y <- [1..n], z <- [1..n], x^2 + y^2 == z^2]

factorsx n= sum [x | x <- [1..n-1], n `mod` x == 0]==n
perfects n = [a | a <- [1..n], factorsx a]

fac 0= 1
fac n= n * fac (n-1)

doubleSmallNumber x = (if x > 100 then x else x*2)

xo= [3,2,1]
jj= ['h','e','l','l','o'] ++ " " ++ ['W']
jjj= "Hello" ++ " " ++ "World" ++ "!"
animal= 'A' : " for Ape"

listA= [5,4,3,2,1]
listE= []

boomBangs xs= [if x < 10 then "BOOM" else "BANG" | x <- xs , odd x]

removeNonUppercase st= [c | c<-st, c `elem` ['A'..'Z']]

circumference :: Float -> Float
circumference r= 2*pi*r

sayMe :: (Integral a) => a -> String
sayMe 1= "One!"
sayMe 2= "Two!"
sayMe 3= "Three!"
sayMe 4= "Four!"
sayMe x= "Not between 1 and 5"

charName :: Char -> String
charName 'a'= "Albert"
charName 'b'= "Broseph"
charName 'c'= "Cecil"

addA = [a+b | (a,b)<-[(1,2), (3,4)]]

head' :: [a] -> a
head' []= error "Cant call hean on an empty list"
head' (x:_)= x

tell :: (Show a) => [a] -> String
tell []= "The list is empty"
tell (x:[])= "The list has one element: " ++ show x
tell (x:y:[])= "The list has two elements: " ++ show x ++ " and " ++ show y
tell (x:y:_)= "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y

sum' :: (Num a) => [a] -> a
sum' []= 0
sum' (x:xs)= x + sum' xs

bmiTell :: (RealFloat a) => a -> a -> String
bmiTell weight height | bmi <= 18.5 = "Under Weight"
                      | bmi <= 25 = "Normal"
                      | bmi <= 30 = "Over Weight"
                      | otherwise = "Obisity"
                      where bmi = weight/height^2

cylinderArea :: (RealFloat a) => a -> a -> a
cylinderArea r h = 
    let sideArea = 2 * pi * r * h
        topArea = pi * r^2
    in sideArea + 2 * topArea

replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x 
    | n <= 0 = []
    | otherwise = x:replicate' (n-1) x

take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _ | n <= 0 = []
take' _ [] = []
take' n (x:xs) = x: take' (n-1) xs

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

qSort :: (Ord a) => [a] -> [a]
qSort [] = []
qSort (x:xs) = let smallerSorted = qSort [a | a <- xs, a <= x]
                   largerSorted = qSort [a | a <- xs, a > x]
                in smallerSorted ++ [x] ++ largerSorted

joinWords :: [a] -> [a] -> [a] -> [a]
joinWords a b c = a ++ b ++ c

joinOneMoreWord :: [Char] -> [Char]
joinOneMoreWord = joinWords "hello" "world"

largestDivisible :: (Integral a) => a
largestDivisible  = head (filter p [100000,99999..])
    where p x = x `mod` 3829 == 0

sumA = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))

chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain n 
    | even n = n:chain (n `div` 2)
    | odd n = n:chain ((n*3) + 1)

numLongChains :: Int
numLongChains = length (filter isLong (map chain [1..100]))
    where isLong xs = length xs > 15

trialB :: Int
trialB = sum (filter (>10) (map (*2) [2..10]))

trialC :: Int
trialC = sum $ filter(>10) $ map(*2)[2..10]

data Task1 = BasicTask1 String Int

assignment1 :: Task1
assignment1 = BasicTask1 "Do assignment 1" 60

laundry1 :: Task1
laundry1 = BasicTask1 "Do Laundry" 45

minLovelace :: Integer
minLovelace = 2000000

myFirstFunction :: String -> String
myFirstFunction input = "Hello " ++ input ++ "!"

