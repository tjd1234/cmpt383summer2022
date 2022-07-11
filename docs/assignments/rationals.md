# A Rational Type

Implement a **rational** number type in a way that make sense in the language.
A rational type represents a rational number, as described in these
[mathematical notes on rational numbers](notes_on_rationals.md).

Your rational type should support at least the following operations. Please
put the number of each operation in a comment in your source near it's
implementation to help the marker understand your code.

1. **Make a rational**: Given integers $a$ and $b$, create a new rational with
   $a$ as the numerator and $b$ as the denominator. Trying to create a
   rational with denominator 0 is an error, but it should *not* crash your
   program. Instead, handle this case in a systematic way that makes sense
   within your programming language; the language-specific notes at the bottom
   may give you hints.

2. **Get the numerator** Returns the numerator of a given rational.

3. **Get the denominator** Returns the denominator of a given rational.

4. **Get the numerator and denominator as a pair** Returns both the numerator
   and denominator. Call this operation *pair*, i.e. calling *pair* on 5/3
   gives (5, 3).

5. **Convert to a string** Returns the usual string representation of the
   rational. For instance, 5/3 would be the string "5/3".

6. **Convert the fraction to a floating point value** Returns the value as the
   number as a floating point number. For example, 5/2 is 2.5, 1/3 is 0.3333,
   etc.

7. **Test for equality** Tests if two given rationals are equal. Be careful if
   either is not in lowest terms!

8. **Test for order: less than** Tests if a given rational is **less than**
   another given rational. Be careful with negative values, and when either is
   not in lowest terms!

9. **Test if an integer** Tests if a given rational is equal to an integer.
   For example, 4/1, 21/3, and 0/99 are all integers.

10. **Add** Adds two given rationals and returns a new rational that is there
    sum.

11. **Multiply** Multiply two given rationals and returns a new rational that
    is their product.

12. **Divide** Divide two given rationals and returns a new rational that is
    their quotient. Be careful to systematically handle possible division by
    zero.

13. **Invert** Invert a given rational and returns a new one with the
    numerator and denominator switched. For example, 2/3 inverts to 3/2. Make
    sure to systematically handle 0 numerators, e.g. 0/3 inverts to 3/0, which
    is not a rational.

14. **Reduce to lowest terms** Reduce a given rational and returns a new
    rational that is in lowest terms. For example, 36/20 reduces to 9/5. Use
    the greatest common divisor (GCD) algorithm to help do this. Be careful in
    the case where the numerator or denominator is negative.

15. **Harmonic sum** Given an integer $n > 0$, return a rational equal to $H_n
    = \frac{1}{1} + \frac{1}{2} + \frac{1}{3} + \ldots + \frac{1}{n}$.


## General Notes

The purpose of this activity is to demonstrate your understanding of the basic
features of the language. **Show us you understand the language by using its
features in a sensible way**.

So you should implement and design your own **original** rational type, and
write all the code yourself. *Don't* use any rational-specific packages or
libraries that do a substantial part of the work. You can use basic helper
functions from your language's standard library.

Most of the languages we're using already have built-in support for rational
numbers. But **don't** use them in your implementation. Calling pre-made code
doesn't demonstrate the understanding of the language we're looking for.

Handling *invalid* fractions is important, and we want to see you use an
error-handling strategy that is recommended for your language. *Don't* let the
program crash when *ordinary errors* occur (e.g. dividing by 0 should never
crash the program).


## Go-specific Notes

**Do not use Go generics** for any part of this assignment. They are a very
recent feature of the language that not all Go compilers support yet. So
please do not use them (if you do you may be asked to re-write your code
without generics).

Represent rationals using a `struct` that implements the following
`Rationalizer` interface. Note that this interface does *not* include making a
rational or calculating the harmonic sum, and so you should implement those as
regular functions.

**Important**: *Don't* change the given interfaces in any way.

```go
type Floater64 interface {
    // Converts a value to an equivalent float64.
    toFloat64() float64
}

type Rationalizer interface {

    // 5. Rationalizers implement the standard Stringer interface.
    fmt.Stringer

    // 6. Rationalizers implement the Floater64 interface.
    Floater64

    // 2. Returns the numerator.
    Numerator() int

    // 3. Returns the denominator.
    Denominator() int

    // 4. Returns the numerator, denominator.
    Split() (int, int)

    // 7. Returns true iff this value equals other.
    Equal(other Rationalizer) bool

    // 8. Returns true iff this value is less than other.
    LessThan(other Rationalizer) bool

    // 9. Returns true iff the value equal an integer.
    IsInt() bool

    // 10. Returns the sum of this value with other.
    Add(other Rationalizer) Rationalizer

    // 11. Returns the product of this value with other.
    Multiply(other Rationalizer) Rationalizer

    // 12. Returns the quotient of this value with other. The error is nil 
    // if its is successful, and a non-nil if it cannot be divided.
    Divide(other Rationalizer) (Rationalizer, error)

    // 13. Returns the reciprocal. The error is nil if it is successful, 
    // and non-nil if it cannot be inverted.
    Invert() (Rationalizer, error)

    // 14. Returns an equal value in lowest terms.
    ToLowestTerms() Rationalizer
} // Rationalizer interface
```

Use `errors.New` to create error values.

More details may be posted here closer to the assignment deadline.


## Ruby-specific Notes {#ruby-specific-notes}

- Represent the rationals using a class.

- Ruby already has a standard class called `Rational` that implements rational
  numbers. **Don't** use it. Create your own original implementation of
  rationals called `MyRational` that *doesn't* use Ruby's `Rational` anywhere.

- Use Ruby **exceptions** to handle errors. For example, use `raise` to cause
  an exception due to an error, e.g. `raise 'MyRational: denominator cannot be
  0'`.

