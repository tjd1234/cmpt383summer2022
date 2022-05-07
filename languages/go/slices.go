// slices.go

//
// A slice is a "fat" pointer, i.e. it a slice is a data structure that refers
// to a contiguous slice of an underlying array.
//
// In most cases, slices are preferred over arrays.
//

package main

import (
    "fmt"
)

// slices contain a pointer to their underlying array, and so when you pass a
// slice to a function no copy of the underlying array is made, i.e. it acts
// as if the array were passesd by reference
func incAll(s []int) {
    for i := 0; i < len(s); i++ {
        s[i]++
    }
}

func main() {
    // arr is an array of 5 ints
    arr := [5]int{1, 2, 3, 4, 5}

    // arr[start:end] is a slice that refers to
    // arr[start], arr[start+1], ..., arr[end-1]
    var sl []int = arr[1:4]
    for i := 0; i < len(sl); i++ {
        fmt.Printf("sl[%v]: %v\n", i, sl[i])
    }
    fmt.Println()

    incAll(sl)
    // sl is modified
    for i := 0; i < len(sl); i++ {
        fmt.Printf("sl[%v]: %v\n", i, sl[i])
    }
    fmt.Println()

    // you can use make to create a slice directly, e.g. s is a slice of ints
    // with length 10 and capacity 15
    // s := make([]int, 10, 15)
    s := []int{5, 3, 7, 8, 9, 5}
    fmt.Println("Length of s:", len(s))
    fmt.Println("Capacity of s:", cap(s))
    for i := range s {
        s[i] = i
    }
    for i := 0; i < len(s); i++ {
        fmt.Printf("s[%v]: %v\n", i, s[i])
    }
    fmt.Println()
}
