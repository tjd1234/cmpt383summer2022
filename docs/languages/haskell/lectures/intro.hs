-- intro.hs

-- type inference

double x = 2 * x


quadruple x = double (double x)


factorial n = product [1..n]


-- ns is a list of numbers
--average ns = (sum ns) `div` (length ns)
average ns = div (sum ns) (length ns)


-- (++) is list concatenation (append)
-- ends lst = [head lst] ++ [last lst]
ends lst = [head lst, last lst]

middle :: [a] -> [a]
middle []     = error "can't be empty"
middle [x]    = []
middle (x:xs) = init xs

pluralize :: String -> String
pluralize "" = ""
pluralize s  = s ++ (if last s == 's'
                     then ""
                     else "s")

-- sign (-4) => -1
-- sign 0    =>  0
-- sign 5    =>  1
sign :: Int -> Int
sign n | n == 0    = 0
       | n <  0    = (-1)
       | otherwise = 1

-- inc n = n + 1

inc = \n -> n + 1    -- (lambda (n) (+ n 1))

--
-- Factorials, recursively
-- 
fact :: Integer -> Integer
fact 0 = 1
fact n = n * fact (n-1)


--
-- Insertion sort
--

--
-- "Ord a" means that a is any type that implements all the functions listed
-- in the Ord type class, e.g. functions like <, <=, ==, ...
--
-- | are guarded commands, like an if-else-if statement
-- : is like cons in Racket
--
insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys) | x <= y    = x:y:ys
                | otherwise = (:) y (insert x ys)

isort :: Ord a => [a] -> [a]
isort []     = []
isort (x:xs) = insert x (isort xs)



twice f x = f (f x)










--
-- Implementations of some higher-order functions
--
mymap :: (a -> b) -> [a] -> [b]
mymap _ []     = []
mymap f (x:xs) = f x : mymap f xs


myfilter :: (a -> Bool) -> [a] -> [a]
myfilter _ []     = []
myfilter p (x:xs) = if p x 
                    then x : (filter p xs)
                    else filter p xs

mytakeWhile :: (a -> Bool) -> [a] -> [a]
mytakeWhile _ []     = []
mytakeWhile p (x:xs) = if p x
                       then x : mytakeWhile p xs
                       else []

mydropWhile :: (a -> Bool) -> [a] -> [a]
mydropWhile _ []     = []
mydropWhile p (x:xs) = if p x
                       then mydropWhile p xs
                       else x:xs

--
-- insert using takeWhile and dropWhile
--
insert' :: Ord a => a -> [a] -> [a]
insert' n lst = smalls ++ [n] ++ bigs
              where smalls = takeWhile (<n) lst
                    bigs   = dropWhile (<n) lst

mysum :: Num a => [a] -> a
mysum []     = 0
mysum (x:xs) = x + mysum xs

myprod :: Num a => [a] -> a
myprod []     = 1
myprod (x:xs) = x * myprod xs

myfoldr :: (a -> b -> b) -> b -> [a] -> b
myfoldr _  emptyval []     = emptyval
myfoldr op emptyval (x:xs) = x `op` (myfoldr op emptyval xs)

-- 
-- Returns s sorted copy of a list
--
isort' :: Ord a => [a] -> [a]
isort' = foldr insert []
