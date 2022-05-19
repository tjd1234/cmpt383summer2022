# Getting Started with Go

For general help about Go, check out the [Go tutorial getting started
page](https://go.dev/doc/tutorial/getting-started).

## Tour of Go

To learn the basics of Go, please work through [the Go
tour](https://go.dev/tour/list). Try the coding exercises they give as
practice.

In particular:

- **Read this**: [Packages, variables, and
  functions](https://go.dev/tour/basics)

- **Read this**: [Flow control statements: for, if, else, switch and
  defer](https://go.dev/tour/flowcontrol/1)

  + Exercise: square root using Newton's method

- **Read this**: [More Types: structs, slices, and
  maps](https://go.dev/tour/moretypes/1)

- **Read this**: [Methods and interfaces](https://go.dev/tour/methods/1)

Our study of Go will essentially follow the topics in this tutorial.


## Go Lecture Schedule

### Lecture 1: Go, Basics
### Lecture 2: Go, Basics

- [hello_world.go](languages/go/hello_world.go)
- [hello_name.go](languages/go/hello_name.go)
- [count_up.go](languages/go/count_up.go)
- [count_down.go](languages/go/count_down.go)
- [primes.go](languages/go/primes.go)

### Lecture 3: Go, Arrays, Slices, Maps, and Strings

### Lecture 4: Go, Arrays, Slices, Maps, and Strings

### Lecture 5: Go, Methods and Interfaces

### Lecture 6: Go, Methods and Interfaces

### Lecture 7: Concurrency

```go
package main

import (
  "fmt"
  "math"
)

func Sqrt(x float64) float64 {
  z := x / 2
  zold := 0.0
  //for i := 0; i < 10; i++ {
  for i := 0; math.Abs(z-zold) > 0.0001; i++ {
    fmt.Println(i, z)
    zold = z
    z -= (z*z - x) / (2 * z)
  }
  return z
}

func main() {
  n := 100.0
  fmt.Println(Sqrt(n))
  fmt.Println(math.Sqrt(n), " (library sqrt)")
}
```

- Do this: https://go.dev/tour/moretypes
  + Slices exercise

```go
package main

import "golang.org/x/tour/pic"

func Pic(dx, dy int) [][]uint8 {
  result := [][]uint8{}
  for y := 0; y < dy; y++ {
    row := []uint8{}
    for x := 0; x < dx; x++ {
      // change x*y in this line to see different results 
      row = append(row, uint8(x*y))
    }
    result = append(result, row)
  }
  return result
}

func main() {
  pic.Show(Pic)
}
```

  + Word count exercise

```go
package main

import (
  //"fmt"
  "strings"

  "golang.org/x/tour/wc"
)

func WordCount(s string) map[string]int {
  result := map[string]int{}
  //fmt.Println(strings.Fields(s))
  for _, w := range strings.Fields(s) {
    result[w]++
    //fmt.Println(w)
  }
  return result // map[string]int{"x": 1}
}

func main() {
  wc.Test(WordCount)
}
```

  + Fibonacci closure exercise

```go
package main

import "fmt"

// fibonacci is a function that returns
// a function that returns an int.
func fibonacci() func() int {
  a, b := 0, 1
  return func() int {
    result := a
    a, b = b, a+b
    return result
  }
}

func main() {
  f := fibonacci()
  for i := 0; i < 10; i++ {
    fmt.Println(f())
  }
}
```

- Do this: https://go.dev/tour/methods

  + `Stringer` implementation exercise

```go
package main

import "fmt"

type IPAddr [4]byte

// TODO: Add a "String() string" method to IPAddr.

func (ip IPAddr) String() string {
  return fmt.Sprintf("%v.%v.%v.%v", ip[0], ip[1], ip[2], ip[3])
}

func main() {
  hosts := map[string]IPAddr{
    "loopback":  {127, 0, 0, 1},
    "googleDNS": {8, 8, 8, 8},
  }
  for name, ip := range hosts {
    fmt.Printf("%v: %v\n", name, ip)
  }
}
```

  + `Error` implementation exercise

```go
package main

import (
  "fmt"
  "math"
)

//func (e *MyError) Error() string {
//  return fmt.Sprintf("at %v, %s",
//    e.When, e.What)
//}

//func Sqrt(x float64) (float64, error) {
//  return 0, nil
//}

//type error interface {
//    Error() string
//}

type ErrNegativeSqrt float64

func (e ErrNegativeSqrt) Error() string {
  return fmt.Sprintf("Can't Sqrt negative: %v", float64(e))
}

func Sqrt(x float64) (float64, error) {
  if x < 0 {
    return 0.0, ErrNegativeSqrt(x)
  }
  z := x / 2
  zold := 0.0
  for i := 0; math.Abs(z-zold) > 0.0001; i++ {
    fmt.Println(i, z)
    zold = z
    z -= (z*z - x) / (2 * z)
  }
  return z, nil
}

func main() {
  fmt.Println(Sqrt(2))
  fmt.Println(Sqrt(-2))
}
```

+ `Reader` exercise 1 (not very good: artificial and confusing example)

```go
package main

import "golang.org/x/tour/reader"

// func (T) Read(b []byte) (n int, err error)

type MyReader struct{}

// TODO: Add a Read([]byte) (int, error) method to MyReader.

func (r MyReader) Read(b []byte) (n int, err error) {
  for i := 0; i < len(b); i++ {
    b[i] = 'A'
  }
  return len(b), nil
}

func main() {
  reader.Validate(MyReader{})
}
```

+ rot13Reader example is also very difficult for beginners, not well
  explained; needs simpler examples to work up to it

+ Images example might be a bit better, not sure. Need to try it. Still rather
  abstract, unclear why anyone would bother with this rigamarole. The use of
  the empty `struct{}` is confusing.

- Do this: https://go.dev/tour/concurrency

  + Equivalent binary tree and web crawler examples are rather involved, and
    may be a lot of work given the terse explanation of the concepts. Students
    not already familiar with concurrent programming may find it frustratingly
    difficult.

- Do this: https://go.dev/tour/generics
  + Only two slides, single-example discussion of generic functions and types.
    One open-ended example of a generic list.

## Go Questions

- Give the definition of a Go `struct` called `Point` that represents an (x,
  y) point, where `x` and `y` are both 64-bit floating point values. Also,
  give a single Go statement that declares a new `Point` variable `p` with `x`
  initialized to 3.2 and `y` initialized to -7.5.

- Given a piece of Go code that uses `defer`, what gets printed?

- Given a piece of Go code that uses `switch`, what gets printed?

- Explain the function name capitalization rule in Go.

- Give three different ways to define a new `int` variable called `n` that has
  an initial value of 25.

- Write a fragment of Go code that uses a loop to print the numbers from 100
  down to 1.

- Write a function that returns the min value in a slice of integers. Your
  function should return two values: the min value and a boolean error value
  that is `true` if a min was found, and `false` if the array is empty.

- Write a fragment of Go code that creates a new slice of size 1000, and
  initializes it to the values {0, 1, 2, ..., 999}. Then write a function
  called sum that takes an int slice as input and returns the sum of the
  elements in it.

- Using closures, right a function `f` that takes no inputs, and every time
  you call it it returns the next square number. The first time `f()` is
  called it evaluates to 1, the next it is called it evaluates to 4, and so
  on.

- What is the name of the kind of value that is used to allow information to
  be passed concurrently running goroutines?
