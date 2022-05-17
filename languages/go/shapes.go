// shapes.go

//
// Using the object-oriented features of the language, write a program that
// calculates the area and perimeter of 2D shapes like a square, rectangle,
// and circle. Each shape should also know it's name, e.g. a circle is a
// "Circle", a rectangle is a "Rectangle".
//
// Write a function that takes any shape as input and prints its name, area,
// and perimeter. Test this generic function by creating a list of different
// shapes, and then iterate through the list calling the generic function on
// each shape.
//

package main

import "fmt"

//////////////////////////////////////////////////////

//
// An interface is a list of function headers. In Go, it is conventional for
// an interface name to end with "er".
//
type Shaper interface {
    name() string
    area() float64
    perimeter() float64
}

///////////////////////////////////////////////////////////////////////////////

type Rectangle struct {
    width, height float64
}

//
// In a method, the first parameter is special and is called the receiver. It
// comes before the name of the function.
//
// The code from the function name to the end of the function type is what
// appears in the interface.
//
// Notice that you *don't* say anywhere that Rectangle implements the methods
// in the Shaper interface. The Go compiler automatically checks if all the
// methods implemented.
//
func (r Rectangle) area() float64 {
    return r.width * r.height
}

func (r Rectangle) perimeter() float64 {
    return 2*r.width + 2*r.height
}

func (r Rectangle) name() string {
    return "Rectangle"
}

///////////////////////////////////////////////////////////////////////////////
//
// The implementation details of Circle are different than a Rectangle, but
// they both implement the Shaper interface.
//

type Circle struct {
    radius float64
}

func (c Circle) name() string {
    return "Circle"
}

func (c Circle) area() float64 {
    return 3.14 * c.radius * c.radius
}

func (c Circle) perimeter() float64 {
    return 2 * 3.14 * c.radius
}

//
// diameter is specific to circle, and is not part of the Shaper interface.
//
func (c Circle) diameter() float64 {
    return 2 * c.radius
}

///////////////////////////////////////////////////////////////////////////////

//
// This is a kind of generic function that takes as input any value that that
// implements the Shaper interface. It can only call the methods defined in
// Shaper.
//
func printShapeStats(s Shaper) {
    fmt.Printf("     %v area: %v\n", s.name(), s.area())
    fmt.Printf("%v perimeter: %v\n\n", s.name(), s.perimeter())
}

func main() {
    box := Rectangle{width: 4, height: 1}
    dot := Circle{3}
    shapes := []Shaper{box, dot}
    for _, s := range shapes {
        printShapeStats(s)
    }
}
