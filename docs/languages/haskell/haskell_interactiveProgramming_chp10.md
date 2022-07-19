**Note**: These notes are based in large part on chapter 10 of the excellent
book [Programming in Haskell, 2nd
edition](https://www.cs.nott.ac.uk/~pszgmh/pih.html) by Graham Hutton. You
should buy a copy.


## The Problem

[Haskell]'s functions are **pure**: they never have side-effects (like
printing, or modifying a global variable), and given the same input, they
*always* return the same result.

But in programming, many functions are useful only for their side effects. For
example:

- C's `printf` function causes the side-effect of displaying characters on the
  terminal, and so it's not pure.

- C's `rand()` function returns different values every time you call it, so
  it's not pure.

We've been intentionally avoiding examples like these because there is no
obvious way to deal with impure functions in [Haskell].

Most programming languages allow pure and impure functions to mix together and
leave it up to the programmer to distinguish between them .

[Haskell] takes a very different approach to impure functions, and only allows
them in certain situations.


## Haskell's Approach to Impure Functions

To gain some intuition for how [Haskell] deals with impure functions, the text
asks you to imagine an interactive function, e.g. maybe a chatbot that the
user interacts with through text. For example, it might have this signature:

```haskell
chatBot :: String -> String
```

In [Haskell], `chatbot` *can't* implement an interesting chatbot because
`chatbot` is a pure function: it will return the same result every time you
give it the same input.

But what you can do is imagine that the chatbot function has the type `World
-> (String, World)`. The `World` type is a made-up type (just for this
example) that represents the entire state of the world that the chatbot knows
about. This could include many values, such as a list of all previous inputs
to the chatbot, the current date/time, a knowledge base of rules for answering
questions, and so on. The input to the chatbot is a state of the `World`, and
the output is the chatbot's reply of type `String`, plus a new `World` state
that describes the world after the chatbot has replied. Instead of *modifying*
the world, the chatbot *makes a new copy* of the world. A pure function can't
*modify* values, but in can *copy* them, and during the process of copying it
can make changes.

You can think of this pure chatbot function as having this type signature:

```haskell
World -> (String, World)
```

As mentioned, `World` is not an actual [Haskell] type. Instead, [Haskell] uses
the type `IO String`, which you could imagine as being defined something like
this:

```haskell
type IO String = World -> (String, World)
```

`IO` stands for input/output, since one of the major applications of this sort
of type is input and output.

A function of type `IO a` can be thought of as taking the relevant state of
the world as input, and returning a value plus an updated state of the world
as output. The side-effects of the function are recorded in this changed
world. Intuitively, the function *doesn't change* the world, but instead
returns a brand new modified copy of the world.

Expressions of type `IO a` are called **actions**. For example, `IO String` is
the type of an action that returns a `String`, and `IO Int` is the type of an
action that returns an `Int`. The special action `IO ()` is the type of an
action that doesn't return a value, but does some side-effect (e.g. a print
function).

Again, to be clear, `World` is not an actual [Haskell] type. It's just an idea
to help intuitively understand how impure functions can work. The type `IO a`
is considered primitive in [Haskell], i.e. we can't implement it within
[Haskell].


## Basic actions

The standard action `getChar :: IO Char` reads a character from the keyboard.
When called, it waits for the user to type a character:

```haskell
> getChar
t't'
> getChar
!'!'
```

`getChar` *does not* return a `Char`, it returns an `IO Char`. There's no way
to get the `Char` out of the `IO Char` using pure functions.

The standard action `putChar :: Char -> IO ()` takes a character as input and
writes it to the screen:

```haskell
> putChar '?'
?
```

`putChar` doesn't *return* a `Char`. We know this because it's return type is
`IO ()`, which means `putChar` has a side-effect (printing a character), and
returns no value after it's done. `putChar ?` *looks* like it's returning a
value, but it's not: what you're seeing is the *action* `putChar` performs of
printing the character on the screen.

Finally, the standard action `return :: a -> IO a` takes a value of type `a`
as input and returns it as an `IO a` without performing any interaction with
the user. If you evaluate `return v` in the interpreter, it looks like it is
returning the given value, e.g.:

```haskell
> return 'a'
'a'
> return "cow"
"cow"
> return 4
4
```

But that's just the interpreter being helpful: the true return type is `IO a`.
For example:

```haskell
> 2 + 3
5
> 2 + (return 3)
<interactive>:40:1: error:
    • Ambiguous type variable ‘m0’ arising from a use of ‘print’
      prevents the constraint ‘(Show (m0 Integer))’ from being solved.
```

The `return` action converts a value of type `a` into a value of type `IO a`.
Importantly, it's not possible to go the other way using pure functions, i.e.
we **cannot** write a pure function of type `IO a -> a` that extracts the `a`
value from the `IO a`. Once a value is in `IO a`, it is stuck there forever.

Intuitively, you can think of an `IO a` as a box that holds a value of type
`a`. Importantly, given an `IO a` box, there is *no way* to get the `a` out of
the box, or to even know what the value is. It's in there forever. If you
happen to have a value of type `a` lying around, you an always but it into an
`IO a` box using `return`. Once it's in the box, you cannot get it out again.


## Sequencing: do-notation

**do-notation** lets [Haskell] do one, or more actions, in sequence. For
example, this reads 3 characters from the terminal, and then prints them in
reverse order:

