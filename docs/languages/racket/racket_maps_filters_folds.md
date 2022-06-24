---
tags: ["#racket"]
---

**Functional programming** is a style of programming that focuses on
*functions*. In particular, **higher-order functions**, which are functions
that take functions as arguments, or return functions as values.

Three of the most useful higher-order functions are `map`, `filter`, and
`fold`. They appear in many other programming languages, and have many
practical uses.


## Mapping

The `(map f lst)` function applies a given function to every element of a
list:

```scheme
> (map sqr '(1 2 3 4))
'(1 4 9 16)
> (map list '(this is a test))
'((this) (is) (a) (test))
```

In general, `(map f '(x1 x2 ... xn))` returns the value of `((f x1) (f x2) ...
(f xn))`.

Here's an implementation of `map`:

```scheme
(define (my-map f lst)
  (if (empty? lst) '()
      (cons (f (first lst))
            (my-map f (rest lst)))))
```

## Challenge: list sums

Suppose `lst` is a list of number lists, where a number list is a list of
numbers. `lst` has zero or more number lists, and each number list has 0 or
more numbers.

Implement a function called `(add-sums lst)` that returns  new list that is
the same as `lst` but the sum of each list of `lst` is has its sum added as
the first element.

For example:

```scheme
> (add-sums '(() (1) (2 3)))
'((0) (1 1) (5 2 3))
> (add-sums '((1 2 3) (4) (5 6) (7 0 0 1)))
'((6 1 2 3) (4 4) (11 5 6) (8 7 0 0 1))
```

## Challenge: normalizing a list of numbers

Suppose `lst` is a list of 0 or more numbers.

Implement a function called `(normalize lst)` that returns a *normalized*
version of `lst`. To normalize `lst`, divide each of its numbers by the sum of
all numbers in `lst`.

All the numbers on the returned list should be between 0 and 1, and their sum
should be 1.

For example:

```scheme
> (normalize '(1 2 3))
'(1/6 1/3 1/2)
> (normalize '(10 5 2 2.1 3))
'(0.4524886877828054
  0.2262443438914027
  0.09049773755656108
  0.09502262443438914
  0.13574660633484162)
```

## Variations of map

Two useful variations of `map` are `andmap` and `ormap`. Both take a
**predicate function** (or **predicate** for short) and a list as input. A
predicate takes one input, and returns either `#f` or `#t`.

`andmap` returns `#t` if *all* the elements on the list satisfy the predicate,
and `#f` otherwise. For example:

```scheme
> (andmap even? '(1 2 3 4))
#f
> (andmap even? '(12 2 30 4))
#t
```

Here's an implementation:

```scheme
(define (my-andmap pred? lst)
  (if (empty? lst) #t
      (and (pred? (first lst))
           (my-andmap pred? (rest lst)))))
```

`and` is short-circuited, so if `(pred? (first lst))` evaluates to `#f`, the
recursive call to `my-andmap` is *not* made.

`ormap` returns `#t` if 1, or more, elements on the list evaluate to `#t`, and
`#f` otherwise:

```scheme
> (ormap even? '(1 2 3 4))
#t
> (ormap even? '(1 25 3 41))
#f
```

Here's an implementation:

```scheme
(define (my-ormap pred? lst)
  (if (empty? lst) #f   ;; base case different than my-andmap!
      (or (pred? (first lst))
          (my-ormap pred? (rest lst)))))
```

The built-in implementations of `map`, `andmap`, and `ormap` are a little more
general than what we've done, as they allow for multiple lists. For example:

```scheme
> (map + '(1 2 3) '(4 5 6))
'(5 7 9)
> (andmap (lambda (a b) (> a b)) '(11 6 6) '(4 5 6))
#f
> (andmap (lambda (a b) (> a b)) '(11 6 7) '(4 5 6))
#t
```

## Challenge: same sign

Implement a function called `(same-sign? lst)` the returns `#t` when *all* the
numbers on `lst` have the same *sign* and `#f` otherwise. Assume `lst` is a
list of zero or more numbers. Two numbers `x` and `y` have the same sign if
`(equal? (sgn x) (sgn y))` is true.
 
 For example:
 
```scheme
> (same-sign? '(1 4 2))
#t
> (same-sign? '(-1 -4 -2))
#t
> (same-sign? '(0 0 0 0.0))
#t
> (same-sign? '(1 0 4 2))
#f
> (same-sign? '(-1 -4 2))
#f
> (same-sign? '())
#t
```

## Challenge: checking sum lists

Implement a function called `(is-sum-list? lst)` that returns `#t` if `lst` is
a **sum-list**, and `#f` otherwise.

We define [Racket] expression `e` to be a **sum-list** if:

- `e` is a list

- `e` contains zero, or more, non-empty lists of numbers

- the first element of each list on `e` is the sum of the rest of the elements
  on the list

