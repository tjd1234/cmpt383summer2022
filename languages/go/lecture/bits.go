// bits.go

//
// Print all bit strings consisting of n-bits.
//
// For example, the eight 3-bit bit strings are: "000", "001", "010", "011",
// "100", , "101", "110", "111".
//
// The order of the bit strings doesn't matter.
//

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

//
// Returns a slice of all bit-strings of length n.
//
// The ... in the calls to append add all the elements of the slice onto the
// right.
//
func nbits(n int) []string {
    if n < 0 {
        return []string{}
    } else if n == 1 {
        return []string{"0", "1"}
    } else {
        n1bits := nbits(n - 1)

        // zero and one are slices that are copies of n1bits
        zero := append([]string{}, n1bits...)
        one := append([]string{}, n1bits...)

        for i := range n1bits {
            zero[i] = zero[i] + "0"
            one[i] = one[i] + "1"
        }

        return append(zero, one...)
    }
}
