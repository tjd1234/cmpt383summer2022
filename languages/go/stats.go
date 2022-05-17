// stats.go

//
// Read a text file of real numbers, one per line, and calculate their min,
// max, median, sum, average, and standard deviation (populations version, not
// sample version).
//

package main

import (
    "bufio"
    "fmt"
    "math"
    "os"
    "sort"
    "strconv"
)

func main() {
    //
    // Open the file.
    //
    f, err := os.Open("numbers.txt")
    if err != nil {
        panic("Couldn't open file!")
    }
    //
    // f.Close() is deferred, meaning it will be called when the main function
    // ends, even if it ends due to an error.
    //
    defer f.Close()

    //
    // Read the numbers into a slice.
    //
    var nums []float64
    scanner := bufio.NewScanner(f)
    for scanner.Scan() {
        // get the next string in the file
        s := scanner.Text()

        // convert the stringt to a float
        x, err := strconv.ParseFloat(s, 64)

        // check for errors
        if err != nil {
            panic("Error reading file")
        }

        // add the numbers to the slice of nums
        nums = append(nums, x)
    }

    //
    // Sort the numbers into ascending order using one of Go's built-in
    // sorting functions.
    //
    // sort.Float64s(nums)
    // fmt.Println(nums)

    //
    // Print statistics
    //
    fmt.Println("      Min:", min(nums))
    // fmt.Println("   Median:", nums[len(nums)/2])
    fmt.Println("   Median:", median(nums))
    // fmt.Println("      Max:", nums[len(nums)-1])
    fmt.Println("      Max:", max(nums))
    fmt.Println("      Sum:", sum(nums))
    fmt.Println("     Mean:", mean(nums))
    fmt.Println("Std. dev.:", std_dev(nums))
} // main

//
// Returns the sum of all the floats in nums.
//
func sum(nums []float64) (result float64) {
    // _ is the anonymous variable, used when we need a variable but don't use
    // it anywhere afterwards
    for _, x := range nums {
        result += x
    }
    return
}

//
// Returns the average of the floats in nums.
//
func mean(nums []float64) float64 {
    return sum(nums) / float64(len(nums))
}

//
// Returns the small float in nums.
//
func min(nums []float64) float64 {
    result := nums[0]
    for _, x := range nums {
        if x < result {
            result = x
        }
    }
    return result
}

//
// Returns the biggest float in nums.
//
func max(nums []float64) float64 {
    result := nums[0]
    for _, x := range nums {
        if x > result {
            result = x
        }
    }
    return result
}

//
// Returns the median value of nums, i.e. the middlemost float in nums after
// it is sorted.
//
func median(nums []float64) float64 {
    // Don't want to modify the passed-in slice, so make a copy.
    a := append([]float64{}, nums...)
    n := len(a)
    sort.Float64s(a)

    if n % 2 == 1 {  // n is odd
        // For an odd length list, the median is the middlemost number.
        return a[(n-1) / 2]
    } else {         // n is even
        // For an even length length list, the median is the average of the
        // middlemost numbers.
        return (a[(n/2)-1] + a[n/2]) / 2.0
    }
}

//
// Returns the standard deviation of nums.
//
func std_dev(nums []float64) float64 {
    avg := mean(nums)
    result := 0.0
    for _, x := range nums {
        diff := x - avg
        result += diff * diff
    }
    return math.Sqrt(result)
}
