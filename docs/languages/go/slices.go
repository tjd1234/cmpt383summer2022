// slices.go

//
// A slice is a "fat" pointer, i.e. a slice is a data structure that refers to
// a contiguous sequence of an elements of an underlying array.
//
// A slice data structure contains this information:
//
// - a pointer to the starting element of the underlying array
// - the length of the slice, i.e. the number of elements in the slice
// - the capacity of the slice, i.e. the number of elements in the underlying
//   array
//
// In most cases, slices are preferred over arrays. The size of an array never
// changes, and is also part of the arrays type, e.g. an array of 3 ints is
// completely different type than an array of 4 ints. This makes it hard to
// write general-purpose functions, such as sum, for arrays.
//

package main

import (
    "fmt"
)


//
// Returns the sum of the elements in slice a.
//
func sum(a []int) int {
    result := 0
    for i := 0; i < len(a); i++ {
        result += a[i]
    }
    return result
}

// Slices contain a pointer to their underlying array, and so when you pass a
// slice to a function no copy of the underlying array is made, i.e. it acts
// as if the array were passed by reference.
func incAll(s []int) {
    for i := 0; i < len(s); i++ {
        s[i]++
    }
}

func main() {
    // arr is an array (not a slice) of 5 ints
    arr := [5]int{1, 2, 3, 4, 5}

    // 
    // This line causes a compiler error because arr is an array, but
    // sum expects a slice:
    //
    // fmt.Println(sum(arr))
    //

    // arr[start:end] evaluates to a slice that refers to
    // arr[start], arr[start+1], ..., arr[end-1]
    var sl []int = arr[1:4]
    for i := 0; i < len(sl); i++ {
        fmt.Printf("sl[%v]: %v\n", i, sl[i])
    }
    fmt.Printf("sum(%v) = %v\n", sl, sum(sl))
    fmt.Println()

    //
    // range is useful way to get the index and elements of a slice. This
    // for-loop prints the same thing as the one above.
    //
    for i, x := range sl {
        fmt.Printf("sl[%v]: %v\n", i, x)
    }
    fmt.Println()

    //
    // When you pass a slice to a function, the underlying array is *not*
    // copied. So passing a slice acts like pass-by-reference, and the
    // function can modify the passed-in slice.
    //
    incAll(sl)
    for i, x := range sl {
        fmt.Printf("sl[%v]: %v\n", i, x)
    }
    fmt.Println()

    //
    // You can use make to create a slice directly, e.g.:
    //
    //    s := make([]int, 10, 15)
    //
    // s is a new slice of ints with length 10 and capacity 15
    //
    s := []int{5, 3, 7, 8, 9, 5}
    fmt.Println("Length of s:", len(s))
    fmt.Println("Capacity of s:", cap(s))

    //
    // range with a single variable gets the index of the slice.
    // This initializes slice s to {0, 1, 2, 3, 4, 5}.
    //
    for i := range s {
        s[i] = i
    }
    for i, x := range s {
        fmt.Printf("s[%v]: %v\n", i, x)
    }
    fmt.Println()

    //
    // The built-in append(a, x) function will add item x to the right end of
    // slice a, re-sizing the underlying array if necessary.
    //
    names := []string{"Ken", "Rob", "Andrew"}
    fmt.Println(names)
    names = append(names, "Diane")
    fmt.Println(names)

    //
    // The ... notation will append an entire slice.
    //
    otherNames := []string{"Olivia", "Ray", "Dana"}
    names = append(names, otherNames...)
    fmt.Println(names)
} // main
