// functionsAndClosures.go

package main

import (
    "fmt"
    "strings"
)

func main() {
    test_makeAdder()
    test_makeIncrementer()
    test_mapstr()
}

//
// Returns a closure (a function with an associated environment of variables)
// that adds n to a given int. In other words, it makes a function that adds n
// to a number.
//
func makeAdder(n int) func(int) int {
    return func(a int) int {
        return a + n
    }
}

//
// In the code below, add5 is a function that takes one int, and returns 5
// plus that int. It's essentially the same as if we'd defined it like this:
//
//    func add5(n int) int {
//       return n + 5
//    }
//
// The difference is that this func version must be completely defined at
// compile-time. But the version below lets us specify the 5 (or any other
// int) at run-time.
//
func test_makeAdder() {
    add5 := makeAdder(5)
    n := 1
    fmt.Printf("n=%v\n", n)
    fmt.Printf("n=%v\n", add5(n))
}


//
// Lets call a value that supports these two operations an incrementer:
//
// - Add 1 (increment)
// - Return the current value
//
// makeIncrementer returns two closures, one for each of these operations.
// Both closures share the same variable n.
//
// The first returned function increments n, and nothing else. It takes no
// input, and returns no value. In object-oriented programming, this would be
// called a **setter**.
//
// The second function gets the current value of n. It takes no input, and
// returns a copy of the int n. In object-oriented programming, this would be
// called a **getter**.
//
func makeIncrementer() (func(), func() int) {
    // n is the value to be incremented
    n := 0
    inc := func() {
        n++
    }
    get := func() int {
        return n
    }
    return inc, get
}

func test_makeIncrementer() {
    inc_a, get_a := makeIncrementer()
    inc_b, get_b := makeIncrementer()
    for i := 1; i <= 5; i++ {
        inc_a() // a is incremented once
        inc_b() // b is incremented twice
        inc_b()
    }
    fmt.Printf("get_a(): %v\n", get_a())
    fmt.Printf("get_b(): %v\n", get_b())
}


//
// mapstr makes a new slice of strings by applying a string function to every
// element of a slice of strings.
//
// The first input, lst, is of type []string, a slice of strings, i.e. a
// sequence of 0 or more strings. The second input, f, is any function that
// takes a string as input and returns a string as output. If lst = [s1, s2,
// ..., sn], then mapstr(lst, f) returns a new slice equal to [f(s1), f(s2),
// ..., f(sn)].
//
// The make function in the first line is a built-on Go function that, among
// other things, creates a new slice. make([]string, len(lst)) creates a new
// slice of strings with length len(lst). len(lst) is the number of elements
// in lst.
//
func mapstr(lst []string, f func(string) string) []string {
    result := make([]string, len(lst))
    for i, s := range lst {
        result[i] = f(s)
    }
    return result
}

func makeTitle(s string) string {
    return "Title: " + s
}

func composeStr(f, g func(string) string) func(string) string {
    return func(s string) {
        return f(g(s))
    }
}

func composeFloat64(f, g func(float64) float64) func(float64) float64 {
    return func(s float64) {
        return f(g(s))
    }
}

func test_mapstr() {
    movies := []string{"star wars", "the godfather", 
                       "everything everywhere all at once"}
    fmt.Println(movies)

    // strings.Title returns a new string with the first letter of each word
    // capitalized
    modMovies := mapstr(movies, strings.Title)
    modMovies = mapstr(modMovies, makeTitle)
    //
    // Question: How can you rewrite these two calls to mapstr in a single
    // line of code?
    //
    fmt.Println(modMovies)
}
