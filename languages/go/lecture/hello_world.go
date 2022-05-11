// hello_world.go

//
// Write a program that prints "Hello, world!" on the console.
//

package main

import "fmt"

func main() {
    fmt.Print("What's your name? ")
    // var name string
    name := 0
    fmt.Scanf("%s", &name)
    fmt.Println("Good day " + name + ", how are you?")
}
