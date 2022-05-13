// wordcount.go

//
// Count the number of words in a file, and print a list of the top N most
// frequently occurring words.
//
// For words with the same count, sort them by alphabetical order in the
// resulting list.
//
// Convert all uppercase letters A-Z to lowercase a-z, and replace characters
// that are not a-z with spaces.
//

package main

import (
    "fmt"
    "io/ioutil"
    "regexp"
    "sort"
    "strings"
)

func main() {
    //
    // Open the file. ioutil.ReadFile is a utility function that reads all the
    // lines of a file in a slice of bytes.
    //
    fname := "austenPandP.txt" // "short.txt"
    bytes, err := ioutil.ReadFile(fname)
    if err != nil {
        panic("Couldn't open file!")
    }

    //
    // Convert letters to lowercase, non-letters to spaces.
    //
    content := strings.ToLower(string(bytes))
    rep := regexp.MustCompile(`[^a-z]`)
    processedContent := rep.ReplaceAllString(content, " ")

    //
    // Create an array of all the words.
    //
    words := strings.Split(processedContent, " ")

    //
    // Trim any extra whitespace at the beginning or end of the strings.
    //
    for i := range words {
        words[i] = strings.TrimSpace(words[i])
    }
 
    //
    // Create a map of the counts of all the words. A map is hash table.
    //
    freq := map[string]int{}
    for _, w := range words {
        if len(w) > 0 {
            freq[w] += 1
        }
    }

    //
    // Create a key-value struct to for sorting the frequencies.
    //
    type kv struct {
        key string
        val int
    }

    //
    // Copy the frequencies into a slice of key-value pairs.
    //
    var arr []kv
    for k, v := range freq {
        arr = append(arr, kv{k, v})
    }

    //
    // First sort alphabetically by word (the key).
    //
    sort.SliceStable(arr, func(i, j int) bool {
        return arr[i].key < arr[j].key
    })

    //
    // Sort from most frequent to least frequent.
    //
    sort.SliceStable(arr, func(i, j int) bool {
        return arr[i].val > arr[j].val
    })

    //
    // Print the top N most frequently occurring words.
    //
    N := 10
    for i, pair := range arr[:N] {
        fmt.Printf("%v. %v (%v)\n", i + 1, pair.key, pair.val)
    }
}
