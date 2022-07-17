# Assignment 5: Prolog

Answer each of the following questions using SWI-Prolog on Linux. Please
follow these rules:

- Write all the code yourself.
- Don't import any extra libraries.
- Only use Prolog features you understand and could explain to the marker. 

Write any helper functions you think are useful.

For these questions we are only concerned with the *first* solution that's
returned. You do not need to worry about extra solutions, or using the cut
operator `!`.

Also, you can assume that all obvious pre-conditions for a function are true,
and so you don't need to check if function inputs are valid.

When you're done, please put all your functions into a single file named
`a5.pl` and submit it on Canvas.


## Question 1: fill

(2 marks) Implement `fill(N, X, Lst)` that works as follows:

```prolog
?- fill(3, a, Lst).
Lst = [a, a, a]

?- fill(4, [a,b], Lst).
Lst = [[a, b], [a, b], [a, b], [a, b]]
```

In other words, `fill(N, X, Lst)` binds to `Lst` a new list
consisting of `N` copies of `X`.

You can assume `N` is 0 or greater.

**Important**: Implement this using recursion and basic Prolog features.
*Don't* just call standard predicates that do the work for you.


## Question 2: numlist

(2 marks) Prolog has a function called `numlist(Lo, Hi, Result)` that creates
a list of numbers from `Lo` to `Hi` (including `Hi`). For example:

```prolog
?- numlist(1,5,L).
L = [1, 2, 3, 4, 5]
```

Implement your own version called `numlist2(Lo, Hi, Result)`. Of course, don't
use `numlist` anywhere!

[Here's some documentation for numlist, and other useful list functions]
(http://www.swi-prolog.org/pldoc/man?section=lists).


## Question 3: min and max

(2 marks) Implement `minmax(Lst, Min, Max)`, that returns the smallest number
on a list, and also the biggest number. Assume `Lst` is a list of numbers, and
if `Lst` is empty then the predicate evaluates to `false`.

For example:

```prolog
?- minmax([2,1,8,0,4], Min, Max).
Min = 0,
Max = 8 ;
false.

?- minmax([], Min, Max).
false.
```

**Important**: *Don't* use standard Prolog predicates like `min_list`,
`max_list`, `min_member`, or `max_member` anywhere in your solution to this
question. If you do, you'll get 0 for this question!


## Question 4: negpos

(2 marks) Implement `negpos(L, Neg, NonNeg)`, which partitions a list `L` of
numbers into negatives and non-negatives. For example:

```prolog
?- negpos([1,0,5,2,-3,2,-4], A, B).
A = [-4, -3],
B = [0, 1, 2, 2, 5] ;
```

Both `Neg` and `NonNeg` should be returned in ascending sorted order. You can
use SWI-Prolog's standard `msort(Lst, SortedLst)` predicate for sorting, e.g.:

```prolog
?- msort([9,2,2,4,1], Lst).
Lst = [1, 2, 2, 4, 9].
```

## Question 5: cryptarithmetic

(3 marks) Write a Prolog predicate all `alpha(Lst, Tim, Bit, Yumyum)` that
returns a list of solutions to this *multiplication* cryptarithmetic puzzle:

```
   TIM
 x BIT   Note that it's times, not plus!
------
YUMYUM
```

The rules are for a cryptarithmetic puzzle are:

- Each different letter stands for a different digit from 0 to 9.
- A number cannot start with a 0, and so `T`, `B`, and `Y` can't be 0.

For example:

```
?- alpha([T,I,M,B,Y,U], Tim, Bit, Yumyum).
... prints values for T,I,M,B,Y,U, Tim, Bit, Yumyum ...
```

In your predicate please use the exact same ordering of letters as shown.

There could 0, 1, or more solutions. Your predicate should be able to find all
solutions.

Your program should take less than 1 second to find a solution on an modern
desktop computer. You can use the Prolog `time` predicate to print the running
time:

```
?- time(alpha([T,I,M,B,Y,U], Tim, Bit, Yumyum)).
... prints run time ...
... prints values for T,I,M,B,Y,U, Tim, Bit, Yumyum ...
```

## Question 6: magic square

(5 marks) A **3x3 magic square** is a grid of 9 numbers where each row and
column add up to the same number (known as the *magic number*). The sum of the
two diagonals does *not* matter.

For example, this magic square has magic number 15:

```
1 5 9
6 7 2
8 3 4
```

Implement `magic(L9, Result, N)` that takes a list `L9` of 9 numbers as input,
and calculates a *permutation* of `L9` that is magic. For example:

```prolog
?- magic([1,2,3,4,5,6,7,8,9], Result, N).
Result = [1, 5, 9, 6, 7, 2, 8, 3, 4],
N = 15
```

`N` is the magic number, i.e. the number that all rows and columns sum to.

`Result` is in [row-major order](https://en.wikipedia.org/wiki/Row-_and_column-major_order), i.e. it corresponds to this square:

```
1 5 9
6 7 2
8 3 4
```

Here's another example:

```prolog
?- magic([2,4,6,8,10,12,14,16,18], Result. N).
Result = [2, 10, 18, 12, 14, 4, 16, 6, 8],
N = 30
```

This is the square (it's magic number is 30):

```
 2 10 18
12 14  4
16  6  8
```

If `L9` does not have exactly 9 elements, then `magic` should return `false`.

Depending upon the numbers in `L9`, there could be 0 or more solutions. When
there's no solution, your `magic` function should only take a few seconds to
run.
