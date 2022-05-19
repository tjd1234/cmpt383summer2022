// hello_name.go

package main

import "fmt"

func main() {
    fmt.Print("What's your name? ")
    var name string
    fmt.Scanf("%s", &name)
    fmt.Println("Good day " + name + ", how are you?")
}
