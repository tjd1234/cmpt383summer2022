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

fact :: Integer -> Integer
fact 0 = 1
fact n = n * fact (n-1)
