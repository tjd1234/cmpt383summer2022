# Go's Stringer Interface

In Go, an **interface** type consists of a collection of **method
signatures**. For example, the standard interface `Stringer` is defined like
this:

```go
type Stringer interface {
    String() string
}
```

A type is said to *implement* an interface if it has methods for all the
methods listed in it. Type `T` implements `Stringer` if it implements a method
that looks like this:

```go
func (this T) String() string {
	// ... returns a string representation of of T ...
}
```

The parameter `(this T)` that appears before the name is called the **receiver
argument** of the method. Importantly, the receiver does *not* appear in an
interface. This allows different types to implement their own version of
`String()`.

All Go's standard types act as if they implement `Stringer`, but you can't
explicitly call `String()` on them.


## Implementing Your Own Stringer

Suppose you implement your own type `Person`:

```go
type Person struct {
    name string
    age int
}

func main() {
    p := Person{"Bob", 65}
    fmt.Println(p)  // "{Bob 65}"
}
```

When you print `p` with a standard Go function like `fmt.Println`, it uses
Go's default format: `"{Bob 65}"`.

If you want to print `Person` values in some other format, say `Person(Bob,
65)`, you can add your own `String()` method like this:

```go
type Person struct {
    name string
    age int
}

func (p Person) String() string {
    return fmt.Sprintf("Person(%v, %v)", p.name, p.age)
}

func main() {
    p := Person{"Bob", 65}
    fmt.Println(p)  // "Person(Bob, 65)"
}
```

Importantly, the `String()` method must *exactly* match the signature in
`Stringer`. If it does, then the type `Person` is said to implement the
`Stringer` interface. 


## Counter: An Interface for Counting

Lets create our own interface. `Counter` is an interface for values that can
be incremented, read, and reset:

```go
type Counter interface {
    incr(n int)     // increase the counter by n
    getCount() int  // return the current value of the counter
    reset()         // set the counter to 0
}
```

To implement a `Counter`, we need to create a new type that has the three
methods in `Counter`. Here's one way to do it:

```go
type NamedCount struct {
	name  string
	count int
}

// nc is passed as a pointer since the underlying count is modified
func (nc *NamedCount) incr(n int) { // increment the counter by n
	nc.count += n
}

func (nc NamedCount) getCount() int { // the current value of the counter
	return nc.count
}

// nc is passed as a pointer since the underlying count is modified
func (nc *NamedCount) reset() { // set the counter to 0
	nc.count = 0
}

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
	a := &NamedCount{"Test counter", 0}
    testCounter(a)
}
```

Non-struct types can also implement an interface. For example, this
`BasicCount` type works with `testCounter`:

```go
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

// ...

func main() {
    b := BasicCount(0)
    testCounter(&b) // b is passed as pointer because Counter has pointer
}                   // receivers
```

`BasicCount` has the same internal implementation as an `int`, but it's *not*
the same type as `int`, i.e. `int` and `BasicCount` *cannot* be used
interchangeably. You must explicitly convert between the types, as done in the
code above.

Note that `incr` and `reset` both use a *pointer* receiver. That's so the
value can be changed in-place. If you don't use a pointer, then a copy is made
of the receiver parameter.


## Code

Much of the code used in this note is in [interfaceDemo.go](interfaceDemo.go).
