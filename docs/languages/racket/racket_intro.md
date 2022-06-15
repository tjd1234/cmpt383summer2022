# Introduction to Racket

[Racket] is a popular modern dialect of [Scheme], and [Scheme] is a popular
dialect of [Lisp]. [Lisp] is a computer programming language originally
developed in the 1950s and 1960s by [John
McCarthy](https://en.wikipedia.org/wiki/John_McCarthy_(computer_scientist))
and his students, and has numerous dialcts and variants.

[Lisp] has some distinctive features compared to most other programming languages:

- **Lists** are the main [Lisp] data structure, and [Lisp] functions and
  expressions are represented as lists. This makes it relatively easy for
  [Lisp] to process its own code.

- [Lisp] is **dynamically typed**, meaning that the types of most values are
  checked only at run-time. Popular mainstream languages like [Python] and
  [JavaScript] are also dynamically typed.

- Functions are **first class** objects in [Lisp]. This means that functions
  can be passed as arguments to functions, and functions can return functions.
  [Lisp] also supports **closures**, which are functions plus an associated
  environment of values and variables. Closures are needed to make passing and
  functions practical. 

  Functions that take other functions as input, or return functions, are
  called **higher order functions**.

- [Lisp] supports **functional programming**, a style of programming that
  emphasizes the use of higher order functions. Functional programming has
  proven to be a popular way to organize programs since it often results in
  clear, short code. [JavaScript] for instance, has many features and
  libraries inspired by functional programming.

- [Lisp] supports **macros**, which are like functions but instead pass their
  arguments *unevaluated* to the macro body. Macros can be used to implement
  features like if-statements and definition environments, which are not
  usually implementable in other languages. Macros are a powerful feature that
  make [Lisp] a good choice for creating other programming languages, or
  experimenting with new language features.

While [Lisp] has never had major mainstream success, it is a rich source of
ideas, many of which have found their way into other languages, and so it is
well worth learning.


## Getting Racket

The easiest way to use [Racket] is with the graphical DrRacket IDE that comes
with it.

[Racket] supports multiple languages, and in these notes we will always be
using the base [Racket] language. To ensure you are using the correct
language, make sure that all your [Racket] programs have this at the top:

```scheme
#lang racket
```

You can find lots of documentation and support for [Racket] online. In
particular, you should bookmark [the Racket
Guide](https://docs.racket-lang.org/guide/index.html), which is a good
overview of [Racket], and also [the Racket
Reference](https://docs.racket-lang.org/reference/index.html), which documents
all its standard functions and features. For instance, [all the standard list
processing functions are documented
here](https://docs.racket-lang.org/reference/pairs.html).

## Running Racket

Once it's installed, run [Racket] by launching the DrRacket IDE. The IDE shows
a *text window* at the top, and an *interaction window* at the bottom. The
idea is that your write your program in the text window, and use the
interaction window to test it, and to evaluate expressions as you go.

Here are a few useful keyboard shortcuts:

- ctrl-*E* opens/closes the interaction window
- ctrl-*D* opens/closes the definitions window
- ctrl-*S* saves the current definitions
- ctrl-*I* re-indents all the code in the definitions window 
- ctrl-*R* runs the current definitions in the interaction window

`>` is the **interpreter prompt**, and means the interactive interpreter is
waiting for you to type something, e.g.:

```scheme
> (* 2 3 5)
30
```

The expression `(* 2 3 5)` calculates the product of 2, 3, and 5.

## Using Racket's Interactive Interpreter

[Racket]'s' interactive interpreter is sometimes called a **REPL**, which
stands for **read-eval-print loop**. It evaluates expressions one at a time.
For instance:

```scheme
> (+ 3 2)
5
> (* 10 4)
40
> (- 5 8)
-3
> (/ 6 2)
3
> (/ 5 2)
2 1/2
```

An interactive REPL is a significant feature of most Lisp-like language. You
typically use it to test small examples, or to run only one part of your
program.


### Basic Arithmetic

All [Racket] functions are called using **prefix notation**. For example,  `(+
3 2)` adds 3 and 2 together. It's *prefix* notation because the `+` is written
first. An expression of the form `2 + 3` is written in **infix notation**,
i.e. the `+` is in-between its arguments.

Most [Racket] expressions are written as **lists**, and lists are delineated
by **parentheses**: the **open parenthesis** `(` marks the start of a list,
and the **close parenthesis** `)` marks the end. Items on the list are
separated by one or more whitespace characters.

We'll sometimes call parentheses **round brackets**, or just **brackets** for
short. [Racket] also lets you use **square brackets**, `[` and `]`, in place
of parentheses anywhere you like. `()`-brackets and `[]`-brackets are
interchangeable, and they are only used to make your code more readable. For
instance, `[]`-brackets are often used to make `cond` and `let` more readable.

Prefix notation has some features that you don't get with infix notation. For
example, you can pass *multiple arguments* to many operations, e.g.:

```scheme
> (+ 3 2 3 5)
13
> (* 1 6 2 2)
24
> (/ 100 10 5)
2
> (- 1 2 3)
-4
```

Also, the order of operations is never ambiguous in prefix notation. To
evaluate an infix expression like $1 + 2 \cdot 3$, you must follow the
convention that multiplication is done *before* addition (e.g. [PEDMAS or
BEDMAS](https://en.wikipedia.org/wiki/Order_of_operations#Mnemonics)). With
infix notation, if you want to do addition first you need brackets, e.g. $(1 +
2) \cdot 3$. With prefix notation, no hidden rules of evaluation are needed:

```scheme
> (+ 1 (* 2 3))    ;; 1 + 2 * 3
7
> (* (+ 1 2) 3)    ;; (1 + 2) * 3
9
```

Essentially, prefix notation requires that you *always* use brackets to make
the order of operations clear. This makes [Racket]'s job of evaluating
expressions easier, but comes at the cost of requiring the programmer to be
explicit about evaluation order.

It can take some getting used to prefix notation, so here are a few more
examples. To calculate $1^2+2^2+3^2$, you can do this:

```scheme
> (+ (* 1 1) (* 2 2) (* 3 3))
14
```

$(1+2)(3+4)(5+6)$ is this:

```scheme
> (* (+ 1 2) (+ 3 4) (+ 5 6))
231
```

The formula for the volume of a sphere is $\frac{4}{3}\pi r^3$, and a sphere
of radius 5.2 has volume $\frac{4}{3}\pi 5.2^3$:

```scheme
> (* 4/3 pi 5.2 5.2 5.2)
588.9774131146049
> (* (/ 4 3) pi 5.2 5.2 5.2)
588.9774131146049
```

`pi` is a pre-defined [Racket] constant:

```scheme
> pi
3.141592653589793
```

### Challenge: arithmetic expressions in Racket

Write each of the following as a [Racket] expression:

1. $2 - 1 * 3$

2. The number of seconds in one year: $60 \cdot 60 \cdot 24 \cdot 365$.

3. The sum of the first 5 Harmonic numbers: 
   $\frac{1}{1} + \frac{1}{2} + \frac{1}{3} + \frac{1}{4} + \frac{1}{5}$. 
   Give your answer as a rational number.

4. $\frac{1}{2 - 1 + 3 * \frac{6}{2}}$

5. $2^3 - 5\cdot 1.1 + \frac{2 \cdot 2 + 3}{10}$
 

## Simple Values

Please read [Racket
Essentials](https://docs.racket-lang.org/guide/to-scheme.html). The following
are some comments on that section.

*Strings* in [Racket] are similar to strings in other languages:

```scheme
> "a"                  ;; a string
"a"
> "a racket is \"an illegal scheme\""   ;; \" inside strings
"a racket is \"an illegal scheme\""
```

[Racket] has built-in support for rational numbers and complex numbers:

```scheme
> (+ 1/3 1/3 1/3)      ;; 1/3 is a rational type
1
> 5/25
1/5
> (* 1+2i 1+2i)        ;; complex types
-3+4i
```

[Racket] has **boolean values**: `#t` is *true* and `#f` is *false*. For
example, relational  operators such as `<`, `<=`, `>` and `>=` compare numbers
and return booleans:

```scheme
> (< 2 3)
#t
> (< 2 2)
#f
> (<= 2 2 4 7)
#t
> (<= 2 2 1 7)
#f
```

When you pass more than two numbers, then `#t` is returned just when the
entire sequence of numbers satisfies the relation. If the numbers `x`, `y`,
and `z`, then `(<= x y z)` returns `#t` just when `x`, `y`, and `z` are in
ascending sorted order.

`=` tests if two or more numbers are the same, e.g.:

```scheme
> (= 2 3)
#f
> (= 2 2 2)
#t
> (= 2 2 1 2)
#f
> (= 3.1 3.1)
#t
> (= 2 10/5)
#t
> (= 4 4 4)
#t
> (= 4 5 4 4)
#f
```

`=` only tests if *numbers* are equal. The more general-purpose `equal?`
function tests if any two values --- which might not be numbers --- are the
same.


## Symbols and Quoting

**Symbols** are a kind of value that are not found in many other mainstream
languages. [Racket] symbols start with a `'`, i.e. a **single-quote**, or
**quote** for short, followed by one or more characters. For example, `'a`,
`'x28`, `'hamster`, and `'color-of-first-shape` are all examples of symbols.

`symbol?` tests if a value is a symbol:

```scheme
> (symbol? 'a)
#t
> (symbol? 'x28)
#t
> (symbol? 'hamster)
#t
> (symbol? 'color-of-first-shape)
#t

> (symbol? 4)      ;; 4 is a number
#f
> (symbol? odd?)   ;; odd? is a function
#f
> (symbol? x)      ;; missing '
. . x: undefined;
 cannot reference an identifier before its definition
```

Symbols look like strings, but they are intended to be used quite differently.
You usually shouldn't need to access the individual characters they're made
from. If you do, use a string instead.

> The functions `symbol->string` and `string->symbol` convert between symbols
  and strings. They are not commonly used, but they can be helpful if you want
  to, say, restrict the format of symbols. For example, some functions might
  want to treat symbols that end with a `?` in a special way, and by using
  `symbol->string` you can convert the symbol to a string and check if the
  last character is a `?`.

The quote, `'`, in front of symbols is important because it distinguishes
symbols from variables. For example, `x` is a variable, while `'x` is a
symbol:

```scheme
> (symbol? 'x)
#t
> (symbol? x)
. . x: undefined;
 cannot reference an identifier before its definition
```

The expression `(symbol? x)` can't be evaluated because [Racket] applies
`symbol?` to the value *bound* to `x`. But in this case, `x` is not bound to
anything, so there's an error.

Like numbers, symbols evaluate to themselves:

```scheme
> 'a
'a
> 'cat
'cat
```

This contrasts with variables, which evaluate to the value they're bound to.

### Quoted Lists

You can also quote lists, e.g.:

```scheme
> (+ 2 3)     ;; unquoted lists are evaluate
5
> '(+ 2 3)    ;; quoted lists evaluate to themselves
'(+ 2 3)
```

`'(+ 2 3)` is *not* a symbol. Instead, it's a list:

```scheme
> (symbol? '(+ 2 3))
#f
> (list? '(+ 2 3))
#t
```

If you don't put a `'` in front of the list, then it evaluates to 5:

```scheme
> (list? (+ 2 3))   ;; same as (list? 5)
#f
```

The unquoted expression `(+ 2 3)` is a call to the function `+`. It's *code*
that runs and evaluates to 5. `'(+ 2 3)` is just *data*, and it doesn't run.
`'(+ 2 3)` is just a list of three values, and it evaluates to itself.

Another way of quoting expressions in [Racket] is to use `quote`:

```scheme
> (quote (+ 2 3))
'(+ 2 3)
```

`(+ 2 3)` does *not* get evaluated inside of a `quote`. `quote` is an example
of a **special form**: it does *not* evaluate its argument.

In general, `(quote x)` is the same as `'x`. The single-quote form is usually
preferred because it has fewer brackets, e.g.:

```scheme
> (symbol? (quote (+ 2 3)))
#f
> (list? (quote (+ 2 3)))
#t

> (symbol? '(+ 2 3))
#f
> (list? '(+ 2 3))
#t
```

### Challenge: quoted lists

For each of the following expressions, try to evaluate them first in your
head, and then check your answer in the [Racket] interpreter. Some are quite
tricky!

1. `(* 1 (+ 2 3))`
2. `'(* 1 (+ 2 3))`
3. `(* 1 '(+ 2 3))`
4. `(quote (+ 2 3))`
5. `''a`
6. `'(quote (+ 2 3))`
7. `(quote '(+ 2 3))`
8. `(quote (quote (+ 2 3)))`
9. `(quote quote)`
10. `(+ 2 (quote 3))`
11. `'(+ 2 (quote 3))`

## Calling Functions

Expressions such as `(+ 2 3)` and `(symbol? '(+ 2 3))` are examples of
**function calls**. In general, [Racket] function calls have the form `(fn
arg1 arg2 ... argn)`. The function *always* comes first in a function call,
and then the arguments.

Some functions, such as `+` and `*`, can take a varying number of arguments.
Other functions, such as `symbol?` and `list?`, take a fixed number of
arguments (both `symbol?` and `list?` take one argument).

Since the function comes first in a function call list, an expression like `(2
3 +)` is an *error* because 2 is not a function:

```scheme
> (2 3 +)
. . application: not a procedure;
 expected a procedure that can be applied to arguments
  given: 2
  arguments...:
```

[Racket]'s syntax for calling functions is simple and consistent. But a
significant downside for many programmers is that arithmetic expressions don't
look like the kind of arithmetic they learned in high school, i.e. [Racket]
arithmetic is prefix instead of infix. Prefix arithmetic and list notation are
often cited as significant reasons why LISP-like languages are not more
popular.


## Simple Definitions

The form `(define some-var some-val)` is used to create names that have a
value assigned to them. For example:

```scheme
(define scale 4.5)
(define title "Dr. Racket")
```

These two lines can be typed into the **definitions window** of DrRacket.
After clicking "Run" (or typing ctrl-*R*), you can use `scale` and `title` in
expressions:

```scheme
> (* scale 5)
22.5
> (string-append title "!!!")
"Dr. Racket!!!"
```

Function definitions typically use this form:

```scheme
(define (inc n) 
  (+ 1 n))
```

This defines a function named `inc` that takes one input, here called `n`, and
returns `n` plus 1. It is up to the programmer to make sure that only numbers
are passed to `inc`:

```scheme
> (inc 5)
6
> (inc "five")
. . +: contract violation
  expected: number?
  given: "five"
  argument position: 2nd
  other arguments...:
```

**Be careful!** You can use `define` to change the meaning of built-in
[Racket] forms. For example, you can define `define` to be some other value:

```scheme
> > (define x 5)
> x
5
>> (define define 'make)
>> define
'make
>> (define y 3)
. . y: undefined;
 cannot reference an identifier before its definition
```

Now `define` no longer works! You must re-run the interpreter to fix it.


### Side-effects and Pure Functions

Here's an example of a function with **side-effects**:

```scheme
(define (greet name)
  (printf "Welcome to Racket ~a!" name)
  (newline)
  (printf "I hope you learn a lot.")
)
```

It is called like this:

```scheme
> (greet "Alan")
Welcome to Racket Alan!
I hope you learn a lot.
```

`greet` *doesn't* return a value. The only reason we call it is for its
**side-effects**, i.e. for what it prints to the screen. When you call a
function, anything that causes a change *outside* of the function --- such as
printing to the screen, reading from a file, setting a global variable, etc.
--- is a side-effect of the function. In general, we will try to avoid
side-effects in [Racket] whenever possible. Unnecessary side-effects tend to
make programs more complicated and error-prone.

A function with no side effects always returns the same output for the same
input, is called a **pure function**. Regular mathematical functions are pure
functions, and we'll try to use pure functions whenever possible.


## Quasiquoting

A **quasiquote** is a backwards quote mark in [Racket], and it is a more
general form of regular quoting. For example:

```scheme
> (define lst '(a b c))

> `(letters ,lst and chars ,@lst)
'(letters (a b c) and chars a b c)
```

Inside a quasiquoted list, a `,` means that next value is *unquoted*. `,@`
before a list means to *splice* the values of the list directly into the
quoted expression, as shown.

In practice, quasiquoting can make some [Racket] expressions much more compact
and easier to read. For instance, it is often used with the `match` form, or
when constructing complex lists. Like many features of [Racket], quasiquoting
can be confusing and intimidating at first, but once you get used to it it can
be a very useful feature.


### Challenge: quasiquoted lists

For each of the following expressions, try to evaluate them first in your
head, and then check your answer in the [Racket] interpreter.

Assume the following definitions:

```scheme
(define scores '(1 3 2))
(define pets '(dog cat))
```

1. `` `(scores pets)``
2. `` `(,scores pets)``
3. `` `(,scores ,pets)``
4. `` `(scores ,@pets)``
5. `` `(,scores ,@pets)``
6. `` `(,@scores ,@pets)``
7. `` `((scores ,@scores) (pets ,pets))``
8. `` `(4 ,@scores 5)``
9. `` `(bird ,pets 4 ,@scores 5)``
10. `` `(,@(+ 2 3))``
11. `` `(,(+ 2 3))``


## Source Code Comments in Racket

There are a couple of ways of writing [Racket] source code comments:

- `;` is a single-line comment: characters after `;` and to the end of the
  line are ignore, e.g.:

  ```scheme
  ; single-line comments start with ";" in Racket
  
  ;;;
  ;;; more semi-colons can be used for emphasis
  ;;;
  ```

- `#|` and `|#` can mark multi-line comments: `#|` is the start of the comment
  and `|#` is the end of the comment, e.g.:

  ```scheme
  #|

    This is an example of a 
    multi-line comment.

  |#
  ```

- `#;` comments out an entire expression, e.g.:

   ```scheme
    #;(define (nlist? n lst)
      (and (list? lst) 
           (= n (length lst))))
   ```

`#;` is quite handy in practice, and is a kind of commenting not found in most
other languages.


## Conditionals: if, and, or, cond

**Conditionals** make *decisions*. The `if` form is like an if-then-else
statement in other languages, and it always has this form:

```scheme
(if <condition> <true-result> <false-result>)
```

`<condition>` is an expression that evaluates to `#t` (true) or `#f` (false).
If `<condition>` is `#t`, then `<true-result>` is evaluated; otherwise,
`<false-result>` is evaluated.

Importantly, `if` --- like all other [Racket] conditionals --- *returns* its
result. It's like the `?:` operator in C++ or [Java]. So we can use `if`
forms inside other calculations, e.g.:

```scheme
(define x 2)
(define y 3)

> (* 2 (if (< x y) y x))
6
> (- (if (< x y) y x) (if (> x y) y x))
1
```

The last expression calculates the max of `x` and `y` minus their min. So we
could have written these function definitions:

```scheme
(define (mymax x y)     ;; max and min are already defined in
    (if (> x y) x y))   ;; Racket, so we call these mymax/mymin

(define (mymin x y)
    (if (< x y) x y))

> (- (mymax 5 2) (mymin 5 2))
3
```

Or we could define one function to do the entire calculation:

```scheme
(define (abs-diff x y)
  (if (< x y)
      (- y x)
      (- x y)))

> (abs-diff 5 2)
3
```

The `and` form calculates the logical "and" of 0 or more boolean expressions:
`(and <test1> <test2> ...)` returns `#t` just when *all* of the tests evaluate
to true, and `#f` otherwise. For example:

```scheme
> (and)
#t
> (and (= 2 3))
#f
> (and (= 2 2) (< 4 5))
#t
> (and (= 2 2) (< 4 5) (> 4 10))
#f
```

Importantly, `and` uses **short-circuiting**: the inputs to `and` are
evaluated in the order they're given (left to right), and after the first one
evaluates to `#f`, the expression immediately returns `#f` without evaluating
any more of the expressions.

For example, the following function relies on the fact that `and` is
short-circuited:

```scheme
(define (good-password x)
  (and (string? x)                   ;; must be a string
       (<= 8 (length x))             ;; at least 8 chars
       (not (string-contains? x " ") ;; has no spaces
)))
```

`(good-password s)` returns `#t` if `s` is a "good" password, and `#f`
otherwise. The first thing it checks is that `s` is indeed a string. If `s` is
not a string, then the following calls to `length` and `string-contains?`
would fail with an error. Since `and` is short-circuited, when `(string? x)`
is `#f` the entire expression returns `#f` and the last two expressions are
*never evaluated*.

The `or` form is similar to `and`: `(or <test1> <test2> ...)` returns `#t` if
1, or more, of the tests evaluate to `#t`, and `#f` otherwise. For example:

```scheme
> (or)
#f
> (or (= 2 3))
#f
> (or (= 2 3) (< 4 5))
#t
> (or (= 2 3) (> 4 5) (> 6 10))
#f
```

Like `and`, `or` is short-circuited: the tests are evaluated in order (from
left to right), and soon as one evaluates to `#t` no further tests are
evaluated and the entire expression evaluates to `#t`. For instance, this
expression returns `#t` thanks to short-circuiting:

```scheme
> (or (= 2 2) (error "oops"))
#t
```

Changing the order of evaluation changes the results:

```scheme
> (or (error "oops") (= 2 2))
. . oops
```

Finally, the `cond` form is similar to if-else-if structures in other
languages:

```scheme
(define (sign n)
  (cond [(not (number? n)) "not a number"]
        [(< n 0) "negative"]
        [(> n 0) "positive"]
        [else "zero"]
))

> (sign -5)
"negative"
> (sign 3)
"positive"
> (sign 0)
"zero"
> (sign "three")
"not a number"
```

In general, a `cond` form looks like this:

```scheme
(cond [test1 result1]
      [test2 result2]
      ...
      [else result_else]
)
```

When `cond` is evaluated, first `test1` is evaluated. If it's `#t`, then
`result1` is evaluated and the entire `cond` expression returns `result1` (and
no more tests are evaluated). If instead `test1` is `#f`, then `test2` is
evaluated. If `test2` is `#t`, then the entire `cond` returns `result2`.
Otherwise, if `test2` is `#f`, the rest of the `cond` is evaluated in a
similar fashion.

The final test is `else`, which is a synonym for `#t`. Since `else` is always
true, if the program ever gets to it then `result_else` will be returned as
the value of the `cond`.

A `cond` *doesn't* need to have an `else`: it's optional.

It's important to understand that as soon as one test in the `cond` evaluates
to true, all later tests (and results) are *not* evaluated. This means that
`cond` is *not* a function (because all arguments to a function are
evaluated), and is instead another example of a special form.

The use of `[]`-brackets in `cond` expressions is just a convention to improve
readability, and you can use regular round brackets if you prefer. For
instance:

```scheme
(define (sign n)
  (cond ((not (number? n)) "not a number")
        ((< n 0) "negative")
        ((> n 0) "positive")
        (else "zero")
))
```

`[]`-brackets *mean* the same thing as `()`-brackets, and so you can use them
anywhere you like. Only use `[]`-bracket when they improve the readability of
code.


## Conditionals are Not Functions

Suppose `x` is a variable that has already been defined, but we don't know
what it's value is. The expression `(and (number? x) (= x 0))` is `#t` if `x`
is a number equal to 0, and `#f` otherwise. If `x` happens to be a list, or
some other non-numeric value, then the expression evaluates to `#f` thanks to
the fact that `and` uses short-circuit evaluation.

You might wonder if it's possible to write your own version of `and` as a
function. Maybe something like this:

```scheme
(define (bad-and e1 e2)   
    (if e1 
        (if e2 #t #f)
        #f
    )
)
```

This returns `#t` if both `e1` and `e2` are true, and `#f` otherwise. Also, if
`e1` is false, then it knows the entire expression must be `#f`, and it
doesn't evaluate `e2`.

But this doesn't work in [Racket] because function arguments are evaluated
*before* calling the function. Suppose `x` is defined to be the list `'(a b
c)`, and consider what would happen if you evaluate `(bad-and (number? x) (= x
0))`:

- First `(number? x)` is evaluated, and it evaluates to `#f` because `x` is
  the list `'(a b c)`.

- Second, `(= x 0)` is evaluated, and this causes an error because `=` doesn't
  work with lists:

  ```scheme
  > (= 0 '(a b c))
  . . =: contract violation
    expected: number?
    given: '(a b c)
    argument position: 2nd
    other arguments...:
  ```

So the expression fails with an error before `my-and` is even called.

Conditional forms like `if`, `and`, `or`, and `cond` *don't evaluate their
arguments*, and so they are considered special forms. Their arguments are
passed *unevaluated* so that the conditional can control when to evaluate
them.

In [Racket], conditional forms like `if`, `and`, `or`, and `cond` *cannot be
written as functions*. But they can be written as **macros**. Macros are
function-like definitions that *don't* evaluate their arguments, and let the
body code decide when to evaluate them. Macros let you implement conditionals
and other special forms (such as `define`). 


## Challenge: letter grades

Implement a [Racket] function called `(grade score)` that returns a letter
grade for the given numeric `score`. You can assume `score` is a number.
Letter grades are assigned according to this table:

- 95 <= A+
- 90 <= A < 95
- 85 <= A- < 90
- 80 <= B+ < 85
- 75 <= B < 80
- 70 <= B- < 75
- 65 <= C+ < 70
- 60 <= C < 65
- 55 <= C- < 60
- 50 <= D < 55
- F < 50

`'A+` and `'C-` are valid [Racket] symbols, and so you should return such
symbols.

For example:

```scheme
> (grade 102)
'A+
> (grade 84.6)
'B+
> (grade 59.8)
'C-
> (grade 50)
'D
> (grade -72)
'F
```

## Notes on "Racket Essentials": Lambda Functions

A **lambda function**, also know as an **anonymous function**, is an
expression that evaluates to a function. It's a function without a name.

For example, this lambda function doubles its input:

```scheme
(lambda (n) (* 2 n))   ;; a lambda function
```

The entire expression evaluates to a function that takes a single input, `n`,
and returns `n` times 2. You could use it directly like this:

```scheme
> ((lambda (n) (* 2 n)) 31)
62
```

You can also define a variable to be a function like this:

```scheme
(define double (lambda (n) (* 2 n)))

> (double 31)
62
```

The definition is equivalent to this one:

```scheme
(define (double n) (* 2 n))
```

In general, a lambda function has the format `(lambda (arg1 arg2 ... argn)
body-expr)`.

Lambda functions are often used when you want to pass a function to another
function. For example, consider the `twice` function:

```scheme
(define (twice f x)  ;; call f twice on input x
    (f (f x)))
```

You can use `twice` like this:

```scheme
> (twice sqr 3)    ;; (sqr (sqr 3))
81
> (twice sqrt 3)   ;; (sqrt (sqrt 3))
1.3160740129524924
> (twice (lambda (x) (+ 6 x)) 3)
15
```

The last example could instead have been written like this:

```scheme
(define (add6 x) (+ 6 x))

> (twice add6 3)
15
```


## Challenge: making new functions

In this challenge, `f` and `g` are any functions that take a single number as
input, and return a number. Implement the following two functions:

1. `(make-abs f)` returns a new function that takes one number `x` as input
   and returns the *absolute value* of `(f x)`.

2. `(make-max f g)` returns a new function that takes one number `x` as input
   and returns the *max* of `(f x)` and `(g x)`.

For example:

```scheme
(define (f1 x) (+ (* 2 x) 5))
(define (g1 x) (* x x))

(define abs-f1 (make-abs f1))
(define abs-g1 (make-abs g1))
(define max-fg (make-max f1 g1))

> (f1 -10)
-15
> (abs-f1 -10)
15
> (max-fg -1)
3
> (max-fg -10)
100
```


## Local Bindings with let and let*

A **local variable**, or a **local binding** is a variable that is usable only
within a clearly defined scope. In [Racket], local variables can be introduced
using a `let` form like this:

```scheme
(define (dist1 x1 y1 x2 y2)
  (let ([dx (- x1 x2)]
        [dy (- y1 y2)])
    (sqrt (+ (* dx dx) (* dy dy)))))
```

`dx` and `dy` are local variables that only exist within the scope of the
`let` form. In general, `let` has this form:

```scheme
(let ([v1 val1]
      [v2 val2]
      ...
      [vn valn]
  body ;; v1, v2, ..., vn can be used here
)
```

The entire `let` form evaluates to whatever `body` evaluates to.

As with `cond`, it is conventional (but not required) that `[]`-brackets
enclose the bindings. You could write `let` like this if you prefer:

```scheme
(let ((v1 val1)  ;; ()-brackets can be used instead of 
      (v2 val2)  ;; []-brackets
      ...
      (vn valn)
  body  
)
```

Most [Racket] programmers find the version with `[]`-brackets to be more
readable, and so it is the preferred style.

Consider this example of `let`:

```scheme
> (let ([a 1] [b 1] [c 2]) (+ a b c))
4
```

There is a subtlety here that is worth exploring a bit. It could be re-written
without `let` like this:

```scheme
> ((lambda (a b c) (+ a b c)) 1 1 2)
4
```

This shows that we can *simulate* `let` using a function call: calling a
function binds its input arguments to its formal parameters.

Indentation makes the scope clearer:

```scheme
( 
  (lambda (a b c) 
     (+ a b c)
  ) 
  1 1 2  ;; a, b, c are not in scope here
)
```

The `let` version is much easier to read because it puts the variables right
beside their assigned values. Here, the variables are quite far away from
their values. But nonetheless, it shows that `let` can be built from simpler
concepts.

Notice that the scope of `a`, `b`, and `c` is limited to the lambda function
they're defined in. You can't use `a`, `b`, or `c` outside of it. So this
expression causes an error:

```scheme
( 
  (lambda (a b c) 
     (+ a b c)
  ) 
  1 a 2  ;; error: a is not in scope
)
```

If you re-write this as an equivalent `let` expression, you get this:

```scheme
(let ([a 1]
      [b a]  ;; error: a is out of scope here!
      [c 2]
     )
     (+ a b c)
)
```

This is an error, presumably because `let` is converted into something like
the lambda version we wrote above.

This limitation is inconvenient in practice. And so [Racket] provides the
`let*` form which removes this restriction:

```scheme
(let* ([a 1]
       [b a]  ;; ok: this is a let* environment
       [c 2]
      )
  (+ a b c)
)
```

You can imagine that `let*` re-writes the expression using embedded `let`
forms, perhaps like this:

```scheme
(let ([a 1])
    (let ([b a])     ;; ok: a is in scope
        (let ([c 2])
            (+ a b c)
        )
    )
)
```

Or even as plain lambdas:

```scheme
(
  (lambda (a)
      (
        (lambda (b)
            (
              (lambda (c)
                  (+ a b c)
              )
              2 ;; bound to c
            )
        )
        a ;; bound to b
      )
  )
  1 ;; bound to a
)
```

In practice, many programmers use `let*` exclusively instead of `let`.


[Scheme]: https://en.wikipedia.org/wiki/Scheme_(programming_language)
[Racket]: https://racket-lang.org/
[LISP]: https://en.wikipedia.org/wiki/Lisp_(programming_language)
[Java]: https://en.wikipedia.org/wiki/Java_(programming_language)
[Python]: https://en.wikipedia.org/wiki/Python_(programming_language)
[JavaScript]: https://en.wikipedia.org/wiki/JavaScript
