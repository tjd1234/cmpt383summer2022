# Racket Lecture Notes

## Symbol Counting Example

`(symbol? x)` returns `#t` if `x` is a symbol, and `#f` otherwise.

Write a function called `(count-symbols lst)` that returns the number of
symbols that occur at the top-level of `lst`. For example:

- `(count-symbols '(a b c) )` returns 3
- `(count-symbols '(a 2 () c) )` returns 2
- `(count-symbols '(2 (a b) c (d)) )` returns 1


### Solution 1: Recursive Function

Recursive Racket functions:

```scheme
(define (count-sym1 lst)
  (cond
    [(empty? lst) 
     0]
    [(symbol? (first lst)) 
     (+ 1 (count-sym1 (rest lst)))]
    [else 
     (count-sym1 (rest lst))]))
```

Alternatively, we could write it like this:

```scheme
(define (count-sym2 lst)
  (if (empty? lst)
      0 
      (+ (if (symbol? (first lst)) 1 0)
         (count-sym2 (rest lst)))))
```

Pros:
- The code is fairly clear and explicit.
- The implementation follows the same basic style as it would in most other
  languages, e.g. it's an if-statement with recursion.

Cons:
- It uses recursion, which many programmers don't like.
- There's a lot of code, in particular a lot of parentheses. The code syntax
  is *noisy*.


### Solution 2: Using filter

`(filter pred? lst)` is a built-in Racket functions that returns a new list
containing only the elements of `lst` that satisfy `pred?`. In other words,
`filter` *keeps* all the items on `lst` that satisfy `pred?`.

`pred?` is short for *predicate*. A predicate is a function that takes one
input and returns either `#t` or `#f`.

Examples of filtering:

```scheme
> (filter even? '(1 2 3 4 5))
'(2 4)
> (filter odd? '(1 2 3 4 5))
'(1 3 5)
> (filter list? '(1 2 3 4 5))
'()
> (filter list? '(1 (2 3) (4) 5))
'((2 3) (4))
> (filter symbol? '(1 two 3 four))
'(two four)
```

The final examples gives a good hint about how we can count symbols in a list
using `filter`. We can count symbols like this:

```scheme
(define (count-symbols lst)
  (length (filter symbol? lst)))
```

This version is dramatically shorter. As long as you know how `filter` and
`length` work, it's much more readable. Indeed, you could probably figure out
this solution in your head without writing down code.

How does `(filter pred? lst)` work? We can implement it recursively like this:

```scheme
(define (myfilter pred? lst)
  (cond [(empty? lst)
         '()]
        [(pred? (first lst))
         (cons (first lst)
               (myfilter pred? (rest lst)))]
        [else
         (myfilter pred? (rest lst))]))
```

Now you can replace `filter` with `myfilter` in `count-sym3`, and it will work
the same.

Pros:
- The code is very short and simple. It's easy to read, and easy to believe
  it's correct.
- It uses built-in functions that you don't need to write yourself.

Cons:
- You need to know that `filter` exists, and how it works.
- Creating a brand new list just so you can calculate its length is not as
  efficient as if you "count as you go".


## Deep Counting Symbols

`(count-sym lst)` returns the number of symbols that occur at the *top-level*
of `lst`. For example, `(count-symbols '(a (b c) d))` returns 2, because `'a`
and `'d` are the only top-level symbols. `'b` and `'c` and are inside a list
and so are *not* top-level symbols, and they are not counted.

But suppose you *do* want to count symbols that occur *anywhere* in the list.
In other words, we'd like to write a function `(deep-count-symbols lst)` that
even counts symbols that occur within lists:

```
> (deep-count-sym '(a (b c) d))
4
> (deep-count-sym '(1 2 (a (b 4 ((c)))) d))
4
```

**Question** How can we use `count-symbols` to help us write
`deep-count-symbols`.

Consider `'(a (b c) d)`. If we could get rid of the internal list brackets
we'd be left with `(a b c d)`, and we could use `count-symbols` to get the
answer.

Racket has a built-in function that does what we want. `(flatten lst)` removes
all the lists from `lst`:

```scheme
> (flatten '(a (b c) d))
'(a b c d)
> (flatten '(((a)) (b (c)) d e))
'(a b c d e)
```

Now we can write `deep-count` like this:

```scheme
(define (deep-count-symbols lst)
  (count-symbols (flatten lst)))
```

It works!

But what if Racket didn't have a built `flatten` function. How could we write
it ourselves?

So how does a flattening a list work? You could imagine going through the
elements of the list one at a time. If the item is *not* a list, then is
unchanged. If it *is* a list, then we can recursively flatten that list,
recursively flatten the *rest* of the top-level list, and then append the two
together.

```scheme
> (my-flatten '((())))
'()
> (my-flatten '(1 2 3 4))
'(1 2 3 4)
> (my-flatten '(1 (2 3 4)))
'(1 2 3 4)
> (my-flatten '((1 (2 3 4))))
'(1 2 3 4)
> (my-flatten '((1 (2 (3 4)))))
'(1 2 3 4)
```

## Discussion

This examples shows how functional programming can be used to solve problems
in a way that is both efficient in terms of programmer time (it's quick and
easy code for the programmer to write), and also very readable and easy to
understand.

On the down side, this code is not as efficient as it could be. For some
applications it might be fast enough, but if you need better performance then
there are improvements you could make to speed things up. 

In general, functional programming can make it quick to construct a slow
program, but it can take more time (maybe more than a non-functional
language!) to construct a more efficient version. In practice, quick-but-slow
solutions may be fine for prototyping, or in cases where efficiency of the
code is not the overriding concern.
