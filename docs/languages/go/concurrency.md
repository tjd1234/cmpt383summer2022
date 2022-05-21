# Concurrency in Go

The following notes are based mostly on chapter 8 of the book [The Go
Programming Language](https://www.gopl.io/), by Alan Donovan and Brian
Kernighan.


## Concurrent Programming

The Go programs we've seen so far all are all single process programs, i.e.
there is one thread of control that executes one line of code at a time. In a
concurrent program, there can be more than autonomous activity occurring at
the same time. This is very useful in practice since many computers have
multiple CPUs. A web server, for example, may use thousands of concurrent
threads of control to handle requests from users. A cell phone app might uses
concurrent threads of control to render animation on the screen, and at the
same time connect to the network or open a file.

Go supports two basic models of concurrency: [communicating sequential
processes
(CSP)](https://en.wikipedia.org/wiki/Communicating_sequential_processes), and
shared-memory threads. 

Discussing concurrent program is challenging because it involves new concepts
and techniques (e.g. network programs), and intuitions about non-current
programs are often wrong, or inaccurate, in concurrent programs. So we'll only
briefly cover a few of the very basic ideas of Go's approach to
[CSP](https://en.wikipedia.org/wiki/Communicating_sequential_processes), and
won't discuss shared-memory threads at all.


## Goroutines

In Go, a concurrently executing activity is called a **goroutine**. A
goroutine is similar to a thread in other languages.

All Go programs have a **main goroutine** that starts when `main()` is called.
The `go` keyword launches other goroutines:

```go
f()    // call f() and wait for it to return
go f() // create a new goroutine that calls f(); don't wait 
```

For example, [spinner.go](spinner.go) draws an ASCII-animation of a spinner on
the screen while the program does a long-running computation:

```go
package main

import (
    "fmt"
    "time"
)

func main() {
    //
    // Launch spinner in its own "goroutine" that runs as ASCII-animated
    // spinner while waiting for a long-running computation to complete.
    //
    go spinner(100 * time.Millisecond)

    //
    // Do a long-running computation. The spinner keeps spinning while fibN is
    // being calculated.
    //
    const n = 45
    fibN := fib(n) // slow
    fmt.Printf("\rFibonacci(%d) = %d\n", n, fibN)
}

// 
// Loops forever, displaying an ASCII-animated spinner. It has no explicit
// stopping condition because it will end when the program ends.
//
func spinner(delay time.Duration) {
    for {
        for _, r := range `-\|/` {
            fmt.Printf("\r%c", r)
            time.Sleep(delay)
        }
    }
}

func fib(x int) int {
    if x < 2 {
        return x
    }
    return fib(x-1) + fib(x-2)
}
```

This program has two goroutines: the main goroutine that all Go programs have,
plus the goroutine created by the `go spinner` call. Both goroutines are
automatically terminated when the program ends.


## Channels

In Go, a **channel** is a connection between two goroutines that lets them
communicate with each other. New channels are created using the built-in
`make` function, and each **channel** is restricted to communicating variables
of a pre-declared type:

```go
ch := make(chan int)  // ch is a channel of type "chan int"
```

Channels are treated like references when it comes to passing them as values
or copying them. So if you pass a channel as a parameter to another function,
both the original code and the function now share the same channel.

The two main operations on a channel are **send** and **receive**:

```go
ch <- x   // send x to channel ch

x = <-ch  // receive a value from channel ch, and call it x
<-ch      // receive a value from channel ch, and discard it
```

You can also **close** a channel by writing `close(ch)`. Closing a channel
indicates no more values will ever be sent to it, and Go will panic with an
error if you try to send to a closed channel. Closing a channel is a signal to
the receiving goroutine that all values have been sent.

Note that concurrency in Go means multiple goroutines. The computer running
the program does not necessarily need to have one CPU for each goroutine.
While one CPU per goroutine might be good for performance, Go will, when
necessary, schedule goroutines to use the available CPUs. Even if your
computer has only one CPU it will be able to run a Go program with lots of
goroutines (although maybe not as efficiently as you'd like).


## Unbuffered Channels: Synchronized Sending and Receiving

When you create a channel using `make(chan int)`, the channel is
**unbuffered**. Unbuffered channels are synchronized by sending and receiving.
When you send on an unbuffered channel, the sending goroutine blocks (i.e.
waits) until another goroutine executes a receive on the same channel. When
the value is received, both goroutines continue executing.

If a goroutine executes a receive operation on an empty channel, then that
goroutine will block (i.e. wait) until another goroutine sends a value to that
channel.

Importantly, if a goroutine sends a value on an unbuffered channel, then that
goroutine is guaranteed to continue executing only *after* another goroutine
has received the value. Put another way, receiving a value on an unbuffered
channel is guaranteed to happen *before* the sending goroutine is unblocked.

Concurrent programming is more difficult than non-current programming because,
in general, you cannot always be certain that some operation *x* always
happens before some operation *y*. If *x* and *y* are triggered by different
goroutines, then, depending upon which goroutine started first and how fast
they are running, *x* might occur before *y*, *y* might occur before *x*, or
maybe even *x* and *y* occur at the exact same time.

Unbuffered channels are thus useful because they can guarantee the order of
some operations, which makes it much easier to reason about concurrent
programs.


## Example: Generators

As an example of the power of goroutines, lets see how we can use goroutines
to generate values on demand. The code for these examples can be found in
[gen.go](gen.go).

Consider this function, which returns an `int` channel:

```go
func counter(n int) chan int {
    ch := make(chan int)  // ch is an unbuffered channel

    //
    // Launch a goroutine.
    //
    go func() {
        for i := 0; i < n; i++ {
            ch <- i // blocks here until i is removed from the channel
        }
        close(ch)
    }() // note the () is needed here since this is a function call

    //
    // Return the channel that communicates with the goroutine.
    //
    return ch
}
```

When called, it launches a goroutine, and returns a channel `ch` that can be
used to communicate with that goroutine. The goroutine itself uses a loop to
generate the numbers from 0 to n-1. Every number is immediately sent to the
channel `ch`. Since `ch` is unbuffered, this causes the goroutine to block
(wait) until the value is received by another goroutine. After all n numbers
are sent, the channel is closed, signaling to other goroutines that no more
values will be sent.

You can think of a the goroutine launched by `counter` as like a little server
that sits in memory, "serving" `int`s whenever there is a request for another
one on the channel.

We can use `Counter` like this:

```go
for n := range counter(10) {
    fmt.Println(n)
}
```

This prints the numbers from 0 to 9 on the screen.

Using the same idea, here is a slightly more complex example that generates
Fibonacci numbers:

```go
func fibgen() chan int {
    ch := make(chan int)  // unbuffered channel

    go func() {
        a, b := 1, 1
        for {             // infinite loop
            ch <- a       // blocks here until a is received
            a, b = b, a+b
        }
    }()
    return ch
}
```

Again, the function launches a goroutine, and then returns an unbuffered
channel that lets you communicate with it. The goroutine is infinite loop that
never ends: every time another goroutine receives a value on `ch`, the next
Fibonacci number is generated and sent to `ch`. Since `ch` is unbuffered, the
goroutine always blocks (waits) until another goroutine receives the value.

You can use it like this:

```go
nextFib := fibgen()
for i := 0; i < 10; i++ {
    fmt.Println(<-nextFib)
}
```

Every time `<-nextFib` is executed it gets the next Fibonacci number. You can
get as many numbers as you like from it.

Notice how this separates the loop and the stopping condition of the loop. The
goroutine launched by `fibgen` loops forever, and has no rule for when it
stops. The stopping condition is effectively up to the code that calls it.
This simplifies the goroutine, and also makes it more flexible, allowing the
code that calls it to decide how and when to get the next Fibonacci number.

## More Information

We've just scratched the surface of concurrency in Go, and if you are
interested in learning more details, chapter 8 of the book [The Go Programming
Language](https://www.gopl.io/) is a good place to get more information.
