// wordcount.go

//
// Count the number of words in a file, and print a list of the top N most
// frequently occurring words. You can print the top N=10 words by default,
// but it should work with any value of N.
//
// For words with same count, sort them by alphabetical order in the list.
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
    fname := "austenPandP.txt" // "short.txt"
    // open the file
    bytes, err := ioutil.ReadFile(fname)
    if err != nil {
        panic("Couldn't open file!")
    }

    // convert letters to lowercase, non-letters to spaces
    content := strings.ToLower(string(bytes))
    rep := regexp.MustCompile(`[^a-z]`)
    processedContent := rep.ReplaceAllString(content, " ")

    // create an array of all the words
    words := strings.Split(processedContent, " ")

    // trim any extra whitespace
    for i := range words {
        words[i] = strings.TrimSpace(words[i])
    }
 
    // create a map of the counts of all the words
    freq := map[string]int{}
    for _, w := range words {
        if len(w) > 0 {
            freq[w] += 1
        }
    }

    // create a key-value struct to for sorting the frequencies
    type kv struct {
        key string
        val int
    }

    // copy the frequencies into an array of key-value pairs
    var arr []kv
    for k, v := range freq {
        arr = append(arr, kv{k, v})
    }

    // first sort by alphabetically by word (the key)
    sort.SliceStable(arr, func(i, j int) bool {
        return arr[i].key < arr[j].key
    })

    // sort from most frequent to least frequent
    sort.SliceStable(arr, func(i, j int) bool {
        return arr[i].val > arr[j].val
    })

    for i, pair := range arr[:10] {
        fmt.Printf("%v. %v (%v)\n", i + 1, pair.key, pair.val)
    }
}
