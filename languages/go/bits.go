// bits.go

// Print all bit strings of length n. It should work for any integer n >= 0,
// although since there are an exponential number of bit strings it's okay if
// your program takes a long time to calculate large values of n.

package main

import "fmt"

func main() {
    n := 4
    fmt.Printf("%v-bit strings:\n", n)
    bits := nbits(n)
    for i, b := range bits {
        fmt.Printf("%v. %v\n", i+1, b)
    }
}

// Returns a slice of all bit-strings of length n.
func nbits(n int) []string {
    if n < 0 {
        return []string{}
    } else if n == 1 {
        return []string{"0", "1"}
    } else {
        n1bits := nbits(n - 1)
        zero := append([]string{}, n1bits...)
        one := append([]string{}, n1bits...)

        for i := range n1bits {
            zero[i] = "0" + zero[i]
            one[i] = "1" + one[i]
        }
        return append(zero, one...)
    }
}
