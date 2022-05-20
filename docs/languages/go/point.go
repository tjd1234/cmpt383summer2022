// point.go

package main

import (
    "fmt"
    "math"
)

type Point struct {
    x, y float64
}

//
// This is a method. The parameter before the name is the method's receiver.
// Methods with the signature String() string implement the Stringer
// interface, which is pre-defined by Go. Funcions like Sprintf work with
// values that implement Stringer.
//
func (p Point) String() string {
    return fmt.Sprintf("(%v, %v)", p.x, p.y)
}

//
// Returns true if p and q are the same, and false otherwise.
//
func (p Point) equal(other Point) bool {
    return p.x == other.x && p.y == other.y
}

//
// Returns the distance between p and q.
//
func (p Point) dist(other Point) float64 {
    dx := p.x - other.x
    dy := p.y - other.y
    return math.Sqrt(dx*dx + dy*dy)
}

//
// Adds another point to the point p points to. The point is modified
// in-place.
//
// p is passed as a pointer here to allow the Point it points to be modified.
// Try removing the * to see what happens.
//
// Notice that even though p is a pointer, Go uses the same .-notation as with
// non-pointer values.
//
func (p *Point) add(other Point) {
    p.x += other.x
    p.y += other.y
}

// func makeRational(n, d int) (Rational, error) {
//     if d == 0 {
//         // ... error ...
//     }
//     return Rational{n, d}
// }

func main() {
    // r, err := makeRational(4, 0)

    p := Point{0, 1}
    q := Point{4, 3}
    fmt.Printf("p = %v, q = %v\n", p, q)
    p.add(Point{1,1})
    fmt.Printf("p = %v, q = %v\n", p, q)
    fmt.Printf("dist(%v, %v) = %v\n", p, q, p.dist(q))
}
