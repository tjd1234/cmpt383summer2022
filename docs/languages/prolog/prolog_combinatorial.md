# Prolog: Examples of Combinatorial Problems

In these notes we'll use to solve various combinatorial problems.


## Pythagorean Triples

Three integers $(a, b, c)$ form a **Pythagorean triple** if $a^2 + b^2 = c^2$.
Here's a Prolog function that tests for Pythagorean triples:

```prolog
is_triple(A, B, C) :- 
  D is C*C - A*A - B*B,  % must use "is" for arithmetic
  D = 0.
```

For example:

```prolog
?- is_triple(3, 4, 5).
true.

?- is_triple(4, 5, 7).
false.
```

We can use `member` to generate solutions like this:

```prolog
solve_triple1(A, B, C) :-
    member(A, [1,2,3,4,5,6,7,8,9,10]),
    member(B, [1,2,3,4,5,6,7,8,9,10]),
    member(C, [1,2,3,4,5,6,7,8,9,10]),
    is_triple(A, B, C).

?- solve_triple1(A, B, C).
A = 3,
B = 4,
C = 5 ;
A = 4,
B = 3,
C = 5 ;
A = 6,
B = 8,
C = 10 ;
A = 8,
B = 6,
C = 10 ;
false.
```

This style of algorithm is called generate and test**. We *generate* a
candidate solution, and then *test* if it is valid.

In this example, four different Pythagorean triples are calculated. However,
(3, 4, 5) and (4, 3, 5) are essentially the same, as are (6, 8, 10) and (8, 6,
10). So lets require that the triples be in order:

```prolog
solve_triple2(A, B, C) :-
    member(A, [1,2,3,4,5,6,7,8,9,10]),
    member(B, [1,2,3,4,5,6,7,8,9,10]),
    A =< B,                            % =< is less than or equal to 
    member(C, [1,2,3,4,5,6,7,8,9,10]),
    B =< C,
    is_triple(A, B, C).

?- solve_triple2(A, B, C).
A = 3,
B = 4,
C = 5 ;
A = 6,
B = 8,
C = 10 ;
false.
```

Of course, a limitation of these two functions is that the values for `A`,
`B`, and `C` are restricted to the numbers from 1 to 10. One way to generalize
that is as follows:

```prolog
solve_triple3(N, A, B, C) :-
    between(1, N, A),
    between(1, N, B),
    A =< B,
    between(1, N, C),
    B =< C,
    is_triple(A, B, C).
```

`between(Lo, Hi, N)` is a standard SWI-Prolog function that can generate
integers from `Lo` to `Hi` (inclusive). For example:

```prolog
?- between(1, 4, N).
N = 1 ;
N = 2 ;
N = 3 ;
N = 4.
```

Many programmers are impressed by the brevity and clarity of these sorts of
Prolog programs. But it's worth noting that we can implement generate and test
straightforwardly in other languages. For instance, in Python we could write
this:

```python
def solve_triple(n):            # Python
    for a in xrange(1, n + 1):
        for b in xrange(1, n + 1):
            if a < b:
                for c in xrange(1, n + 1):
                    if b < c:
                        if is_triple(a, b, c):
                            print(a, b, c)
```

While backtracking is not a built-in part of Python, the flow of control jumps
around in the same way due to how and when the for-loops terminate. Note that
when the program is at the line `if is_triple(a, b, c)`, then there are four
places the flow of control could jump to next: the `print` statement in its
body, or back to one of the three earlier for-loops.

Go is similar:

```go
func solve_triple(n int) {         // Go
    for a := 1; a <= n; a++ {
        for b := 1; b <= n; b++ {
            if a < b {
                for c := 1; c <= n; c++ {
                    if b < c {
                        if a*a + b*b == c*c {
                            fmt.Println(a, b, c)
                        }
                    }
                }
            }
        }
    }
}
```

If you remove all the indentation and squint, it looks a *little* closer to
Prolog version:

```go
func solve_triple(n int) {     // Go
    for a := 1; a <= n; a++ {
    for b := 1; b <= n; b++ {
    if a < b {
    for c := 1; c <= n; c++ {
    if b < c {
        if a*a + b*b == c*c {
            fmt.Println(a, b, c)
}}}}}}}
```

All of these examples do the simplest form of backtracking. For example, when
they've looped through all values of `c`, they jump up to the `b` for-loop to
get the next value of `b`. It's never the case that they jump from `c` to `a`.
This is a limitation, since in some problems it might be (vastly) more
efficient to backtrack to some other value.

