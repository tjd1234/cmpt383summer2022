// point.go

package main

import (
	"fmt"
)

type Point struct {
	x, y float64
}

// This is a method. The parameter before the name is the method's receiver.
// Methods with the signature String() string implement the Stringer
// interface, which is pre-defined by Go. Funcions like Sprintf work with
// values that implement Stringer.
func (p Point) String() string {
	return fmt.Sprintf("(%v, %v)", p.x, p.y)
}

func main() {
	p := Point{4.5, -0.44}
	q := Point{10, 100}
	fmt.Printf("p = %v, q = %v\n", p, q)
}
