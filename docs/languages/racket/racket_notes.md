# Racket Notes

## Installing Racket

Please use the [DrRacket IDE](https://racket-lang.org/). We won't use the
command-line version.

## Coding Style

Racket supports many different languages, and we will be using the core Raket
language. To ensure this, put this line at the top of all your Racket source
files:

```lisp
#lang racket

;; ... your Racket code ...
```

While Racket/Scheme has loops, we *won't* them in our discussion of Racket. We
will also *not* be using any mutating Racket functions.

Instead we will focus on functional programming, a style of programming
pioneered by LISP. This is good preparation for Haskell (the language we'll
study after Racket), which does not allow loops or mutating functions.


## Racket Lectures

### Lecture 1,2 Racket: Basics

- [Introduction to Racket](racket_intro.md)
- [hello_world.rkt](hello_world.rkt)
- [hello_name.rkt](hello_name.rkt)

### Lecture 3 Racket: Lists, Symbols, and Recursion

- [Racket lists and recursion](racket_lists_and_recursion.md)
- [count_up.rkt](count_up.rkt)
- [count_down.rkt](count_down.rkt)
- [numbered_list.rkt](numbered_list.rkt)
- [primes.rkt](primes.rkt)
- [stats.rkt](stats.rkt)
- [bits.rkt](bits.rkt)
- [sort.rkt](sort.rkt)

### Lecture 4 Racket: Functional Programming

- [Racket maps, filters, and folds](racket_maps_filters_folds.md)

### Lecture 5,6 Racket: Higher Order Functions

- [Higher order functions](racket_higher_order_functions.md)
- [The Racket match form](racket_match_form.md)

### Lecture 7 Racket: Macros
- [Racket macros](racket_macros.md)
