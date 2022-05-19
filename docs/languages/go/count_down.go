// count_down.go

package main

import "fmt"

func main() {
    fmt.Println("Launch in")
    for i := 10; i > 0; i-- {
        fmt.Printf("... %v\n", i)
    }
    fmt.Println("Blast off!")
}
