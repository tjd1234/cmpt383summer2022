// spinner.go

//
// Draws an ASCII "spinner" graphic on the screen while doing a long
// calculation.
//
// From Chapter 8 of the book "The Go Programming Language", by Donovan and
// Kernighan.
//

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
