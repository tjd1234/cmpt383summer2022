// count_up.go

//
// Write a program that prints "This is sentence i." on the console,
// where i ranges from 1 to 10.
//

package main

import "fmt"

func main() {
    i := 0
    for {
        fmt.Printf("This is sentence %v\n", i)
        i++
    }
}