- For part 2 and 3, name the methods `num` and `denom`, and implement them
  using `attr_reader`.

- For part 4, please name the method `pair`, and it should return an array
  `[n,d]`, where `n` is the numerator and `d` is the denominator.

- For part 5, please name the method `to_s`.

- For part 6, please name the method `to_f`. In addition, in the standard Ruby
  `Integer` class add a method called `to_mr` that returns a new `MyRational`
  equivalent to the integer. For example, the expression `5.to_mr` returns a
  new `MyRational` with numerator 5 and denominator 1.

- For part 7, please implement as the standard equality operator `==` as a
  method.

- For part 8, please implement the *spaceship operator* `<=>` as a method, and
  include the [Comparable
  module](https://docs.ruby-lang.org/en/2.5.0/Comparable.html) to get all the
  relational operators.

- For part 9, please name the method `int?`.

- For parts 10, 11, and 12, implement the standard arithmetic operators `+`,
  `*`, and `/`.

- For part 13, please name the method `invert`.

- For part 14, please name the method `to_lowest_terms`.

More details may be posted here closer to the assignment deadline.


## Racket-specific Notes

- Use only regular Racket lists, and basic Racket functions as discussed in
  the notes. **Don't** use any special Racket data structures, e.g. *don't*
  use vectors, or structs, or hashes, .... It may be helpful to look at the
  code in [point.rkt](../languages/racket/point.rkt) for ideas.

- **Don't** use Racket's built-in rationals to represent or process your
  rationals, except in `to-float`. Look up the Racket function
  `exact->inexact`.

- **Don't** use any mutating functions, like `set!`. Most mutating Racket
  functions end with `!`, and so don't use any of those. Use just non-mutating
  functions as shown in the notes and lectures.

- Represent your rationals using lists. For example, you could represent
  $\frac{3}{7}$ as `'(rational 3 7)`.

- Racket has exceptions, and so please use `raise` when something goes wrong.
  For example, `(raise "invalid denominator")` will raise an exception that
  can be caught by other code.

- For *part 1*, call your function `make-rational`. It should work if you pass
  it one or two parameters. For example, `(make-rational 3 7)` returns a
  rational representing $\frac{3}{7}$. `(make-rational 5)` returns a rational
  representing $\frac{5}{1}$. To handle multiple parameters define your
  function like this: `(define (make-rational . args) ... )`. `args` will then
  be a list of the passed-in arguments.

- For part 2 and 3, name the functions `r-numerator` and `r-denominator`
  (Racket already has built-in functions called `numerator` and
  `denominator`). For example, `(r-numerator (make-rational 3 7))` returns 3.

- For part 4, call the function `num-denom`. It returns a list containing the
  numerator and denominator, e.g. `(num-denom (make-rational 3 7))` returns
  `'(3 7)`.

- For part 5, call the function `to-string`. For example, `(to-string
  (make-rational 3 7))` returns the string `"3/7"`.

- For part 6, call the function `to-float`. For example, `(to-float
  (make-rational 3 7))` returns `0.42857142857142855` in DrRacket. Look up the
  Racket function `exact->inexact`.

- For part 7, call the function `r=`.

- For part 8, call the function `r<`. Be careful about with negative values!

- For part 9, call the function `is-int?`.

- For parts 10, 11, 12, and 13, call the functions `r+`, `r*`, `r/`, and
  `invert`.

- For part 14, call the function `to-lowest-terms`.

- For part 15, call the function `harmonic-sum`.

- You can time code (such as insertion sort) using [Racket's `(time ...)` form](https://docs.racket-lang.org/reference/time.html#%28form._%28%28lib._racket%2Fprivate%2Fmore-scheme..rkt%29._time%29%29), e.g.:

  ```lisp
  > (time (num-primes-less-than 10000))
  cpu time: 1531 real time: 1528 gc time: 607
  1229
  ```

More details may be posted here closer to the assignment deadline.


## Haskell-specific Notes

- Download the file [rational.hs](haskell/rational.hs) and type your answers
  there. The required functions, including their type signatures, are given in
  comments.

- **Don't** use Haskell's standard `Rational` type in your implementation.

- **The error-handling rules are changed for this assignment**. When an error
  occurs (such as division by zero), your code should call the `error "some
  message"` function. This crashes the program with no way to recover, which
  is clearly bad. However, we don't have enough time in this course to learn
  Haskell's preferred way of handling errors (e.g. something like the `Maybe`
  type).

- **The marking scheme has been adjusted for this assignment**. The three
  sections *number sorting*, *string sorting*, and *rational sorting* have
  been **removed**. Only marks for the insertion sort implementation (that
  sorts any list of values implementing `Ord`) will be given. So this
  assignment is out of 27 (instead of 36).

- Here are two ways to calculate timings for your Haskell code:

  1. Add a `main` function to the end of your
     [rational.hs](haskell/rational.hs) file and call the sorting code there.
     *Compile* this file, and time it using the command-line *time* command.
     See [mainDemo.hs](haskell/mainDemo.hs) for an example of how to write
     `main`, how to get a list of random numbers, and how to compile it with
     `ghc`.

  2. In the Haskell interpreter `ghci` use the command `:set +s`. This will
     show you the running time, in seconds, for each evaluated expression:

     ```haskell
     > :set +s
     > product [1..10000]
     ... huge number ...
     (0.54 secs, 112,187,640 bytes)
     ```
  
More details may be posted here closer to the assignment deadline.


## Prolog

Prolog is quite different than the other languages in this course, and so it's
possible an assignment more specific to Prolog may be used instead of the
rational numbers one.

More details may be posted here closer to the assignment deadline.
