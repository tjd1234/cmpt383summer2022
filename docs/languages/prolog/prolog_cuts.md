# Prolog: Introduction to Cuts

This `min` function has a problem:

```prolog
min(X, Y, X) :- X =< Y.   % clause 1
min(X, Y, Y) :- X > Y.    % clause 2
```

For instance:

```prolog
?- min(1, 2, M).
M = 1 ;
false.
```

But what we really want is for it to work like this:

```prolog
?- min(1, 2, M).
M = 1.
```

The problem is that it returns `false` after it succeeds with `M = 1`. The
cause of this problem is that `min(1, 2, M)` satisfies clause 1, and then, if
the user types `;`, it keeps going and tries to satisfy clause 2, which fails
and produces the `false`.

To fix this, we need some way to tell Prolog to stop, to *not* keep going
after it succeeds with the first clause. The **cut operator**, `!`, does
exactly that. When Prolog encounters a `!`, it will *not* search for further
ways to satisfy the query.

So we can rewrite `min` like this:

```prolog
min(X, Y, X) :- X =< Y, !.   % clause 1
min(X, Y, Y) :- X > Y.       % clause 2
```

Now it works as desired:

```prolog
?- min(1, 2, M).
M = 1.
```

The `min_list` function has the same problem. Even when using the version of
`min` with the `!`, it still does not work as we would like:

```prolog
min_list([X], X).               % base case
min_list([Head|Tail], Min) :-   % recursive case
    min_list(Tail, Tmin), 
    min(Head, Tmin, Min).
```

For instance:

```prolog
?- min_list([4, 3, 5], M).
M = 3 ;
false.
```

We can fix this by adding a `!` to the end of the recursive case:

```prolog
min_list([X], X).               % base case
min_list([Head|Tail], Min) :-   % recursive case
    min_list(Tail, Tmin), 
    min(Head, Tmin, Min),
    !.
```

Now it does this:

```prolog
?- min_list([4, 3, 5], M).
M = 3.
```

Using cuts takes some getting used to, so lets see another example. The
`neg(Nums, Negs)` function assigns to `Negs` all the numbers in `Nums` that
are less than 0:

```prolog
negs([], []).              % clause 1
negs([N|Ns], [N|Rest]) :-  % clause 2
  N < 0,
  negs(Ns, Rest).
negs([_|Ns], Rest) :-      % clause 3
  negs(Ns, Rest).
```

It has a problem:

```prolog
?- negs([-3], Negs).
Negs = [-3] ;
Negs = [].
```

As you can see, it returns two values for `Negs` because after it succeeds
with `Negs = [-3]`, it then keeps searching and also satisfies the 3rd clause.

One way to fix it is to add a cut, `!`, in the second clause:

```prolog
negs([], []).              % clause 1
negs([N|Ns], [N|Rest]) :-  % clause 2
  N < 0,
  negs(Ns, Rest),
  !.               % cut added here
negs([_|Ns], Rest) :-      % clause 3
  negs(Ns, Rest).
```

The cut tells Prolog to *not* continue searching after clause 2 is satisfied.
No cut is needed in the first clause because `[]` never matches with a pattern
like `[H|T]`. The third clause doesn't need a cut because there are no more
clauses after it.


## Removing Items From a List

Suppose you want to remove all occurrences of an element `X` from a list. You
could do it like this:

```prolog
remove_all(_, [], []).                          % base case
remove_all(X, [X|Rest], Result) :-              % recursive case
    remove_all(X, Rest, Result),
    !.
remove_all(X, [First|Rest], [First|Result]) :-  % recursive case
    X \= First,                                 % \= means "doesn't unify"
    remove_all(X, Rest, Result).
```

Note the use of the cut, `!`, to stop the search after it succeeds in the
first recursive case.

Here's how it works:

```prolog
?- remove_all(5, [3, 4, 5, 6, 5], X).
X = [3, 4, 6].
```
