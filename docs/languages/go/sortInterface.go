// sortInterface.go

/*

Go provides a general-purpose sorting function in its "sort" package. To sort
a slice of value of some type []T, []T must implement the sort.Interface
interface:

    type Interface interface {
        // Len is the number of elements in the collection.
        Len() int

        // Less reports whether the element with index i must sort before the
        // element with index j.
        Less(i, j int) bool

        // Swap swaps the elements with indexes i and j.
        Swap(i, j int)
    }

The sort package also has a number of handy type-specific functions for
sorting slices of of built-in types.

*/

package main

import (
    "fmt"
    "sort"
)

type Person struct {
    name string
    age int
}

func (p Person) String() string {
    return fmt.Sprintf("{%v, %v}", p.name, p.age)
}

//
// sorting by name
//
type ByName []Person

func (p ByName) Len() int {
    return len(p)
}

func (p ByName) Less(i, j int) bool {
    return p[i].name < p[j].name
}

func (p ByName) Swap(i, j int) {
    p[i], p[j] = p[j], p[i]
}

//
// sorting by age
//
type ByAge []Person

func (p ByAge) Len() int {
    return len(p)
}

func (p ByAge) Less(i, j int) bool {
    return p[i].age < p[j].age
}

func (p ByAge) Swap(i, j int) {
    p[i], p[j] = p[j], p[i]
}

func main() {
    people := []Person{
        Person{"Bob", 20}, Person{"Barb", 30}, Person{"Zia", 40},
        Person{"Bob", 32}, Person{"Warren", 65}, Person{"Asa", 50},
    }
    fmt.Println("unsorted:", people)
    
    sort.Sort(ByName(people))
    fmt.Println(" by name:", people)

    sort.Sort(ByAge(people))
    fmt.Println("  by age:", people)
}
