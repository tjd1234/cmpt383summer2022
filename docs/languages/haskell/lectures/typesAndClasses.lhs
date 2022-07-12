This is a literate Haskell file!

Lines beginning with "> " are interpreted as Haskell. All other lines are
treated as comments and are ignored. So you can run this in the Haskell interpreter:

	$ ghci typesAndClasses.lhs
	...


Warm-up: An Alternative Insertion Sort Implementation
-----------------------------------------------------

A right fold of the list [2,1,6,3] looks like this:

	2 op (1 op (6 op (3 op init)))

What can we replace op and init with so that the expression evaluates to
[1,2,3,6], i.e. the sorted?

Idea: the numbers are passed one at a time as the left parameter of the call
to op, the second parameter is the evaluation so far. If the second parameter
is the numbers sorted so far, then when we get a new number op should insert
it into the correct place to keep it sorted.

That suggests init == [], and op is insertSorted x lst, where lst is sorted.
This gives us:

	2 insertSorted (1 insertSorted (6 insertSorted (3 insertSorted [])))

In general, the function is:

> isort :: Ord a => [a] -> [a]
> isort = foldr insertSorted' []

What about insertSorted? For example, insertSorted 4 [1,2,5,6] returns
[1,2,4,5,6]. One way to implement it is like this:

> insertSorted :: Ord a => a -> [a] -> [a]
> insertSorted x [] = [x]
> insertSorted x (y:ys) | x <= y    = x:y:ys
>                       | otherwise = y : (insertSorted x ys)

Another approach is this:

> insertSorted' :: Ord a => a -> [a] -> [a]
> insertSorted' n lst = smalls ++ [n] ++ bigs
>                       where smalls = takeWhile (<n) lst
>                             bigs   = dropWhile (<n) lst

Conceptually, this splits the given list into to sub-lists: smalls, with all
the elements less than n, and bigs, with all the elements greater than n. It
then constructs a new list with n in the middle.


Type Declarations
-----------------

A **type declaration** uses the `type` keyword, and creates a *synonym* for an
existing type. For example, strings are defined like this in the Haskell
prelude:

   type String = [Char]

We could define a predicate type like this:

> type Predicate a = a -> Bool
>
> remove_if :: Predicate a -> [a] -> [a]
> remove_if p lst = filter (not . p) lst


Basic Data Declarations
-----------------------

**Data declarations** define new types, e.g. this is the definition of Bool in
the standard prelude:

   data Bool = True | False

We could use this to model a traffic light:

> data Light = Red | Yellow | Green
>  deriving (Eq, Show)

The "deriving" line tells Haskell to include default implementations of the
(==) and show functions. We can write functions like this:

> change :: Light -> Light
> change Red    = Green
> change Yellow = Red
> change Green  = Yellow


Example: Shape data declaration
-------------------------------

> data Shape = Circle Float | Rect Float Float | Square Float
>    deriving Show

Circle and Rect are called constructor functions because they make new shape:s

	$ :type Circle
	Circle :: Float -> Shape
	$ :type Rect
	Rect :: Float -> Float -> Shape


Here are functions for calculating the area and perimeter of a shape:

> area :: Shape -> Float
> area (Circle r) = pi * r^2
> area (Rect w h) = w * h
> 
> perimeter :: Shape -> Float
> perimeter (Circle r) = 2 * pi * r
> perimeter (Rect w h) = 2 * (w + h)

For example:

	$ area (Circle 2.2)
	15.205309
	$ area (Rect 3 4)
	12.0
	$ perimeter (Rect 3 4)
	14.0


Example: MyRational
-------------------

In the assignment, rationals are represented like this:

> data MyRational = Frac Integer Integer

MyRational is the data type, and Frac is a constructor function that makes a
MyRational.

You can use it like this:

> whatsBigger :: MyRational -> String
> whatsBigger (Frac n d) | n > d     = "numerator"
>                        | d > n     = "denominator"
>                        | otherwise = "same"

	$ whatsBigger (Frac 2 5)
	"denominator"


Parameterized Data Declarations
-------------------------------

The data type Maybe a is defined in the standard prelude like this:

  data Maybe a = Nothing | Just a

The idea is that represents a value that might not be there. A Maybe a value
is like a box: it's either empty (has Nothing), or it contains just a value of
type a.

For example, the regular head function crashes if you give it an empty list.
But not safeHead:

> safeHead :: [a] -> Maybe a
> safeHead []    = Nothing
> safeHead (x:_) = Just x

Dealing with Maybe values is bit troublesome because you always need to check
if they're Nothing:

> add :: Maybe Double -> Maybe Double -> Maybe Double
> add Nothing  Nothing  = Nothing
> add Nothing  (Just n) = Nothing
> add (Just n) Nothing  = Nothing
> add (Just m) (Just n) = Just (m + n)

Or more simply:

> add' :: Maybe Double -> Maybe Double -> Maybe Double
> add' (Just m) (Just n) = Just (m + n)
> add' _        _        = Nothing


Getting a Value from a Maybe
----------------------------

Can you write a function that bets the value in a Maybe Int? Here's an
attempt:

	getInt :: Maybe Int -> Int
	getInt (Just n) = n
	getInt Nothing  = ???

What should ??? be? The Nothing value means there is no int at all, so there
is no value to return. If we replace ??? with 0, then you can't tell the
difference between Nothing and Just 0.

There is no one good answer that works in all situations.


Impurity in Haskell: Actions
----------------------------

Haskell functions are always pure, meaning they have no side-effects, and
their output only depends upon their input.

So how can we use Haskell to do fundamentally impure things, like read or
write characters?

Haskell solution is to use *actions*, which are essentially functions that
allow impure things to happen *inside* of them. Importantly, the impure things
cannot escape the function (since that would make the function impure).


The getChar action
------------------

For example, getChar is a standard Haskell action that reads one character
typed by the user:

	> getChar
	t't'
	> getChar
	6'6'

What is the type of getChar? It *can't* be Char, because then it would be
returning different values all the time, making it impure. Instead, it returns
an IO Char:

	> :type getChar
	getChar :: IO Char

getChar does *not* return a Char, it returns an IO Char. You can think of an
IO Char as like a box that holds a Char, but there is no way to bet the Char
out of it.


The putChar action
------------------

The putChar function is also impure, and it prints a character to the screen:

	> putChar 'Y'
	Y

What is the type of putChar? Intuitively, it seems like some of kind of "void"
type, because we use putChar for the side-effect of printing a character, not
for its return value. Haskell doesn't have a void type the way languages like
C++ and Java do, but is somewhat similar:

	> :type putChar
	putChar :: Char -> IO ()

putChar's return type is IO (). This means something impure happens in putChat
(it prints a character), and doesn't return any other value.


The return action
-----------------

return is another important Haskell action, and it has this type signature:

	return :: a -> IO a

Given a value x of type a, return x evaluates to a value of type IO a. In a
sense, return puts a value into an IO.

Importantly, there is no way to get the value out of an IO, i.e. there is no
function like this:

	getVal :: IO a -> a

Since impure things can happen in an IO, you can't get values out of an IO
using regular pure functions. The impurities can only be handled inside the
IO.

do-notation
-----------

Haskell's do-notation lets you do multiple actions in a row:

> test1 = do a <- getChar
>            b <- getChar
>            c <- getChar
>            putChar '\n'
>            putChar c
>            putChar b
>            putChar a
>            putChar '\n'

	$ test1
	cat
	tac

The code in the do is pretty intuitive three characters are read in, and then
printed in reverse order.

What is the type of test1? Haskell tells us the answer:

	$ :type test1
	test1 :: IO ()