```scheme
> (is-sum-list? '((3 1 2) (13 4 4 5)))
#t
> (is-sum-list? '())
#t
> (is-sum-list? '((0)))
#t
> (is-sum-list? '((3)))
#f
> (is-sum-list? '((1 2) (3 4 5)))
#f
> (is-sum-list? '(cow bird duck))
#f
> (is-sum-list? 'cheese)
#f
```

## Filtering

The `(filter pred? lst)` function removes items from a list that *don't* match
a given predicate (a function that takes one input, and returns `#t` or `#f`).
It *keeps* all the elements that satisfy it. For example:

```scheme
> (filter odd? '(1 2 3 4 5 6))
'(1 3 5)
> (filter even? '(1 2 3 4 5 6))
'(2 4 6)
> (filter (lambda (lst) (>= (length lst) 2)) '((a b) (5) () (one two three)))
'((a b) (one two three))
```

Here's an implementation:

```scheme
(define (my-filter pred? lst)
  (cond [(empty? lst) '()]
        [(pred? (first lst))
         (cons (first lst) (my-filter pred? (rest lst)))]
        [else
         (my-filter pred? (rest lst))]))
```

As an example of how you might use `filter`, suppose you want to count the
number of symbols in a list. You could do it like this:

```scheme
> (length (filter symbol? '(we have 4 kinds of 2 wheelers)))
5
```

### Challenge: a filter function

In your own words, briefly describe what this function does. What would be a
better name for it than `f`?

```scheme
(define (f lst)
  (if (empty? lst) '()
      (filter (lambda (x) (not (equal? x (first lst))))
              (f (rest lst)))))
```

## Folding

*Folding* applies a 2-argument function to a list in a way that combines all
the elements into a final value. To understand how it works, first look at
these concrete folding functions:

```scheme
(define (sum lst)
  (if (empty? lst) 0
      (+ (first lst) (sum (rest lst)))))

(define (prod lst)
  (if (empty? lst) 1
      (* (first lst) (prod (rest lst)))))

(define (my-length lst)
  (if (empty? lst) 0
      (+ 1 (my-length (rest lst)))))
```

Their implementations all follow the same pattern that we will call
`fold-right`:

```scheme
;;
;; (fold-right f init '(a b c)) calculates this:
;;
;;    (f a (f b (f c init)))
;;
(define (fold-right f init lst)
  (if (empty? lst) 
      init
      (f (first lst) (fold-right f init (rest lst)))))
```

`fold-right` can implement each of the functions from above:

```scheme
> (fold-right + 0 '(1 2 3 4))
10
> (fold-right * 1 '(1 2 3 4))
24
> (fold-right (lambda (next accum) (+ accum 1)) 0 '(1 2 3 4))
4
```

The function `f` passed to `fold-right` takes two inputs, and it is helpful to
call the first input `next` and the second input `accum`. The idea is that
`next` is assigned each value of the list, one at a time, and `accum` is the
*accumulation* of the results so far. How the values are accumulated depends
on `f`.

`fold-right` is quite general. It can, for instance, implement `map`:

```scheme
(define (my-map2 f lst)
  (fold-right (lambda (next accum) (cons (f next) accum))
              '()
              lst))

> (my-map2 list '(one two (three)))
'((one) (two) ((three)))
> (my-map2 sqr '(2 3 5))
'(4 9 25)
```

## Challenge: filtering with fold

Using just one call to `fold-right`, implement the function `(my-filter pred?
lst)` that works just like `(my-filter pred? lst)`.

## Folding consed-out lists

Many programmers find folds tricky to think about at first (and second, and
third, ...). For example, what does `(fold-right cons '() '(a b c d))`
evaluate to?

Here is a perspective that can help with right folds. Any list can be written
in consed-out form, e.g. `'(a b c d)` is:

```scheme
> (cons 'a (cons 'b (cons 'c (cons 'd '()))))
'(a b c d)
```

You can think of `(fold-right f init '(a b c d))` as *replacing* `cons` with
`f` and `'()` with `init` in the consed-out list:

```scheme
(fold-right f init '(a b c d))

;; is the same as

(f 'a (f 'b (f 'c (f 'd init))))
```

For example, `(fold-right + 0 '(1 2 3))` evaluates this expression:

```scheme
(+ 1 (+ 2 (+ 3 0)))
```

With this in mind, we can see that `(fold-right cons '() '(a b c d))`
evaluates to `'(a b c d)`.

`fold-right` is called a *right* fold because it processes the items in the
list in *reverse* order, from the right end to the left end. For example,
`(fold-right + 0 '(1 2 3))` is this: `(+ 1 (+ 2 (+ 3 0))`. In this expression,
first `(+ 3 0)` is calculated, and then `(+ 2 3)` is calculated, and finally
`(+ 1 5)`.

For some expressions, that might not be the order you want, and so the
`fold-left` function applies `f` from left to right. It is usually defined
like this:

