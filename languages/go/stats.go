// stats.go

//
// Read a text file of real numbers, one per line, and calculate their min,
// max, median, sum, average, and standard deviation (populations version, not
// the sample version).
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
    // Open the file.
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
    // Read the numbers int a slice.
    //
    var nums []float64
    scanner := bufio.NewScanner(f)
    for scanner.Scan() {
        s := scanner.Text()
        x, err := strconv.ParseFloat(s, 64)
        if err != nil {
            panic("Error reading file")
        }
        nums = append(nums, x)
    }

    sort.Float64s(nums)
    fmt.Println(nums)

    // print statistics
    fmt.Println("      Min:", min(nums))
    fmt.Println("   Median:", nums[len(nums)/2])
    fmt.Println("      Max:", nums[len(nums)-1])
    fmt.Println("      Sum:", sum(nums))
    fmt.Println("     Mean:", mean(nums))
    fmt.Println("Std. dev.:", std_dev(nums))
} // main

func sum(nums []float64) (result float64) {
    for _, x := range nums {
        result += x
    }
    return
}

func mean(nums []float64) float64 {
    return sum(nums) / float64(len(nums))
}

func min(nums []float64) float64 {
    result := nums[0]
    for _, x := range nums {
        if x < result {
            result = x
        }
    }
    return result
}

func max(nums []float64) float64 {
    result := nums[0]
    for _, x := range nums {
        if x > result {
            result = x
        }
    }
    return result
}

func median(nums []float64) float64 {
    sort.Float64s(nums)
    return nums[len(nums) / 2]
}

func std_dev(nums []float64) (result float64) {
    avg := mean(nums)
    for _, x := range nums {
        diff := x - avg
        result += diff * diff
    }
    return math.Sqrt(result)
}
