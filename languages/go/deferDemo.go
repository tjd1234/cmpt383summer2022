// deferDemo.go

//
// Go has no exceptions, and instead handles error through a combination of
// returning error values, deferring statements, and calls to panic (i.e. a
// panic call immediately ends the program in a controlled way).
//
// Function calls can be deferred in Go. A deferred function call is executed
// when a function finishes. The deferred function is called no matter how the
// function ends, e.g. normally, or due to an error. This is useful in
// situations where an error might occur and you need to run some clean-up
// code whether or not an error occurs.
//
// The line
//
//    defer funcCall
//
// causes funcCall to be executed at the end of the function that the defer is
// in.
//
// If there are multiple calls to defer, then the deferred function calls are
// added in stack order, e.g.:
//
//    defer funcCall1
//    // ...
//    defer funcCall2
//    // ...
//    defer funcCall3
//    // ...
//
// When the function ends, first funcCall3 is executed, then funcCall2, then
// funCall1.
//

package main

import "fmt"

func main() {
    test1()
    fmt.Println()
    test2()
    fmt.Println()
    test3()
    fmt.Println()
    test4()
    // fmt.Println()
    // test5()
}

func test1() {
    fmt.Println("grapes")
    fmt.Println("are")
    fmt.Println("delicious")
}

func test2() {
    defer fmt.Println("grapes (deferred)")
    fmt.Println("are")
    fmt.Println("delicious")
}

func test3() {
    defer fmt.Println("grapes (deferred)")
    defer fmt.Println("are (deferred)")
    defer fmt.Println("delicious (deferred)")
}

// Strange, but possible!
func test4() {
    for i := 0; i < 10; i++ {
        fmt.Println(i)
        defer fmt.Println(i)
    }
}

//
// Here we use defer to print a emssage after a function finishes. this coudl
// be useful for debugging.
//
func test5() {
    fmt.Println("test5() called ...")
    defer fmt.Println("... test5() finished")

    fmt.Print("How old are you? ")
    var age int
    _, err := fmt.Scanf("%d", &age)
    if err == nil {
        fmt.Printf("In 5 years you'll be %v!\n", age + 5)
    }
}