The non-Prolog functions are not quite the same as the Prolog one because
Prolog lets you stop after you get any solution, while the other functions run
to completion. However, you could simulate Prolog using generators in Python,
or goroutines in Go.


## Generating Bit Strings

Suppose we want to generate a list of all bit strings of length n. One way to
do this relies on this tiny knowledge base:

```prolog
bit(0).
bit(1).
```

This says that 0 and 1 are bits.

To generate all bit strings of length 3, we can do this:

```prolog
?- bit(A), bit(B), bit(C), X=[A, B, C].
A = B, B = C, C = 0,
X = [0, 0, 0] ;
A = B, B = 0,
C = 1,
X = [0, 0, 1] ;
A = C, C = 0,
B = 1,
X = [0, 1, 0] ;
A = 0,
B = C, C = 1,
X = [0, 1, 1] ;
A = 1,
B = C, C = 0,
X = [1, 0, 0] ;
A = C, C = 1,
B = 0,
X = [1, 0, 1] ;
A = B, B = 1,
C = 0,
X = [1, 1, 0] ;
A = B, B = C, C = 1,
X = [1, 1, 1].
```

Lets trace this to understand how it works. When the query begins, `A` is
assigned the value 0, `B` is assigned the value 0, and then `C` is assigned
the value 0. This is a valid assignment, and so we have the first bit string:
`[0, 0, 0]`. When the user enter `;`, Prolog backtracks to `C`, which means it
unassigns `C` and then tries to find another value that satisfies `C`. It
does: it finds that `C` could be 1. And so we have the second bit string: `[0,
0, 1]`. Prolog backtracks to `C`, unassigns it, and discovers that there are
no other values that it can assign to `C`. So it unassigns `C` and backtracks
to `B`, and then unassigns `B`. It tries to find a different assignment to
`B`, and ends up assigning 1 to `B`. Now it tries to find a value for `C`. The
first value it finds is `0`, and so `C` gets assigned that. This gives the
third bit string: `[0, 1, 0]`. Backtracking continues in this fashion until
all bit strings have been generated.

While this is a simple way to generate bit strings in Prolog, it's more
convenient to have a function that takes the number of bits `N` as input:

```prolog
?- nbits(3, Bits).
Bits = [0, 0, 0] ;
Bits = [0, 0, 1] ;
Bits = [0, 1, 0] ;
Bits = [0, 1, 1] ;
Bits = [1, 0, 0] ;
Bits = [1, 0, 1] ;
Bits = [1, 1, 0] ;
Bits = [1, 1, 1] ;
false
```

Here is an implementation of `nbits`:

```prolog
nbits(1, [B]) :-     % base case
  bit(B).
nbits(N, [B|Bs]) :-  % recursive case
  N > 1, 
  bit(B), 
  N1 is N - 1, 
  nbits(N1, Bs).
```

While short and simple, this can be a tricky function to write from scratch.
Every line must be written carefully.


## Four-by-four Sudoku

