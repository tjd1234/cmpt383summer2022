// primes.go

//
// Write a function alled is_prime(n) that returns true if n (and int) is a
// prime number, and false otherwise.
//
// Also write a function called primes_less_than(n) that returns the count of
// the number of integers less than n that are prime.
//
// An integer is prime if it is gSreater than 1, and has exactly two
// divisors, 1 and itself. For example, 2, 3, 5, and 101 are all prime,
// but 9, 15, 77, and 1001 are not prime.
//

package main

import "fmt"

func main() {
    for i := 0; i <= 25; i++ {
        fmt.Println(i, is_prime(i))
    }

    fmt.Println(primes_less_than(10000)) // correct answer: 1229
}

// Returns true if the integer n is prime, and false otherwise.
func is_prime(n int) bool {
    if n < 2 {
        return false
    } else if n == 2 {
        return true
    } else if n % 2 == 0 {
        return false
    } else {
        candidate := 3
        for candidate * candidate <= n {
            if n % candidate == 0 {
                return false
            }
            candidate += 2
        }
        return true
    }
}

// Uses a named return parameter.
func primes_less_than(n int) (result int) {
    for i := 2; i < n; i++ {
        if is_prime(i) {
            result++
        }
    }
    return // required with named return parameter
}