```haskell
test1 = do a <- getChar
           b <- getChar
           c <- getChar
           putChar '\n'
           putChar c
           putChar b
           putChar a
           putChar '\n'

> test1
cat
tac
```

The meaning is fairly straightforward: three characters are read in and stored
in the variables `a`, `b`, and `c`, and then they are printed in reverse
order. An expression of the form `a <- getChar` is called a **generator**. It
calls `getChar` and puts the resulting `Char` into `a`.

> **Important** In the do-expression above, `a` contains a `Char`, *not* an
> `IO Char`. *Inside do-expressions*, we operate directly on values without
> worrying about the `IO` part. The generator `a <- getChar` is impure because
> `a` could be assigned different values each time it is called. *Within*
> do-expressions, this impurity is allowed. It's as if the do-notation parts
> of a program are "impure zones" that wall-off the impurity from the rest of
> the program. Crucially, there's no way to access the value of `a` outside
> the do-notation.


## Derived primitives

The expression `putChar '\n'` is used a couple of times in `test1`, so lets
write a helper function that does the same thing. First, note that the type of
`putChar '\n'` is `IO ()`, i.e. it's an action that doesn't return a value:

```haskell
> :t putChar '\n'
putChar '\n' :: IO ()
```

So we can write this function:

```haskell
newline :: IO ()
newline = putChar '\n'
```

This lets us write:

```haskell
test2 = do a <- getChar
           b <- getChar
           c <- getChar
           newline
           putChar c
           putChar b
           putChar a
           newline

> test2
abc
cba
```

Now lets write a function that prints *n* newlines in a row:

```haskell
multinewline :: Int -> IO ()
multinewline 1 = putChar '\n'
multinewline n = do putChar '\n'
                    multinewline (n-1)
```

Since the return type of `multinewline` is `IO ()` it is an action, and can be
used inside do-notation.

This lets us write:

```haskell
test3 = do a <- getChar
           b <- getChar
           c <- getChar
           multinewline 3
           putChar c
           putChar b
           putChar a
           multinewline 2

> test3
abc


cba

```

Next, let's write an action that uses `putChar` to print an entire string on
the screen.

```haskell
myPutStr :: String -> IO ()
myPutStr ""     = return ()  -- nothing to print
myPutStr (c:cs) = do putChar c
                     myPutStr cs
```

Let's look at each part:

- The input to `myPutStr` is a `String`, and the output is `IO ()`. `myPutStr`
  modifies the state of the world, but it doesn't return a value and so it has
  type `IO ()`.

- `myPutStr ""` prints nothing. Since `myPutStr ""` has the type `IO ()`, it
  evaluates to `return ()`. `return` has type `a -> IO a`, and converts an `a`
  value to an `IO a` value, and so `return ()` returns an `IO ()`.

- For a non-empty string `s`, `myPutStr s` prints the first character of `s`
  using `putChar`, and then prints the rest of the string (using recursion).

For convenience, we also define `myPutStrLn`, which adds a newline at the end
of the printed string:

```haskell
myPutStrLn :: String -> IO ()
myPutStrLn s = do myPutStr s
                  putChar '\n'  -- or use: newline

> myPutStrLn "hello"
hello
```

Finally, we can use `getChar` to create a version of `getLine`:

```haskell
myGetLine :: IO (String)
myGetLine = do c <- getChar
               if c == '\n' then
                  return ""
               else
                  do cs <- myGetLine
                     return (c:cs)
```

The `myGetLine` action doesn't take any input, it just returns an `IO
(String)`. When called, `myGetLine` checks if the first character read is a
newline. If it is, then `return ""`, which as type `IO String`, is returned.
Otherwise, the rest of the line is recursively read in, and the initial
character is cons-ed onto the start of that string.

Notice that we use do-notation in two separate cases. 

Now we can write "simple" programs like this:

```haskell
hello :: IO ()
hello = do myPutStr "Hi! What's your name? "
           name <- myGetLine
           myPutStrLn ("Hello " ++ name ++ ", how are you?")
```

```haskell  
> hello
Hi! What's your name? Alonzo
Hello Alonzo, how are you?
```

Or this:

```haskell
printBox :: String -> IO ()
printBox s = do myPutStr bar 
                myPutStrLn ("| " ++ s ++ " |")
                myPutStr bar
             where n   = length s
                   bar = "+" ++ (replicate (n+2) '-') ++ "+" ++ "\n"
```

```haskell
> printBox "Watch this space!"
+-------------------+
| Watch this space! |
+-------------------+
```


### Challenge: password checking

Write a function called `check` that asks the user to enter a password, and
then asks them to enter it again. If the two passwords match, print "Passwords
match!", otherwise print "Error: passwords don't match".

The characters typed by the user should be displayed as `*` characters (see
the `sgetLine` function in the textbook's Hangman example).

Here's a sample run:

```haskell
> check
Enter password: *********
Enter password again: *********
Passwords match!

> check
Enter password: *****
Enter password again: ****
Error: passwords don't match
```

As part of your answer, include the type signature for `check`. 


### Explain the bug: returning myGetLine directly

In your own words, explain the bug in this code, and how you would fix it
(i.e. re-write the code so it works):

 ```haskell
myGetLine :: IO (String)
myGetLine = do c <- getChar
               if c == '\n' then
                  return ""
               else
                  return (c:myGetLine)
```


## Example: Hangman
See text.

## Example: Nim
See text.

## Example: Life
See text.

[Haskell]: https://en.wikipedia.org/wiki/Haskell_(programming_language)
