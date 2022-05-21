# Go Notes

## Linux Installation

```bash
sudo apt install golang-go
```

## Basic Usage

Compile and run a Go program:

```bash
$ go run prog.go
```

## Reading

For general help about Go, check out the [Go tutorial getting started
page](https://go.dev/doc/tutorial/getting-started).


### Tour of Go

Please read the following parts of [the Go tour](https://go.dev/tour/list)
(try the coding exercises they give as practice):

- **Read this**: [Packages, variables, and
  functions](https://go.dev/tour/basics)

- **Read this**: [Flow control statements: for, if, else, switch and
  defer](https://go.dev/tour/flowcontrol/1)

- **Read this**: [More Types: structs, slices, and
  maps](https://go.dev/tour/moretypes/1)

- **Read this**: [Methods and interfaces](https://go.dev/tour/methods/1)

## Go Lectures

### Lecture 1,2 Go: Basics

- [hello_world.go](hello_world.go)
- [hello_name.go](hello_name.go)
- [count_up.go](count_up.go)
- [count_down.go](count_down.go)
- [primes.go](primes.go)
- [functionsAndClosures.go](functionsAndClosures.go)

### Lecture 3,4 Go: Arrays, Slices, and Maps

- [slices.go](slices.go)
- [bits.go](bits.go)
- [sort.go](sort.go)
- [stats.go](stats.go)
- [deferDemo.go](deferDemo.go)
- [wordcount.go](wordcount.go)

### Lecture 5,6 Go: Methods and Interfaces

- [sortInterfaces.go](sortInterfaces.go) (demo of Go's standard sort function)
- [interfaceDemo.md](interfaceDemo.md) (and associated code in
  [interfaceDemo.go](interfaceDemo.go))
- More examples: [point.go](point.go), [shapes.go](shapes.go),
  [tokenizer.go](tokenizer.go) and [tokenizer2.go](tokenizer2.go) (declares a
  new type based on `int`)

### Lecture 7 Go: Concurrency

- [concurrency.md](concurrency.md): [spinner.go](spinner.go), [gen.go](gen.go)
