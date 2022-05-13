// sort.go

package main

import (
    "fmt"
    // "sort"
)

//
// Returns a copy of lst with x inserted at location i e.g. insert(9, 2,
// {3,2,1,4}) returns {3, 2, 9, 1, 4}.
//
func insert1(x int, i int, lst []int) []int {
    n := len(lst)
    if i < 0 {
        i = 0
    } else if i > n {
        i = n
    }
    result := make([]int, n+1)
    left, right := lst[:i], lst[i:]
    copy(result, left)
    copy(result[i+1:], right)
    result[i] = x
    return result
}

//
// Another way of writing insert.
//
func insert2(x int, i int, lst []int) []int {
    n := len(lst)
    if i < 0 {
        i = 0
    } else if i > n {
        i = n
    }
    result := make([]int, n+1)
    copy(result, lst[:i])
    copy(result[i+1:], lst[i:])
    result[i] = x
    return result
}

func testEq(a, b []int) bool {
    if len(a) != len(b) {
        return false
    }
    for i := range a {
        if a[i] != b[i] {
            return false
        }
    }
    return true
}

func testInsert(insert func(int, int, []int) []int) {
    testNum := 0
    pass, fail := 0, 0
    check := func (x int, i int, lst []int, expected []int) {
        testNum++
        result := insert(x, i, lst)
        fmt.Printf("test %v: insert(%v, %v, %v) = %v  ", 
                           testNum,  x,  i,  lst,  result)
        if testEq(result, expected) {
            pass++
            fmt.Println("passed")
        } else {
            fail++
            fmt.Printf("test %v FAILED\n", testNum)
        }
    }
    check(9, 0, []int{0,1,2,3,4}, []int{9,0,1,2,3,4})
    check(9, 1, []int{0,1,2,3,4}, []int{0,9,1,2,3,4})
    check(9, 2, []int{0,1,2,3,4}, []int{0,1,9,2,3,4})
    check(9, 3, []int{0,1,2,3,4}, []int{0,1,2,9,3,4})
    check(9, 4, []int{0,1,2,3,4}, []int{0,1,2,3,9,4})
    check(9, 5, []int{0,1,2,3,4}, []int{0,1,2,3,4,9})

    fmt.Printf("Done. %v/%v passed, %v/%v failed\n",
        pass, testNum, fail, testNum)
}

//
// Sorts slice a into ascending sorted order using insertion sort.
//
func insertionSort(a []int) {
    n := len(a)
    if n < 2 { return }  // {}-braces always required in if-statements
    for i := 1; i < n; i++ {
        for j := i; j > 0 && a[j-1] > a[j]; j-- {
            a[j], a[j-1] = a[j-1], a[j]  // swap a[j], a[j-1]
        }
    }
}

//
// Returns true if a is in ascending sorted order, and false otherwise.
//
func isSorted(a []int) bool {
    for i := 1; i < len(a); i++ {
        if a[i-1] > a[i] {
            return false
        }
    }
    return true
}

func testSort(sort func([]int)) {
    data := [][]int{
        []int{}, []int{1}, []int{1,2}, []int{2,1}, []int{2,2}, 
        []int{1,2,3}, []int{3,2,1}, []int{2,1,3},
        []int{8,9,3,1,0,4,-9,3,3,1},
    }
    for i, lst := range data {
        fmt.Printf("test %v: sort(%v): ", i+1, lst)
        sort(lst)
        fmt.Printf(" %v", lst)
        if isSorted(lst) {
            fmt.Println(" passed")
        } else {
            fmt.Println(" FAILED")
        }
    }
}

func main() {
    testInsert(insert2)
    testSort(insertionSort)
}