```scheme
;; (f (f (f init a) b) c)
(define (fold-left f init lst)
  (if (empty? lst) init
      (fold-left f (f init (first lst)) (rest lst))))
```

A nice feature of `fold-left` is that it is **tail-recursive**, i.e. the last
thing it does is call itself. [Racket] can automatically optimize away the
recursion in a tail-recursive functions and replace it with a loop. This saves
both time and memory. For this reason, in practice, left folds are often
preferable to right folds.

Both left and right folds are built-in functions in [Racket]. `foldr` is the
same as our `fold-right`, but `foldl` is not defined quite the same as
`fold-left` (the `show` function is defined below):

```scheme
> (foldl show 'init '(a b c d))
'(f d (f c (f b (f a init))))
> (fold-left show 'init '(a b c d))
'(f (f (f (f init a) b) c) d)
```

## Folding Example: deep-count re-visited

The function `deep-count` was an example in previous notes:

```scheme
;;
;; Returns the number of numbers on lst, even numbers
;; inside of lists:
;;
(define (deep-count-num lst)       
  (cond [(empty? lst) 0]
        [(list? (first lst))
         (+ (deep-count-num (first lst)) 
            (deep-count-num (rest lst)))]
        [(number? (first lst))
         (+ 1 (deep-count-num (rest lst)))]
        [else
         (deep-count-num (rest lst))]))

> (deep-count-num '(a 9 (b 8 9) ((up (or 16 you)))))
4
```

This implementation is straightforward. Its body is a `cond` that handles all
the possible cases of items on a list (plus the special case of the empty
list).

A more functional way to implement is this is to use `foldr` and `map`. The
idea of this implementation is to replace each item on the list with how many
numbers it contains. There are three kinds of items:

- A number is replaced by a 1.

- A list is replaced by the number of numbers it contains. This is calculated
  using a recursive call.

- Everything else is replaced by a 0.

This gives us a list of numbers whose sum is the number of numbers in the
list. For example:

```scheme
'(a 9 (b 8 9) ((up (or 16 you))))

becomes

'(0 1 2 1)
```

The sum of `'(0 1 2 1)'` is 4, which is the correct answer.

Here's the code:

```scheme
(define (sum lst) (foldr + 0 lst))

(define (deep-count-num lst)       
  (sum
   (map (lambda (x)
          (cond [(list? x) (deep-count-num x)]
                [(number? x) 1]
                [else 0]
                ))
        lst)))
```

Compared to the earlier `deep-count`:

- We don't need to explicitly check for the empty list. `map` handles that for
  us.

- There's only one recursive call to `deep-count`.

- There's no calls to `first` or `rest`. `map` takes care of the accounting
  details of picking the items out of the list.

- To understand it, you need to know what `foldr`, `map`, and `lambda` do.

Which implementation do you prefer?


## Challenge: deep sum

Implement a function `(deep-sum lst)` that works like `deep-count`, except
instead of returning the number of numbers in `lst` it returns their sum. For
example:

```scheme
> (deep-sum '(9 (b 8 9) ((up (or 16 you)))))
42
```

## Folding Example: The Structure of Folds

To better understand how folds work, lets write a function that calculates the
structure of a fold. First, we define this function:

```scheme
(define (show next acc)
  (cons 'f (cons next (list acc))))
  
> (show 'a '(c d))
'(f a (c d))
```

By passing `show` to the various fold functions, we get a list showing the
order of evaluation. For example:

```scheme
> (fold-right show '() '(a b c))
'(f a (f b (f c ())))
> (foldr show '() '(a b c))
'(f a (f b (f c ())))
```

This shows that both our `fold-right`, and the built-in [Racket] `foldr`
evaluate to the same thing. However, `fold-left` and `foldl` are different:

```scheme
> (fold-left show '() '(a b c))
'(f (f (f () a) b) c)
> (foldl show '() '(a b c))
'(f c (f b (f a ())))
```

This last expression suggests that `foldl` could be implemented like this:

```scheme
(define (my-foldl f init lst)
  (fold-right f init (reverse lst)))
```

However, this is *not* how [Racket] implements `foldl`. According to [the
documentation for foldl and foldr](https://docs.racket-lang.org/reference/pairs.html#%28def._%28%28lib._racket%2Fprivate%2Flist..rkt%29._foldl%29%29),
`foldl` uses a *constant* amount of space to process the list, while `foldr`
uses an amount of space proportional to the size of the list. But this
implementation of `my-foldl` calls `fold-right`, meaning it uses space
proportional to the size of the list.

[Scheme]: https://en.wikipedia.org/wiki/Scheme_(programming_language)
[Racket]: https://racket-lang.org/
[LISP]: https://en.wikipedia.org/wiki/Lisp_(programming_language)
[Java]: https://en.wikipedia.org/wiki/Java
