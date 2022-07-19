# Introduction to Prolog


## What is Prolog?

Prolog is a [logic programming
language](https://en.wikipedia.org/wiki/Logic_programming) developed in the
early 1970s. It aims to be a
[declarative programming language](https://en.wikipedia.org/wiki/Declarative_programming), i.e. Prolog
programs often say *what* they will do without specifying exactly *how*
they will do it. To do this, Prolog has a built-in backtracking search that
can solve pretty much any problem if you have enough time (naive Prolog
programs can be quite slow!). 

> Other examples of declarative languages are
> [SQL](https://en.wikipedia.org/wiki/SQL), [regular
> expressions](https://en.wikipedia.org/wiki/Regular_expression), and
> [HTML](https://en.wikipedia.org/wiki/HTML).

Some common applications of Prolog are:

- **Grammars for natural language processing**. For instance, [the IBM Watson
  system used Prolog](https://www.cs.nmsu.edu/ALP/2011/03/natural-language-processing-with-prolog-in-the-ibm-watson-system/)
  (among other languages) to answer questions posed in natural language.

- **Symbolic Artificial Intelligence**. Prolog has good support for logic, and
  symbolic computing. For instance, is a good choice for writing a
  theorem-prover to help with your math homework, or implementing an [expert
  system](https://en.wikipedia.org/wiki/Expert_system).

- **In-memory databases**. Prolog can create and query complex databases
  inside of other languages. For instance, [Datomic](https://www.datomic.com/)
  is a database that uses the Prolog-like language
  [datalog](https://en.wikipedia.org/wiki/Datalog) to write queries.

- Problems that require some sort of backtracking, such as scheduling or
  time-tabling problem from
  [logistics](https://en.wikipedia.org/wiki/Logistics), can often be nicely
  represented and solved in Prolog.

While Prolog can be used as a general-purpose programming language, it's not
very popular for that since its syntax and semantics is unfamiliar to most
programmers, and you need to learn a whole new bag of tricks to write
efficient programs (even for some simple programming problems).


## Relations and Computation

A helpful way to think about Prolog is that it is about **relational
programming**. In mathematics, a **relation** is set of tuples. If A and B are
sets, then a relation is any subset of their cross product:

$$A \times B = \{ (a, b) : a \in A, b \in B \}$$

For example, if A={2, 3, 6} and B={2, 4}, then A x B = {(2,2), (2,4), (3,2),
(3,4), (6,2), (6,4)}. Every subset A x B is a relation.

More generally, if A_1, A_2, ... , A_n are all non-empty sets, then a relation
on them is any *subset* of this cross-product:

$$A_1 \times A_2 \times \ldots \times A_n = \{ (a_1,a_2,\ldots,a_n) : a_1\in
A_1, a_2\in A_2, \ldots, a_n \in A_n \}$$

(a_1, a_2, ... , a_n) is an n-tuple, i.e. an ordered collection of n different
values. A relation is just a set of 0 or more n-tuples

For example, suppose the set A = {18, 19, 20}, and the set P = {yi, veronica,
pat, gary}. We could then define the *age* relation like this: {(veronica,
19), (pat, 19), (yi, 18)}. This relation is a set of pairs, where the first
element is from A, and the second element is from P. Another relation would be
{(yi, 19), (yi,20), (yi,18)}. There is no requirement that all values from A
or P be present.

Relations are a provocative way of thinking about computation. For example,
consider this relation on A x A x B, where A = {1, 2, 3} and B = {1, 2, 3, 4,
5, 6}:

```
x y z
=====
1 1 2
1 2 3
1 3 4     the relation x + y = z
2 1 3
2 2 4
2 3 5
3 1 4
3 2 5
3 3 6
```

The relation consists of nine 3-tuples, and we've written it like a database
table. It represents all values of x, y, z, in the range 1 to 6, that satisfy
the equation x + y = z.

Now we can answer some computational questions by searching this table:

- **Is $2 + 1 = 3$?** To answer this, we *search* the table to see if it has
  the triple $(2,1,3)$. It's there, and so we know that $2 + 1 = 3$ is true.
  Similarly, we know that $2 + 2 = 1$ is *not* true because the triple
  $(2,2,1)$ is not anywhere in the table.

- **What is $x$ in the equation $x + 1 = 4$?** To solve this, we have to find
  a triple that matches $(x,1,4)$. By searching the table, we can see that
  there is only one such triple, $(3,1,4)$, and so the only solution is $x=4$.

- **What values of $x$ and $y$ satisfy $x + y = 4$?** Here, we need to search
  for triples that look like $(x,y,4)$. There are two such triples in the
  table: $(1,3,4)$ and $(3,1,4)$, and so the equation has two different
  solutions: $x=1$ and $y=3$, or $x=3$ and $y=1$.

The interesting thing here is that we have converted the problem of solving
equations into *database queries*, i.e. looking up tuples in a table. We will
come back to this way of thinking about computation when we look we start to
define Prolog predicates.


## Structure of a Prolog Program

> **Note** Much of what follows is based on the book [Programming in Prolog,
> by Clocksin and
> Mellish](https://www.amazon.ca/Programming-Prolog-Using-ISO-Standard/dp/3540006788).

Prolog programs consist of these main elements:

- **Facts** about values and their relationships. For example, *kia* and
  *jody* are values representing people, and "kia is jody's mother" is a fact
  that relates them.

  A value could be anything, e.g. a number, a string, a list, a function, etc.
  Lowercase identifiers like *kia* and *jody* are Prolog symbols.

  It common to refer to Prolog values as *objects*, but please keep in mind
  these are **not** objects in the sense of object-oriented programming.

- **Rules** about objects and their relationships. For example, you might have
  the rule "if X and Y have the same parents, then they're siblings".

- **Questions** that can be asked about objects and their relationships. These
  are like *queries* in a database system. For example, you might ask "Who are
  jody's parents?"

Facts and rules together form what is often called a **knowledge base**
(**KB**). Many useful Prolog programs are structured as a knowledge base, plus
queries on that knowledge base.


## Running Prolog

To get started, [download and install SWI-Prolog](http://www.swi-prolog.org/),
or, if you are using (Ubuntu) Linux, try the terminal command `sudo apt
install swi-prolog`.

You run it at the command line by typing `prolog`:

```
$ prolog

Welcome to SWI-Prolog (threaded, 64 bits, version 7.6.4)
SWI-Prolog comes with ABSOLUTELY NO WARRANTY. This is free software.
Please run ?- license. for legal details.

For online help and background, visit http://www.swi-prolog.org
For built-in help, use ?- help(Topic). or ?- apropos(Word).

?- 
```

`?-` is the Prolog interpreter's prompt and means it's waiting for you
to assert a fact or rule, or ask it a question.

Suppose you have a file named `intro.pl` with this content:

```prolog
% intro.pl

likes(john, mary).   % a fact asserting that john likes mary
```

This file contains a single fact, `likes(john, mary).`, meaning "john likes
mary". `%` marks the start of a single-line source code comment.

Now lets load `intro.pl` into the Prolog interpreter (using `[` and `]`), and
ask a few questions:

```prolog
?- [intro].
% intro compiled 0.00 sec, 2 clauses
true.

?- likes(john, mary).
true.

?- likes(mary, john).
false.

?- likes(john, iron_man).
false.
```

The program *asserts* the fact that `john` likes `mary`, and so when we ask it
the "question" `likes(john, mary).` ("Does john like mary?"), it returns
`true`.

When we ask it if `mary` likes `john`, i.e. `likes(mary, john).`, Prolog
returns `false` because that's *not* a fact it knows or can infer. It *may* in
reality be true that `john` likes `mary`, but Prolog doesn't know that.

The third question, `likes(john, iron_man).`, is different. The value
`iron_man` is not mentioned anywhere in `intro.pl`. You might guess that this
would cause an error, but it's no problem in this example. Since Prolog can't
prove that `john` likes `iron_man`, it concludes that `john` *doesn't* like
`iron_man`.

That's a pretty aggressive conclusion. More accurately, we simply don't know
whether or not `john` likes `iron_man` because we know nothing about
`iron_man`. So a better answer would be "I don't know if `john` likes
`iron_man`". But Prolog does not do that. Instead:

  **if Prolog cannot prove something is true, it assumes that it is false**.

> **Note** Assuming something is false if it cannot be proven to be true is
> known as the [closed world
> assumption](https://en.wikipedia.org/wiki/Closed-world_assumption).


## Facts

Lets look at a fact in detail:

```prolog
likes(john, mary).
```

This specifies a relationship between two objects: the object `john` and the
object `mary` are in the `likes` relationship.

Note the following:

- Names of relationships and objects must start with a *lowercase* letter. In
  Prolog, uppercase letters are variables.

- The name of a relationship is often called a **predicate**, e.g. `likes` is
  a predicate.

- The `likes` predicate is *binary*, i.e. it has an *arity* of 2, meaning it
  takes exactly two **arguments**.

- In general, the order of arguments matters, i.e. `likes(john, mary).` is
  *not* the same fact as `likes(mary, john)`.

- Object names, such as  `john` and `mary`, are *symbols*. They are *not*
  strings. All we can do is test if two symbols are the same or different ---
  we can't access their individual characters.

- The dot character `.` marks the end of a fact.

Here are a few more examples of facts:

```prolog
fat(homer).                  % homer is fat
dad(homer).                  % homer is a dad
father_of(homer, bart).      % homer is bart's father
kicked(itchy, scratchy).     % itchy kicked scratchy
stole(bart, donut, homer).   % bart stole the donut from homer
```

Altogether, we would refer to this set of facts as a knowledge base.

The particular names used here have no special meaning in Prolog, and could
just as well been written like this:

```prolog
a(b).
c(b).
d(b, e).
f(g, h).
i(e, j, b).
```

Of course, this is much harder to read!

**Exercise.** Translate each of the following facts into Prolog. Use English
words and names to make the facts easy to read.

- Gold is valuable.

- Water is wet.

- Emily kissed Thomas.

- Jimi kissed the sky. 

- Mr. Whiskers fell asleep on the couch.

- Randy stole the book from Stan and gave it to Kyle.


**Solutions**

- `valuable(gold).`

- `wet(water).`

- `kissed(emily, thomas).`

- `kissed(jim, the_sky).`

- `fell_asleep(mr_whiskers, couch).`; or
  `fell_asleep_on_couch(mr_whiskers).`

- `stole(randy, book, stan, kyle).`


## Questions

Given a knowledge base, we can ask questions about it, i.e. query it. For
example:

```prolog
?- likes(john, mary).
true
```

Here `likes(john, mary).` is the question "Does john like mary?".

Prolog answers questions by searching the facts in its knowledge base to see
if any match the question. If so, `true` is returned; if not, `false` is
returned. We say that a query **succeeds** when it returns true, and **fails**
when it returns false.

Prolog uses an algorithm called **unification** to do its matching. Two facts
are said to **unify** if they have the same predicate name, the same number of
arguments, and the same arguments in the same position.

So, for example, `likes(john, mary)` and `likes(john, mary)` unify, while
`likes(john, mary)` and `likes(mary, john)` do not.


## Variables

To asks questions like "Who does john like?", or "Who likes john?", we need to
introduce variables.

Variables in Prolog are **logic variables**, and they are different than
variables in other programming languages:

- All Prolog variables must start with an uppercase letter. For example, `X`,
  `Who`, and `John` are all examples of Prolog variables, while `x`, `who`,
  and `john` are all symbols (and not variables).

- A Prolog variable is either *instantiated* or *uninstantiated*. An
  instantiated variable has some value associated with it, while an
  uninstantiated variable has no value associated with it.

  In most other programming languages, variables are always associated with
  some value. We might not know what the value is, but it is always there.

Suppose our knowledge base consists of these facts:

```prolog
likes(john, mary).
likes(mary, skiing).
likes(john, skiing).
likes(john, flowers).
likes(mary, surprises).
```

We can use a variable in a question like this:

```prolog
?- likes(john, X).  % What are all the things john likes?
X = mary ;          % user types ;
X = skiing ;        % user types ;
X = flowers.
```

The returned result is correct for the knowledge base: `john` likes `mary`,
`skiing`, and `flowers`. After Prolog finds a matching assignment for `X`, it
stops and displays what it has found. The user then has the option of stopping
the program by typing `.`, or, by typing `;`, to have Prolog *backtrack* and
try to find another value that satisfies `X`. In this example, the user typed
`;` after each value for `X` in order to search for more results.

When Prolog first sees the question `likes(john, X).` the variable `X` is
uninstantiated, i.e. it has no value associated with it. When an
uninstantiated variable appears as a predicate argument, Prolog lets that
variable unify with *any* value in the same position for a predicate with the
same name.

To answer the question `likes(john, X).` Prolog searches through its knowledge
base to see which facts, if any, unify with `likes(john, X).` You can imagine
the search going like this:

- Can `likes(john, X).` unify with `likes(john, mary).`? Yes it can if `X =
  mary`.

- Can `likes(john, X).` unify with `likes(mary, skiing).`? No, there is no
  possible value that can be assigned to `X` that makes `likes(john, X).` the
  same as `likes(mary, skiing).`.

- Can `likes(john, X).` unify with `likes(john, skiing).`? Yes it can if
  `X = skiing`.

- Can `likes(john, X).` unify with `likes(john, flowers).`? Yes it can if `X =
  flowers`.

- Can `likes(john, X).` unify with `likes(mary, surprises).`? No, there is no
  possible value that can be assigned to `X` that makes `likes(john, X).` the
  same as`likes(mary, surprises).`.

When Prolog successfully unifies a fact, it internally *marks* the place in
the knowledge base where the unification occurred so that it can later
*backtrack* to that point and try to find a different match. When the user
types `;` in the interpreter, that tells Prolog to continue searching by
starting immediately after the fact that was just unified. If, instead, the
user types a `.`, it tells Prolog to immediately stop searching.

Here's another example:

```prolog
?- likes(X, skiing).  % Who likes skiing?
X = mary ;
X = john.
```

And another:

```prolog
?- likes(nadine, X).  % What does nadine like?
false.
```

No facts in our knowledge base unify with this question, and so `false` is
returned.

Here's a question with two variables:

```prolog
?- likes(X, Y). % What things do people like?
X = john,
Y = mary ;      % the user types all the ; characters
X = mary,
Y = skiing ;
X = john,
Y = skiing ;
X = john,
Y = flowers ;
X = mary,
Y = surprises.
```

Compare it to this:

```prolog
?- likes(X, X).  % Who likes themselves?
false.
```

This means that there is no fact in the knowledge base whose first argument is
the same its second argument.

**Exercise.** Translate each of the following questions into Prolog. Use
English words and names to make the facts easy to read.

- Does Mary like John?
- Does John like himself?
- Who likes John?
- Who does John like?
- Who likes themselves?

**Solutions**

- `likes(mary, john).`
- `likes(john, john).`
- `likes(X, john).`
- `likes(john, X).`
- `likes(X, X).`

## Conjunctions

Another useful kind of question involves the word "and", e.g. "Does john like
both mary and skiing?". In Prolog, we can write such questions as follows:

```prolog
?- likes(john, mary), likes(john, skiing).
true.
```

The `,` means "and", and `true` is returned because both facts are in the
knowledge base.

All the facts separated by `,` must unify in order for the question to
succeed. So, for example, this fails:

```prolog
?- likes(john, mary), likes(john, surprises).
false.
```

Variables and conjunctions can be combined to ask some interesting questions.
For example, "What things do john and mary both like?":

```prolog
?- likes(john, X), likes(mary, X).
X = skiing ;
false.
```

Prolog tries to answer this question by first trying to unify `likes(john,
X)`. It first unifies with the fact `likes(john, mary).`, and so `X = mary`.
Then Prolog checks the second goal of the question, `likes(mary, X)`. Here,
`X` has the value `mary`, so it is equivalent to asking `likes(mary, mary)`,
which fails.

At this point Prolog automatically *backtracks* to the point where it
instantiated `X`. It goes back to `likes(john, X)`, unassigns `X`, and
continues searching through the knowledge base from where it left off. So
`likes(john, X)` next unifies with `likes(john, skiing)`, and so `X = skiing`.
Now it tries to satisfy `likes(mary, X)`. Since `X` has the value `skiing`,
this is the same as asking `likes(mary, skiing)`, which is true. Thus, the
entire conjunction is true.

If the user types `;` after this `X` is returned, then Prolog keeps searching
through the knowledge base in the same way, but does not find any more
matches, and so returns `false`.

**Exercise.** Translate each of the following questions into Prolog. Use
English words and names to make the facts easy to read.

- Does Mary like John, and John like Mary?
- Do John and Mary like themselves?
- Who likes John and Mary?
- Who/what do John and Mary both like?
- Who does John like that likes Mary?
- Who mutually likes each other?

**Solutions**

- `likes(mary, john), likes(john, mary).`
- `likes(mary, mary), likes(john, john).`
- `likes(X, john), likes(X, mary).`
- `likes(john, X), likes(X, mary).`
- `likes(john, X), likes(mary, X).`
- `likes(X, Y), likes(Y, X).`


## Using Prolog as a Database

One application of Prolog is as an in-memory database. For example, here's a
simple knowledge base about [rocks](https://www.thoughtco.com/rock-identification-tables-1441174):

```prolog
grain(obsidian, fine).
color(obsidian, dark).
composition(obsidian, laval_glass).

grain(pumice, fine).
color(pumice, light).
composition(pumice, sticky_lava_froth).

grain(scoria, fine).
color(scoria, dark).
composition(scoria, fluid_lava_froth).

grain(felsite, fine_or_mixed).
color(felsite, light).
composition(felsite, high_silica_lava).

grain(andesite, fine_or_mixed).
color(andesite, medium).
composition(andesite, medium_silica_lava).

grain(basalt, fine_or_mixed).
color(basalt, dark).
composition(basalt, low_silica_lava).

grain(pegmatite, very_coarse).
color(pegmatite, any).
composition(pegmatite, granitic).
```

Notice there are no rules in this knowledge base, only facts.

Here are some queries we can make.

*What kind of rocks are there?*

```prolog
?- grain(Rock, _).
Rock = obsidian ;
Rock = pumice ;
Rock = scoria ;
Rock = felsite ;
Rock = andesite ;
Rock = basalt ;
Rock = pegmatite.
```

Note that this query assumes that all rocks have a grain. We'd get the same
result (for this knowledge base) if we replaced `grain` by `color` or
`composition`.

`_` is the **anonymous variable**, and it can be used when we a variable is
required but we don't care about its value.

*Which rocks have a light color?*

```prolog
?- color(Rock, light).
Rock = pumice ;
Rock = felsite.
```

*Which rocks are not a light color?*

```prolog
?- color(Rock, Color), Color \= light.
Rock = obsidian,
Color = dark ;
Rock = scoria,
Color = dark ;
Rock = andesite,
Color = medium ;
Rock = basalt,
Color = dark ;
Rock = pegmatite,
Color = any.
```

An expression of the form `X \= Y` succeeds just when `X` and `Y` do *not*
unify.

*Which rocks have the same grain as basalt?*

```prolog
?- grain(basalt, G), grain(Rock, G).
G = fine_or_mixed,
Rock = felsite ;
G = fine_or_mixed,
Rock = andesite ;
G = fine_or_mixed,
Rock = basalt.
```

*Which rocks have a grain different than basalt?*

```prolog
?- grain(basalt, BasaltGrain), grain(Other, OtherGrain), 
   BasaltGrain \= OtherGrain.
BasaltGrain = fine_or_mixed,
Other = obsidian,
OtherGrain = fine ;
BasaltGrain = fine_or_mixed,
Other = pumice,
OtherGrain = fine ;
BasaltGrain = fine_or_mixed,
Other = scoria,
OtherGrain = fine ;
BasaltGrain = fine_or_mixed,
Other = pegmatite,
OtherGrain = very_coarse.
```


## Rules

Rules let us encode things like "john likes anyone who likes painting". For
example:

```prolog
likes(john, X) :- likes(X, painting). % the rule "john likes anyone who likes painting"
```

The `:-` in a Prolog rule means "if". On the left of the `:-` is the **head**
of the rule, and on the right is the **body** of the rule. As with facts, a
rule must end with a `.`.

Here's another rule:

```prolog
likes(john, X) :- likes(X, painting), likes(X, food).    % a rule
```

This can be read "john likes anyone who likes both food and painting". Or,
equivalently, "john likes X if X likes painting and X likes food".

Lets see a more complex rule. We will use this knowledge base:

```prolog
male(bob).
male(doug).

female(val).
female(ada).

% parents(Child, Mother, Father)
parents(doug, ada, bob).
parents(val, ada, bob).
```

We define the `sister_of` rule as follows:

```prolog
sister_of(X, Y) :-
    female(X),
    parents(X, Mother, Father),   % Mother and Father are capitalized,
    parents(Y, Mother, Father).   % and so they are variables
```

This encodes the rule "X is the sister of Y if X is female, and the mother and
father of X is the same as the mother and father of Y".

We can now ask questions like this

```prolog
?- sister_of(val, doug).  % Is val doug's sister?
true.
```

Tracing how this question gets answered is instructive:

- The question `sister_of(val, doug).` unifies with the head of the
  `sister_of` rule.

- Next Prolog tries to satisfy each goal in the `sister_of` rule in the order
  they're given. Since `X` is `val`, it checks that `female(val)` is true.

- `female(val)` is a fact in the knowledge base, so Prolog moves to the next
  goal in the rule and searches for the first fact that unifies with
  `parents(val, Mother, Father)`.

- Looking at the knowledge base, we can see that there is only one match:
  `parents(val, ada, bob)`. Thus, at this point, `Mother` has the value `ada`,
  and `Father` has the value `bob`.

- Prolog now tries to unify `parents(Y, Mother, Father)` with a fact in the
  knowledge base. Since `X` is `val`, `Y` is `doug`, `Mother` is `ada`, and
  `Father` is `bob`, Prolog checks to see if `parents(doug, ada, bob)` is in
  the knowledge base. And it is, so Prolog returns `true`.

- Although we don't see it, Prolog actually *backtracks* in this rule to see
  if there are any other ways to satisfy it. There's no other way to satisfy
  `parents(doug, ada, bob)`, so Prolog goes back to `parents(val, Mother,
  Father)` to see if there is some other fact in the knowledge base that
  unifies with it. There isn't, so it backtracks again to `female(val)`, which
  cannot be unified with anything else. Thus, Prolog has found the one and
  only way to satisfy this rule.

Let's try another question:

```prolog
?- sister_of(val, X).  % Who has val as a sister?
X = doug ;
X = val.
```

The question `sister_of(val, X).` asks "Who has val as a sister?" (or "Who are
val's siblings?"). As we can see from the results, it doesn't return quite the
right answer. It correctly identifies that doug has val as a sister, but it
also claims val is her owns sister! This is obviously not correct, but our
rule allows it. Let's trace it to see why:

- `sister_of(val, X)` unifies with the head of the `sister_of` rule,
  `sister_of(X, Y)`. We need to be careful with the two `X` variables here.
  The `X` in the rule header is assigned `val`, and so for the rest of the
  trace we will replace that `X` by `val`. The `X` in the question is
  different. It unifies with the variable `Y`. We say that `X` and `Y` are
  **shared** variables, or that they **coreference** each other. What happens
  is that once one of these two variables is assigned a value, the other
  variable immediately gets the same value.

- Now Prolog checks the individual goals in the body of the rule. The first
  one, `female(val)`, succeeds.

- Next Prolog tries to unify `parents(val, Mother, Father)`, and it finds the
  (only) match `parents(val, ada, bob)`. Now `Mother` is `ada`, and `Father`
  is `bob`.

- Now Prolog tries to unify `parents(Y, ada, bob)`. The first fact in the
  knowledge base that matches this is `parents(doug, ada, bob).` and so `Y`
  gets the value `doug`. The variable `X` from the question (*not* the `X` in
  the rule header!) shares the same value as `X`, and so the result of the
  question is `X = doug`.

- If the user types `;`, Prolog backtracks and tries to find another solution.
  Prolog backtracks by unassigning the variables in the most recently
  satisfied goal, i.e. it tries to find another fact to unify `parents(Y, ada,
  bob)` with. And there is such a fact in our knowledge base: `parents(val,
  ada, bob)`. So `Y` gets assigned `val`, and thus the shared `X` variable
  (the one in the question, not the one in the rule head!) also gets assigned
  `val`. This is how the second result of `X = val` is found.

Intuitively, the problem with the `sister_of` rule is that it doesn't state
that someone cannot be their own sister, i.e. it nowhere says that `X` and `Y`
must be different. We can fix it like this:

```prolog
sister_of(X, Y) :-
    female(X),
    parents(X, Mother, Father),
    parents(Y, Mother, Father),
    X \= Y.  % X and Y must be different
```

`\=` means `X \= Y` succeeds only when `X` and `Y` *don't* unify with each
other, i.e. they have different values:

```prolog
?- sister_of(val, X).
X = doug ;
false.
```

In general, getting rules that work correctly in all cases is quite tricky in
Prolog: they must be *completely* precise.


## Anonymous Variables

Prolog lets you use `_` as a special **anonymous variable**. We use it when a
variable is needed, but we don't care about the value it is assigned. For
example:

```prolog
?- sister_of(val, _).  % Is val the sister of someone?
true 
```

Prolog tells us the question succeeded, but it does not return a value for
`_`.

An important detail is that the anonymous variable `_` does not co-refer (i.e.
share) with any other variable (even itself). So when `sister_of(val, _)`, `_`
will *not* share the same value as the `X` variable in the `sister_of` rule.

We can also use anonymous variables in facts. For instance:

```prolog
likes(_, food).   % everybody likes food
likes(john, _).   % john likes everything
likes(_, _).      % everything likes everything
```


## Doing Simple Arithmetic with Prolog

Prolog functions *don't* return values like functions in most other languages.
You need to use extra parameters to get the results of a calculation. For
instance, this function converts Fahrenheit to Celsius:

```prolog
to_celsius(F, C) :- C is (F - 32) * 5 / 9.
```

The `is` operator is used whenever we need the result of an arithmetic
calculation.

You call `to_celsius` like this:

```prolog
?- to_celsius(90, C).
C = 32.22222222222222.
```

Unfortunately, the first argument of `to_celsius` *cannot* be uninstantiated,
e.g.:

```prolog
?- to_celsius(F, 15).
ERROR: is/2: Arguments are not sufficiently instantiated
```

The error says that the right-hand side of the `is` statement is not allowed
to have uninstantiated variables.

Here's another function that calculates the area of a circle:

```prolog
circle_area(Radius, Area) :- Area is Radius * Radius * 3.14.

?- circle_area(3, Area).
Area = 28.26.
```

The radius *must* be provided, otherwise you'll get an error.


## Working with Lists

Prolog provides good support for lists. Prolog lists begin with `[`, end with
`]`, and separate values with `,`. For example, `[5, 7, 3]` and `[a, b, c, d]`
are both Prolog lists. Prolog provides a nice notation for easily accessing
the first element of a list, and the rest of the elements:

```prolog
?- [Head|Rest] = [a, b, c, d].
Head = a,
Rest = [b, c, d].
```

You can also get more than one at item at the head of the list like this:

```prolog
?- [First, Second | Rest] = [a, b, c, d].
First = a,
Second = b,
Rest = [c, d].
```

We will frequently use `|` notation for processing lists one element at a
time.


## The Member Function

Prolog rules are flexible enough to implement *any* function we like.

Lets write a function called `member(X, L)` that succeeds just when `X` is
somewhere on the list `L`. Prolog has no loops, so we use recursion:

```prolog
member(X, [X|_]).                       % base case
member(X, [_|Rest]) :- member(X, Rest). % recursive case
```

As with any recursive function, we have a base case and a recursive case. The
base case is `member(X, [X|_])`, which succeeds just when the item we are are
looking for is the first element of the list. We use the anonymous variable
`_` here because we don't use the rest of the list.

In the recursive case, we can safely assume that the first element of the list
is not `X` because it would have been caught by the previous case. So if `X`
is on the list, it must be somewhere in `Rest`, and that's what we check in
the body.

We can call `member` like this:

```prolog
?- member(5, [6, 8, 15, 1]).
false.

?- member(5, [6, 8, 5, 1]).
true ;                       % user typed ;
false.
```

The second example is odd: Prolog has returned both true and false! Which is
it? Prolog found the 5 at the end of the list, and that's why it returned
true. Because the user typed `;`, Prolog backtracks to its most recent
decision point, and tries to find 5 somewhere later in the list. It can't, and
so it returns false.

So you can think of the `true` as meaning a 5 was found, and the `false`
meaning "no more 5s were found". If you only care about whether or not there
is a 5 somewhere in the list, then you can stop (type `.`) as soon as `true`
is returned.

Now comes a very nice feature of Prolog. We can use `member` to *generate*
items on a list one by one. For example:

```prolog
?- member(X, [6, 8, 1, 15]).
X = 6 ;
X = 8 ;
X = 1 ;
X = 15 ;
false.
```

This essentially iterates through the list an element at a time, similar to a
loop.

It can also handle variables in the list:

```prolog
?- member(5, [6, 8, X, 1, 15]).
X = 5 ;
false.
```

These examples show that `member` can do more than just test if a number is on
a list. Prolog programmers often try to write functions in a way that allows
variables to appear anywhere in the arguments. It isn't always possible to do
so (see `to_celsius` above), but when you can do it, the results can be quite
useful.


## The Length Function

The Prolog function `length(Lst, N)` calculates the length of a list:

```prolog
?- length([], N).
N = 0.

?- length([3], N).
N = 1.

?- length([3, 6, 8], N).
N = 3.

?- length([3, X, 6, 8], N).
N = 4.
```

You can also use `length` to test if a list is of a given length, e.g.:

```prolog
?- length([3, 1, 4], 3).
true.

?- length([3, 1, 4], 2).
false.
```

Surprisingly, `length` can also create lists of a given length for you, e.g.:

```prolog
?- length(X, 2).
X = [_G1985, _G1988].
```

`X` is a list of length 2, and it contains two variables generated by Prolog.

You can even pass two variables to `length`:

```prolog
?- length(Lst, N).
Lst = [],
N = 0 ;
Lst = [_G1997],
N = 1 ;
Lst = [_G1997, _G2000],
N = 2 ;
Lst = [_G1997, _G2000, _G2003],
N = 3 ;
Lst = [_G1997, _G2000, _G2003, _G2006],
N = 4 
...
```

This generates an infinite number of lists of lengths 0, 1, 2, 3, .... The
items on the list (e.g. `_G1997`, `_G2000`, ...) are new variables created by
Prolog, and their values can be anything. `[_G1997, _G2000]` can unify with
*any* 2-element list.

`length` is built-in, but it is instructive to write our own version of it.
For example:

```prolog
mylen([], 0).            % base case
mylen([_|Xs], Len) :-    % recursive case
    mylen(Xs, Rest_len),
    Len is 1 + Rest_len.
```

In the usual cases, `mylen` works the same as `length`:

```prolog
?- mylen([], N).
N = 0.

?- mylen([3], N).
N = 1.

?- mylen([3, 6, 8], N).
N = 3.

?- mylen([3, X, 6, 8], N).
N = 4.

?- mylen([3, 1, 4], 3).
true.

?- mylen([3, 1, 4], 2).
false.
```

It also works when you pass it two variables:

```prolog
?- mylen(Lst, N).
Lst = [],
N = 0 ;
Lst = [_G20210],
N = 1 ;
Lst = [_G20210, _G20213],
N = 2 ;
Lst = [_G20210, _G20213, _G20216],
N = 3 ;
Lst = [_G20210, _G20213, _G20216, _G20219],
N = 4
...
```

But it does not quite work the same in this case:

```prolog
?- mylen(Lst, 3).
Lst = [_G22652, _G22655, _G22658] ;    % user types ;
% ... runs forever ...
```

`mylen(Lst, 3)` finds, as a first solution, a list of length 3. But then if
you request another solution by typing `;`, the program appears to get stuck
in an infinite loop. Since we're only interested in learning basic Prolog, we
will simply ignore this problem; this particular use of `mylen` doesn't seem
to be very common or useful.


## Simple Statistics

Suppose you want to sum a list of numbers. Here's how you could do it in
Prolog:

```prolog
sum([], 0).             % base case
sum([X|Xs], Total) :-   % recursive case
    sum(Xs, T),
    Total is X + T.     % always use "is" for arithmetic
```

Now we can write a function to calculate the average:

```prolog
mean(X, Avg) :- 
    sum(X, Total), 
    length(X, N), 
    Avg is Total / N.
```

Next, lets write a function that calculates the minimum value on a list.
First, we write the `min` function that determines the smaller of two values:

```prolog
min(X, Y, X) :- X =< Y.  % =< is less than or equal to
min(X, Y, Y) :- X > Y.
```

We use `min` in the definition of `min_list` as follows:

```prolog
min_list([X], X).               % base case
min_list([Head|Tail], Min) :-   % recursive case
    min_list(Tail, Tmin), 
    min(Head, Tmin, Min).
```

## Appending

Prolog has a standard built-in `append` function that concatenates two lists,
but it is instructive to write our own version. For example:

```prolog 
myappend([], Ys, Ys).            % base case
myappend([X|Xs], Ys, [X|Zs]) :-  % recursive case
  myappend(Xs, Ys, Zs).
```

Read this definition carefully --- it is well worth understanding!

This function can be used in a number of different ways. For example:

```prolog
?- myappend([1,2],[3,4],[1,2,3,4]).     % confirm that two lists append
true.                                   % to another list

?- myappend([1,2],[3,4],[1,2,3,4,5]).
false.

?- myappend([1,2],[3,4],X).        % append two lists
X = [1, 2, 3, 4].

?- myappend([1,2],X,[1,2,3,4]).    % what list appends to make another?
X = [3, 4].

?- myappend(X,[3,4],[1,2,3,4]).
X = [1, 2].

?- myappend(X,Y,[1,2,3,4]).        % all pairs of list that append to make 
X = [],                            % [1,2,3,4]
Y = [1, 2, 3, 4] ;
X = [1],
Y = [2, 3, 4] ;
X = [1, 2],
Y = [3, 4] ;
X = [1, 2, 3],
Y = [4] ;
X = [1, 2, 3, 4],
Y = [] ;
false.

?- myappend(X,Y,Z).
X = [],
Y = Z ;
X = [_G2375],
Z = [_G2375|Y] ;
X = [_G2375, _G2381],
Z = [_G2375, _G2381|Y] ;
X = [_G2375, _G2381, _G2387],
Z = [_G2375, _G2381, _G2387|Y] ;
X = [_G2375, _G2381, _G2387, _G2393],
Z = [_G2375, _G2381, _G2387, _G2393|Y] ;
X = [_G2375, _G2381, _G2387, _G2393, _G2399],
Z = [_G2375, _G2381, _G2387, _G2393, _G2399|Y]
...
```

It's pretty impressive that such a small function can be used in so many
different ways!
