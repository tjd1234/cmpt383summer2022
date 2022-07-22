-- rational.hs

--
-- Implement your answers in this file.
--
-- There are few rules to follow:
--
--  - Don't change the MyRational type.
--  - Don't change any of the given function signatures.
--  - Use only functions from the standard prelude. Don't import any Haskell
--    modules.
--
-- You can implement your own helper functions if you like.
--

data MyRational = Frac Integer Integer

--
-- Given integers n and d, create a new rational with n as the numerator and d
-- as the denominator. Trying to create a rational with denominator 0 is an
-- error. Call the error function to crash the function, e.g. error
-- "makeRational: denominator can't be 0"
--
makeRational :: Integer -> Integer -> MyRational
-- ...

--
-- Returns the numerator of a rational.
--
getNum :: MyRational -> Integer
-- ...

--
-- Returns the denominator of a rational.
--
getDenom :: MyRational -> Integer
-- ...

--
-- Returns a pair of the numerator and denominator of a MyRational.
--
pair :: MyRational -> (Integer, Integer)
-- ...

--
-- Implement an instance of the show function that returns the usual string
-- representation of the rational. For instance, 5/3 would be the string
-- "5/3".
--
instance Show MyRational where
-- ...

--
-- Convert the fraction to a floating point value Returns the value as the
-- number as a floating point number. For example, 5/2 is 2.5, 1/3 is 0.3333,
-- etc. Hint: use fromIntegral.
--
toFloat :: MyRational -> Float
-- ...

--
-- Implement an instance of == that test if two MyRationals are equal. Be
-- careful if either is not in lowest terms!
--
instance Eq MyRational where
-- ...

--
-- Implement an instance of compare x y that tests if the MyRationals x and y
-- are the same (return EQ), or x is less than y (return LT), or x is greater
-- than y (return GT). Be careful with negative values, and when x or y is not
-- in lowest terms!
--
instance Ord MyRational where
-- ...

--
-- Return True if the given MyRational represents an integer, and False
-- otherwise. For example, 4/1, 21/3, and 0/99 are all integers.
--
isInt :: MyRational -> Bool
-- ...

--
-- Adds two given MyRationals and returns a new MyRational that is there sum.
--
add :: MyRational -> MyRational -> MyRational
-- ...

--
-- Multiplies two given MyRationals and returns a new MyRational that is there
-- product.
--
mult :: MyRational -> MyRational -> MyRational
-- ...

--
-- Divides two given MyRationals and returns a new MyRational that is there
-- quotient. Call the error function if division by zero would occur.
--
divide :: MyRational -> MyRational -> MyRational
-- ...

--
-- Inverts a given MyRational and returns a new one with the numerator and
-- denominator switched. For example, 2/3 inverts to 3/2. Call the error
-- function for 0 numerators, e.g. 0/3 inverts to 3/0, which is not a
-- rational.
--
invert :: MyRational -> MyRational
-- ...

--
-- Reduces a given MyRational and returns a new MyRational that is in lowest
-- terms. For example, 36/20 reduces to 9/5. Use the gcd function to help do
-- this. Be careful in the case where the numerator or denominator is
-- negative.
--
toLowestTerms :: MyRational -> MyRational
-- ...

--
-- Given an integer, return a rational equal to 1/1 + 1/2 + ... + 1/n.
--
-- For example:
--
-- > harmonicSum 25
-- 34052522467/8923714800
--
harmonicSum :: Integer -> MyRational
-- ...

--
-- Using insertion sort, list any list of values [a] for a type that
-- implements Ord.
--
-- For example:
--
-- > insertionSort [5,6,2,3,1,4]
-- [1,2,3,4,5,6]
--
-- > insertionSort ["one","two","three","four"]
-- ["four","one","three","two"]
--
-- > insertionSort [makeRational 2 2,makeRational 0 1,
--                  makeRational 4 5,makeRational (-1) 7]
-- [-1/7,0/1,4/5,2/2]
--
insertionSort :: Ord a => [a] -> [a]
-- ...

--
-- When you're ready to test insertionSort, put a main function here that
-- calls it. See helloWorld.hs in the same folder for an example of how to do
-- this.
--
-- main = do putStrLn "Haskell!"
--           putStrLn "Calling insertionSort ..."
--
