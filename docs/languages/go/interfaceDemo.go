// interfaceDemo.go

package main

import (
    "fmt"
)

//////////////////////////////////////////////////////////////////////////////

type Person struct {
    name string
    age  int
}

// 
// Stringer is a standard built-in interface that has only one method:
//
//    type interface Stringer {
//       String() string
//    }
//
// Functions in fmt, such as fmt.Printf and fmt.Println, use Stringer to
// convert values to strings.
//
func (p Person) String() string {
    return fmt.Sprintf("Person(%v, %v)", p.name, p.age)
}

//////////////////////////////////////////////////////////////////////////////

type Counter interface {
    incr(n int)    // increment the counter by n
    getCount() int // the current value of the counter
    reset()        // set the counter to 0
}

//////////////////////////////////////////////////////////////////////////////

//
// An example of a struct type that implements Counter.
//
type NamedCount struct {
    name  string
    count int
}

func (nc *NamedCount) incr(n int) { // increment the counter by n
    nc.count += n
}

func (nc NamedCount) getCount() int { // the current value of the counter
    return nc.count
}

func (nc *NamedCount) reset() { // set the counter to 0
    nc.count = 0
}

//////////////////////////////////////////////////////////////////////////////

//
// BasicCount is a brand new type that is different than int. Notice we must
// explicitly convert between int and BasicCount in the code.
//
// BasicCount and int both have the same internal implementation.
//
type BasicCount int

func (bc *BasicCount) incr(n int) { // increment the counter by n
    *bc += BasicCount(n)
}

func (bc BasicCount) getCount() int { // the current value of the counter
    return int(bc)
}

func (bc *BasicCount) reset() { // set the counter to 0
    *bc = 0
}

//////////////////////////////////////////////////////////////////////////////

// All we about the passed-in value c is that it implements the Counter
// interface, and so the incr, getCount, and reset methods can be called on
// it.
func testCounter(c Counter) {
    fmt.Println(c.getCount())
    c.incr(1)
    c.incr(1)
    fmt.Println(c.getCount())
    c.reset()
    fmt.Println(c.getCount())
}

func main() {
    a := &NamedCount{"Test counter", 0} // a is defined as pointer to a 
    testCounter(a)                      // NamedCount because Counter has
                                        // some pointer receivers
    fmt.Println()

    b := BasicCount(0)
    testCounter(&b) // b is passed as pointer because Counter has pointer
}                   // receivers
