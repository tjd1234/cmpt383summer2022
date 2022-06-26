# Moving from Racket to Haskell

## Racket Overview

Lets take a moment to reflect on some of the major features of [Racket], both
good and maybe not so good:

- [Racket] is **dynamically typed**. That means type errors are not usually
  discovered until code is run. This is both good an bad. On the up side,
  dynamic typing means you don't need to explicitly declare types in your
  source code, which often results in shorter and simpler programs. On the
  down side, type errors can stay hidden in your program and may not be
  discovered until they cause a bug.

- [Racket] uses **prefix notation** everywhere. This is consistent and simple
  once you learn it, but it also means that ordinary arithmetic expressions
  like $2 \cdot 5 - 3 \cdot 6$ are written in the form `(- (* 2 5) (* 3 6))`.

- [Racket] code is filled with **parentheses**. While simple, but correctly
  matching brackets can be frustrating, and in many cases all the parentheses
  can hurt readability.

- [Racket] is **homoiconic**, i.e. [Racket] programs are represented as
  regular [Racket] lists. This is one of the things that makes [Racket] a good
  choice for language-processing applications, such as interpreters and
  compilers.

- [Racket] supports **functional programming**. [Racket] lets you use and
  define higher-order functions like `map`, `filter`,`foldr`, `curry`. Such
  functions can be quite useful in practice, and significantly lessen the need
  for using recursion. [Racket] functions **don't** need to be **pure** (a
  pure function has no side-effects, and always returns the same output for
  the same input). This is quite convenient, since impure functions let us do
  things like printing, reading from files, modifying the values of variables,
  and so on.

- [Racket] has **macros**. Macros let you control *when* passed-in inputs are
  evaluated, and with them you can implement new syntax, such as `define`-like
  forms, or flow-of-control forms such as `cond`. Writing macros is often
  trickier than writing regular functions, and to use them well you need to
  learn new techniques.

- [Racket] has **a small but enthusiastic community of users**. [Racket]
  programmers often like [Racket] a lot and enjoy helping others learn
  [Racket]. But compared to mainstream languages, there are not many [Racket]
  users, especially outside of academia.


## Haskell Overview

[Haskell] can be thought of as an alternative approach to functional
programming that emphasizes a different set of features than [Racket].

## Concise programs

Many [Haskell] features are explicitly designed with human readability in
mind. [Haskell] programs can be short and relatively easy to read.

But, to be fair, [Haskell] programs can sometimes be *too* short and *too*
concise, making them hard to understand if you're not very familiar with the
details.

### Powerful type system

Every expression in [Haskell] has a **type**, and [Haskell] can find type
errors *before* evaluating code. It also uses **type inference** to, in many
cases, figure out the types of values *without* the programmer needing to
*explicitly* declare types (as in C++ or Java).

### Higher-order functions

[Haskell] lets you pass functions as values to other functions, and return
functions as values. Functions that operate on functions are a key part of
functional programming.

### Effectful functions

[Haskell] functions are **pure functions**, i.e. the output of [Haskell]
function depends only on the input to the function, and the function has no
side-effects (such as changing the value of a global variable). This is how
mathematical functions work.

But pure functions can't do everything. For example, input and output is
fundamentally impure. A function `read_string("story.txt")` that opens the
file `story.txt` and returns its content as a string can't be pure because the
returned string depends upon more than just the passed-in name of the file: it
also depends upon the contents of the file itself. It's possible that every
time you call `read_string("story.txt")` you get a different string.

Functions like `read_string` are called **impure functions**.

Most programming languages, including [Racket], let you write impure functions
like `read_string` whenever you need them. But [Haskell] takes a different
approach, and keeps its functions pure. To handle impure calculations, it uses
clever functional patterns such as *monads* and *applicatives*. This allows
impurity to occur in carefully controlled environments.

### Lazy evaluation

An unusual feature of [Haskell] is how it evaluates function calls like
`f(g(2))`. In most programming languages, first `g(2)` is evaluated, and then
the result of that is passed to `f`.

But in [Haskell], `g(2)` is passed to `f` *unevaluated*. Inside of `f` `g(2)`
is only evaluated when its result is *needed*. In other words, [Haskell]
evaluates `g(2)` **lazily**, i.e. it holds off calculating `g(2)` until the
last possible moment.

This feature has a profound effect. Among other things, lazy evaluation lets
us manipulate infinitely long lists, and implement our own versions of
if-statements or short-circuited logical operators. Other languages either
don't allow you to write such code, or require that you do it using **macros**
(which are not functions).


### Equational Reasoning

Many [Haskell] programs can be thought of as a series of **equations**. By
examining these equations we can sometimes determine properties they must
satisfy, which can help with understanding and testing. Sometimes it may even
be possible to systematically transform them into equivalent equations that
are simpler, faster, or more general.


## A Bit of History

[Haskell]'s intellectual roots go back to the early part of the 20th century,
all the way to mathematicians such as [Moses
Schonfinkel](https://en.wikipedia.org/wiki/Moses_Sch%C3%B6nfinkel), [Alonzo
Church](https://en.wikipedia.org/wiki/Alonzo_Church), [Alan
Turing](https://en.wikipedia.org/wiki/Alan_Turing), and [Haskell
Curry](https://en.wikipedia.org/wiki/Haskell_Curry), who were interested in
studying the foundations of logic and computation.

[Haskell] can be viewed as an implementation of the typed [lambda
calculus](https://en.wikipedia.org/wiki/Lambda_calculus). Invented in the
1930s, the [lambda calculus](https://en.wikipedia.org/wiki/Lambda_calculus) is
a mathematical formalism that describes computation. It focuses on functions,
and how they are applied to their inputs. It is the heart of functional
programming.

[Haskell] itself was initiated in 1987 by a group of programming language
researchers, and its development continues to this day. While it has not yet
become a mainstream language, [Haskell] has been a rich source of ideas, with
many of its features adopted by more mainstream languages.

[Racket]: https://racket-lang.org/
[Haskell]: https://en.wikipedia.org/wiki/Haskell_(programming_language)
