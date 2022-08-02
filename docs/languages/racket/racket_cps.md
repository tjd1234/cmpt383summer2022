## Continuation Passing Style in Racket

**Continuation passing style**, or **CPS** for short, is a way of writing
programs that has proven useful as an *intermediate form* in compiling
functional languages such as Racket. Using CPS, things like order of
evaluation and temporary variables are made explicit.


## Example: `2 * 3 + 1`

Suppose you want to evaluate the expression $2 \cdot 3 + 1$ in Racket. The
regular way of doing this is `(+ (* 2 3) 1)`. Notice two things:

- `(* 2 3)` evaluates to 6, and this 6 is temporarily stored in memory

- the operators are *not* evaluated in the order they appear syntactically;
  instead, the `*` is evaluated before the `+`

Now lets evaluate $2 \cdot 3 + 1$ using CPS. We'll do this by first creating
CPS versions of the `+` and `*` functions.

The basic idea of CPS is that every CPS function `f` will take one extra
parameter, called `k`, that will be called on the result of `f` *instead* of
returning a value. For example, here is the CPS version of `+`:

```scheme
(define (+c x y k)
    (k (+ x y)))
```

`k` is called a **continuation function**, or **continuation** for short. A
continuation always takes one input and returns one input. The continuation
`k` contains the code that will be executed *after* `(+ x y)` is calculated.

To call it, you could do this:

```scheme
> (+c 2 3 (lambda (x) x))
5
```

The continuation in this example is `(lambda (x) x)`, i.e. the **identity
function** that does nothing but return its input unchanged. This is actually
quite handy with continuations, so we will define it like this:

```scheme
(define (id x) x)
```

So now we can write:

```scheme
> (+c 2 3 id)
5
```

Here's a CPS version of multiplication:

```scheme
(define (*c x y k)
    (k (* x y)))
```

Again, the idea is that the result of `(* x y)` is passed to the continuation
`k` instead of being returned directly. `k` contians the code that will be
executed after `(* x y)`.

Now, let's combine these to make a CPS version of $2 \cdot 3 + 1$. It is
helpful to write down the regular version to use as a guide:

```scheme
(+ (* 2 3) 1)
```

The idea is to first call `*c`, and then pass that to a continuation that
adds 1:

```scheme
  (define (k x) (+ x 1))   ;; k is the the continuation

  (define a (*c 2 3 k))    ;; a is 7
```

Evaluate this in Racket and you'll see `a` has the correct value 7. Instead
of naming `k` explicitly, it is common to write it as a lambda function
directly in the expression in being calculated, e.g.:

```scheme
(define b 
    (*c 2 3 (lambda (x)    ;; k replaced by its lambda function
                (+ x 1))
    )
)
```

In English, it could be read like this:

> Multiply 2 by 3, and store the result in `x`. Then add 1 to `x` and return
> that as the final result.

Note that we don't call `+c` because there is nothing that occurs after the
addition.


## Example: `1*2 + 3*4`

Now lets try writing $1 \cdot 2 + 3 \cdot 4$ in CPS style. First, we'll write
the regular Racket style as a guide:

```scheme
(+ (* 1 2) (* 3 4))
```

When you evaluate this, logically it does not matter if you evaluate `(* 1 2)`
first or `(* 3 4)` first. However, CPS forces us to decide which one to
evaluate first, so lets start with `(* 1 2)`:

```scheme
(define c
  (*c 1 2 (lambda (m12)
            (*c 3 4 (lambda (m34)
                      (+ m12 m34)))))
  )
```

Here's how you can read this in English:

> Multiply 1 by 2, and store the result in `m12`. Then multiply 3 by 4 and
> store that result in `m34`. Finally, return the result of adding `m12` and
> `m34`.

Notice that the order in which the operations are called is the order in which
they are evaluated, and that the temporary storage locations have explicit
names.

The final call to `+` is not a continuation, since there is nothing that
happens after the addition in this example.


## Example: `1 + 2 + 3 + ... + n = n(n + 1)/2`

Recall that $1 + 2 + 3 + \ldots + n = \frac{n(n+1)}{2}$. Here is a regular
Racket function that evaluates this formula:

```scheme
(define (S n) 
    (/ (* n (+ n 1)) 2))
```

To implement this as a CPS function, we'll need a CPS version of `/`:

```scheme
(define (/c x y k)
    (k (/ x y)))
```

Now we can write this CPS version:

```scheme
(define (S-c n k)
  (+c n 1 (lambda (np1)
            (*c n np1 (lambda (num)
                        (/c num 2 k))))))
```

In English:

> First, add 1 to n, and store the result in a variable named `np1`. Then
> multiply `n` by `np1`, and store that in `num`. Finally, divide `num` by 2
> and call the continuation `k` on that result.

Using the `id` identity function defined above, we can call it like this:

```scheme
> (S-c 3 id)
6

> (S-c 10 id)
55
```

## Example: `1 + 2 + 3 + ... + n` Recursively

Another way to calculate $1 + 2 + 3 + \ldots + n$ is to use a recursive
function. In regular Racket style we could do it like this:

```scheme
(define (recsum n)
    (if (= n 0)
        0
        (+ n (recsum (- n 1)))))
```

To write this in CPS, we'll need a couple of more basic CPS functions:

```scheme
(define (=c x y k)
    (k (= x y)))

(define (-c x y k)
    (k (- x y)))
```

Now we can write it like this:

```scheme
(define (recsum-c n k)
  (=c n 0 (lambda (b)
            (if b
                (k 0)
                (-c n 1 (lambda (nm1)
                          (recsum-c nm1 (lambda (rs)
                                          (+c n rs k)))))))))
> (recsum-c 3 id)
6

> (recsum-c 10 id)
55
```

At first sight, this functions looks quite the mess! But if you read through
it line by line, it spells out the computations in the order they are done. It
is a little bit like assembly language, but written in a functional style.


## Example: factorial

```scheme
(define (fact n)                ;; regular
  (if (= n 0)
      1
      (* n (fact (- n 1)))))


(define (fact-c n k)            ;; CPS
  (=c n 0 (lambda (b)
            (if b
                (k 1)
                (-c n 1 (lambda (nm1)
                          (fact-c nm1 (lambda (f)
                                        (*c n f k)))))))))
```

## Example: member

```scheme
    (define (member x lst)                 ;; regular
      (cond
        ((empty? lst)
         #f)
        ((equal? x (first lst))
         #t)
        (else
         (member x (rest lst)))))


    (define (member-c x lst k)             ;; CPS
      (empty?-c lst (lambda (bn)
                      (if bn
                          (k #f)
                          (first-c lst (lambda (cal)
                                         (equal?-c x cal (lambda (ex)
                                                           (if ex
                                                               #t
                                                               (rest-c lst (lambda (cdl)
                                                                             (member-c x cdl 
                                                                             k))))))))))))
```

## Call with Current Continuation

Racket comes with a remarkable function for dealing with continuations named
`call-with-current-continuation`, or `call/cc` for short. It's an extremely
powerful function, allowing you to implement control features such as
exceptions, co-routines, threads, undo, or non-deterministic programming.

Essentially, `call/cc` provides a "snapshot" of the current state of a running
Racket program. The input to `call/cc` is a single function `f`, i.e. you use
`call/cc` by writing `(call/cc f)`. The function `f` takes one input called
`k`, the *current* continuation for the program. `f` can do whatever it wants
with `k`. For example, you could implement an undo feature by putting `k` on a
list and calling it at some later time.
