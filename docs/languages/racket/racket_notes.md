# Racket Notes

## Installing Racket

Please use the [DrRacket IDE](https://racket-lang.org/). We won't use the
command-line version.

## Coding Style

Racket supports many different languages, and we will be using the core Racket
language. To ensure this, put this line at the top of all your Racket source
files:

```lisp
#lang racket

;; ... your Racket code ...
```

While Racket/Scheme has loops, we *won't* use them in our discussion of
Racket. We will also *not* be using any mutating Racket functions.

Instead we will focus on **functional programming**, a style of programming
pioneered by LISP. This is good preparation for Haskell (the language we'll
study after Racket), which more strictly forbids loops and mutating functions.


## Racket Lectures

### Lecture 1,2 Racket: Basics

- [Introduction to Racket](racket_intro.md)
- Example functions: [hello_world.rkt](hello_world.rkt),
  [hello_name.rkt](hello_name.rkt)

### Lecture 3 Racket: Lists, Symbols, and Recursion

- [Racket lists and recursion](racket_lists_and_recursion.md)
- An implementation of (x, y) points: [point.rkt](point.rkt)
- Example functions: [count_up.rkt](count_up.rkt),
  [count_down.rkt](count_down.rkt), [numbered_list.rkt](numbered_list.rkt),
  [primes.rkt](primes.rkt), [stats.rkt](stats.rkt), [bits.rkt](bits.rkt),
  [sort.rkt](sort.rkt)

### Lecture 4 Racket: Functional Programming

- [Racket maps, filters, and folds](racket_maps_filters_folds.md)
- [Lecture notes on counting symbols](racketSymbolCountingNotes.md)

### Lecture 5,6 Racket: Higher Order Functions

- [Higher order functions](racket_higher_order_functions.md)

### Lecture 7 Racket: Macros
- [Higher order functions continued](racket_higher_order_functions.md)

### Skipped Topics

The following topics were **not** covered in lectures, and **won't** appear on
quizzes or the final exam:

- [The Racket match form](racket_match_form.md)
- [Racket macros](racket_macros.md)

There are details in the notes that were **not** covered in the lectures, and
so use the lectures as a guide for what topics might appear in quizzes and the
final exam.