[Sudoku](http://en.wikipedia.org/wiki/Sudoku) puzzles are a popular number
puzzle. Typically, they are played on a 9-by-9 grid of cells, and the goal
is to put the numbers 1 to 9 into each cell such that:

- Each row is a permutation of 1 to 9.

- Each column is a permutation of 1 to 9.

- Each of the nine 3-by-3 sub-squares is a permutation of 1 to 9.

Sudoku puzzles start with some numbers already filled in, and then, through
logical deduction, you try to fill in all the other numbers. It's possible
that some puzzles might have more than one solution, or no solution at all,
but those are usually frowned upon by human solvers.

A four-by-four Sudoku puzzle is the same idea, except it is played on a 4-by-4
grid instead of a 9-by-9, e.g.:

```
A B  C D
E F  G H

I J  K L
M N  O P
```

Each row and column must be a permutation of the numbers 1, 2, 3, 4. Also, the
four 2-by-2 sub-squares must also be permutations of 1, 2, 3,4.

Here's how we could solve this puzzle in Prolog:

```prolog
solution(A, B, C, D,
         E, F, G, H,
         I, J, K, L,
         M, N, O, P) :-
    % row constraints
    permutation([1, 2, 3, 4], [A, B, C, D]),
    permutation([1, 2, 3, 4], [E, F, G, H]),
    permutation([1, 2, 3, 4], [I, J, K, L]),
    permutation([1, 2, 3, 4], [M, N, O, P]),

    % column constraints
    permutation([1, 2, 3, 4], [A, E, I, M]),
    permutation([1, 2, 3, 4], [B, F, J, N]),
    permutation([1, 2, 3, 4], [C, G, K, O]),
    permutation([1, 2, 3, 4], [D, H, L, P]),

    % sub-square constraints
    permutation([1, 2, 3, 4], [A, B, E, F]),  % upper left
    permutation([1, 2, 3, 4], [C, D, G, H]),  % upper right
    permutation([1, 2, 3, 4], [I, J, M, N]),  % lower left
    permutation([1, 2, 3, 4], [K, L, O, P]).  % lower right
```

The built-in function `permutation` generates permutations of the members of
a list, e.g.:

```prolog
?- permutation([1, 2, 3], Perm).
Perm = [1, 2, 3] ;
Perm = [1, 3, 2] ;
Perm = [2, 1, 3] ;
Perm = [2, 3, 1] ;
Perm = [3, 1, 2] ;
Perm = [3, 2, 1] ;
false.
```

We can make the output nicer like this:

```prolog
sudoku(A, B, C, D,
       E, F, G, H,
       I, J, K, L,
       M, N, O, P) :-
    solution(A, B, C, D,
             E, F, G, H,
             I, J, K, L,
             M, N, O, P),
    nl, 
    write('A solution to this puzzle is'), 
    nl,
    printrow(A, B, C, D), 
    printrow(E, F, G, H),
    printrow(I, J, K, L), 
    printrow(M, N, O, P).
    
printrow(P, Q, R, S) :- 
    write(' '), write(P), write(' '), write(Q),
    write(' '), write(R), write(' '), write(S), nl.
```

To run it, give it a starting 4-by-4 Sudoku grid (recall that `_` is the
anonymous variable):

```prolog
    ?- sudoku(
    |    1, 4, _, _,
    |    _, _, 4, _,
    |    2, _, _, _,
    |    _, _, _, _
    |    ).

    A solution to this puzzle is
     1 4 2 3
     3 2 4 1
     2 1 3 4
     4 3 1 2
    true ;

    A solution to this puzzle is
     1 4 2 3
     3 2 4 1
     2 3 1 4
     4 1 3 2
    true ;

    A solution to this puzzle is
     1 4 3 2
     3 2 4 1
     2 3 1 4
     4 1 2 3
    true ;
    false.
```

Solving the 4-by-4 Sudoku puzzle is so straightforward that it is natural to
try the same approach with the full 9-by-9 version. However, while it will
work in principle, there are so many possibilities to search through in the
9-by-9 version that the program **won't** finish in a reasonable amount of
time.

To see why, first notice that the program does not use any knowledge specific
to Sudoku. It solves the puzzle by pure brute force: it generates all possible
permutations and tests which ones satisfy the constraints.

We can get a rough estimate of the number of different 9-by-9 Sudoku boards as
follows. Each row has $9! = 362880$ possible permutations, and since there
are 9 rows there are $9!^9 \approx 1.1 \times 10^{51}$ possibilities for
this generate-and-test program to try.

Assuming we could generate a *trillion* ($10^{12}$) permutations per second,
it would take on the order of $10^{39}$ seconds to solve, which is about $3
\times 10^{29}$ *centuries*.

People can obviously solve 9-by-9 puzzles much more quickly than that. They do
it by using knowledge specific to Sudoku to more efficiently figure out
numbers. Our program has no knowledge about Sudoku other than what counts as a
solution. With more work, it is possible to add extra knowledge to make it
faster, but we don't do that here.


## The SEND MORE MONEY Puzzle

The SEND MORE MONEY puzzle is a classic [cryptarithmetic
puzzle](https://en.wikipedia.org/wiki/Verbal_arithmetic) that can be solved
neatly in Prolog. The puzzle asks you to replace letters with digits so that
this equation true: SEND + MORE = MONEY. Each letter stands for a single
digit, 0 to 9, and different letters are different digits (so, for example, S
and E can't be the same). Also, S and M can't be 0 because numbers don't start
with 0.

There are a couple of ways to solve this problem in Prolog. One way is like
this:

```prolog
alpha1(S, E, N, D, M, O, R, Y], Send, More, Money) :-
    between(1, 9, S),
    between(0, 9, E), S \= E,
    between(0, 9, N), \+ member(N, [S,E]),       % \+ means "not"
    between(0, 9, D), \+ member(D, [S,E,N]),
    between(1, 9, M), \+ member(M, [S,E,N,D]),
    between(0, 9, O), \+ member(O, [S,E,N,D,M]),
    between(0, 9, R), \+ member(R, [S,E,N,D,M,O]),
    between(0, 9, Y), \+ member(Y, [S,E,N,D,M,O,R]),
    Send  is           S*1000 + E*100 + N*10 + D,
    More  is           M*1000 + O*100 + R*10 + E,
    Money is M*10000 + O*1000 + N*100 + E*10 + Y,
    Money is Send + More.
```

This takes a few seconds to run on a typical desktop computer, and it finds
the one unique solution:

```prolog
?- alpha1([S, E, N, D, M, O, R, Y], Send, More, Money).
S = 9,
E = 5,
N = 6,
D = 7,
M = 1,
O = 0,
R = 8,
Y = 2,
Send = 9567,
More = 1085,
Money = 10652 ;
false.
```

Importantly, as soon as values are assigned to variables, we enforce the
not-equal constraints so that failure will happen as soon as possible. `\+`
means "not", and in this case tells when a value is not member of a list. The
predicate would run much more slowly if you put all the `\=` constraints in
one group at the bottom of the function.

An even more efficient approach is to mimic digit by digit addition using
carries, the way people do it:

```prolog
alpha2(S, E, N, D, M, O, R, Y, [S, E, N, D, M, O, R, E, M, O, N, E, Y]) :-
    between(0, 9, D), between(0, 9, E),
    Y is (D + E) mod 10,
    C1 is (D + E) div 10,
    between(0, 9, N), between(0, 9, R),
    E is (N + R + C1) mod 10,
    C2 is (N + R + C1) div 10,
    between(0, 9, O),
    N is (E + O + C2) mod 10,
    C3 is (E + O + C2) div 10,
    between(0, 9, S), between(1, 9, M),
    O is (S + M + C3) mod 10,
    M is (S + M + C3) div 10,
    all_diff([S, E, N, D, M, O, R, Y]).
```

Again, we interleave constraints with calls to `between` for efficiency. The
variables `C1`, `C2`, and `C3` are the *carry* values of the additions of the
individual digits.

The `all_diff` function succeeds just when all the elements on the list passed
to it are different, e.g.:

```prolog
?- all_diff([6, 8, 4, 11, 1, 5]).
true.

?- all_diff([6, 8, 4, 11, 1, 4]).
false.
```

Here's an implementation:

```prolog
all_diff([]).
all_diff([X|Xs]) :- not(member(X,Xs)), all_diff(Xs).
```

What's nice about this general approach is that the program is essentially
just a list of the constraints on the variables. We then let Prolog do the
work of finding satisfying values.

While good in theory, in practice this is usually too slow for problems where
the range of the variables is big (the range of these variables is only 0 to
9). Bigger problems like this typically require a lot of extra
problem-specific knowledge to make them run efficiently.


## Map Coloring

[Map coloring](https://en.wikipedia.org/wiki/Map_coloring) is a classic
computational problem. By a map is meant a
[graph](http://en.wikipedia.org/wiki/Graph_theory), i.e. a set of vertices
connected by edges.

In a map coloring problem, the task is to assign a color to each vertex such
that no two edges connected by an edge share the same color. In general, this
is a computationally challenging problem, i.e. determining whether or not a
graph can be 3-colored is [NP-complete](http://en.wikipedia.org/wiki/NP-
complete>).

One way to represent a map 3-coloring problem in Prolog is as follows:

```prolog
%
% allowable colors
%
color(red).
color(green).
color(blue).

%
% vertices A and B are neighbors if they are adjacent 
% and have different colors
%
neighbor(A, B) :- 
    color(A), 
    color(B), 
    A \= B.

%
% A, B, C, D are the cities
% neighbor(X, Y) means city X is next to city Y
%
map1([A, B, C, D]) :-
    neighbor(A, B),
    neighbor(B, C),
    neighbor(C, A),
    neighbor(D, A),
    neighbor(D, B),
    neighbor(D, C).

map2([A, B, C, D, E]) :-
    neighbor(A, B),
    neighbor(B, C),
    neighbor(C, D),
    neighbor(D, E),
    neighbor(E, A).
```

While this is a nice example of a Prolog program, it is *not* the most
efficient way to solve a coloring problem. For large maps, it is far too
inefficient: if Prolog did smarter backtracking, or used heuristics specific
to map coloring, it could run much quicker.


## Concluding Thoughts

These examples suggest Prolog is a good way to *represent* many combinatorial
problems, but not necessarily an efficient way to *solve* them. They all rely
on Prolog's depth-first backtracking, which by itself is too slow for all but
the smallest examples.

To make faster solvers, you typically need to add lots of problem-specific
knowledge, and use data structures and algorithms tuned to the problem. That's
usually easier to do in other languages than in Prolog.

You can think of the trade-off like this: do you want a problem solver that
can solve lots of different problems *slowly*, or a single problem quickly?
