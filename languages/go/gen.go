// gen.go

//
// Demonstrates how to uses goroutines and channels to make generators.
//

package main

import (
    "fmt"
)

// Returns an int channel
func counter(n int) chan int {
    ch := make(chan int)

    // Launch a goroutine.
    go func() {
        for i := 0; i < n; i++ {
            ch <- i // blocks here until is is removed from the channel
        }
        close(ch)
    }() // note the () here: this is a function

    // Return the channel that communicates with the goroutine.
    return ch
}

func TestCounter() {
    for n := range counter(10) {
        fmt.Println(n)
    }
}

//
// Generate the Fibonacci numbers one at a time.
//
func fibgen() chan int {
    ch := make(chan int)
    go func() {
        a, b := 1, 1
        for { // infinite loop
            ch <- a // blocks here until a is removed from channel
            a, b = b, a+b
        }
    }()
    return ch
}

func TestFib() {
    // Every time <-nextFib is called, the next Fibonacci number is taken from
    // the channel.
    nextFib := fibgen()
    for i := 0; i < 10; i++ {
        fmt.Println(<-nextFib)
    }
}

func main() {
    TestCounter()
    // TestFib()
}
