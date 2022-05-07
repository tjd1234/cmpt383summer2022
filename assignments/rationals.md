# A Rational Type

Implement a **rational** number type in a way that make sense in the language.
A rational type represents a rational number, as described in these [notes on
rational numbers](notes_on_rationals.md).

Your rational type should support at least the following operations. Please
put the number of each operation in a comment in your source near it's
implementation to help the marker understand your code.

1. **Make a rational**: Given integers $`a`$ and $`b`$, create a new rational
   with $`a`$ as the numerator and $`b`$ as the denominator. Trying to create
   a rational with denominator 0 is an error, but it should *not* crash your
   program. Instead, handle this case in a systematic way that makes sense
   within your programming language; the language-specific notes at the bottom
   may give you hints.

2. **Get the numerator** Returns the numerator of a given rational.

3. **Get the denominator** Returns the denominator of a given rational.

4. **Get the numerator and denominator as a pair** Returns both the numerator
   and denominator. Call this operation *split*, i.e. splitting 5/3 gives (5,
   3).

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

15. **Harmonic sum** Given an integer $`n > 0`$, return a rational equal to
    $`H_n = \frac{1}{1} + \frac{1}{2} + \frac{1}{3} + \ldots + \frac{1}{n}`$.



## General Notes

The purpose of this assignment is to demonstrate your understanding of the
basic features of the language. **Show us you understand the language by using
its features in a sensible way**.

So you should implement and design your own **original** rational type, and
write all the code yourself. *Don't* use any special packages or libraries
that do a substantial part of the work. You can use basic helper functions
from your language's standard library.

Most of the languages we're using already have built-in support for rational
numbers. But **don't** use them in your implementation. Calling pre-made code
doesn't demonstrate much understanding of the language.

Handling invalid fractions is important, and we want to see you use an
error-handling strategy that is recommended for your language. *Don't* let the
program crash when something *expected* goes wrong (e.g. dividing by 0 should
never crash the program).


## Go-specific Notes

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


## Ruby-specific Notes

Represent the rationals using a class.

Ruby already has a standard class called `Rational` that implements rational
numbers. *Don't* use it in your implementation. Create your own original
implementation of rationals called `MyRational` that *doesn't* use Ruby's
`Rational` anywhere.

In addition to the equality and less than operators, also implement the
*spaceship operator* `<=>`, so that `MyRational` objects can be sorted with
Ruby's standard sorting function.

More details may be posted here closer to the assignment deadline.


## Racket-specific Notes

Represent rationals using a regular list and functions. Don't use any special
Racket data structures for this.

Racket has built-in support for rational numbers. *Don't* use it anywhere in
your implementation. Create your own original implementation of rationals that
*doesn't* use the built-in rationals anywhere.

More details may be posted here closer to the assignment deadline.


## Haskell-specific Notes

Haskell has a standard `Rational` type. *Don't* use it in your implementation.
Create your own original implementation of rationals in a typeclass called
`MyRational` that doesn't use Haskell's `Rational` anywhere.

More details may be posted here closer to the assignment deadline.


## Prolog

Prolog is quite different than the other languages in this course, and so an
assignment more specific to Prolog will be put here when it's ready.

More details may be posted here closer to the assignment deadline.
