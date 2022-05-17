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
    fname := "austenPandP.txt"
    // fname := "short.txt"
    bytes, err := ioutil.ReadFile(fname)
    if err != nil {
        panic("Couldn't open file!")
    }

    //
    // Convert letters to lowercase, non-letters to spaces.
    //
    content := strings.ToLower(string(bytes))

    // These two lines convert all non-lowercase letters to spaces.
    rep := regexp.MustCompile(`[^a-z]`)
    processedContent := rep.ReplaceAllString(content, " ")

    //
    // Create an array of all the words.
    //
    // strings.Split returns a slice of strings of all the space-separated
    // words in a string. For example, strings.Split("one two three") returns
    // {"one", "two", "three"}.
    //
    words := strings.Split(processedContent, " ")

    //
    // Remove any extra whitespace at the beginning or end of the strings.
    //
    for i := range words {
        words[i] = strings.TrimSpace(words[i])
    }
 
    //
    // Create a map of the counts of all the words. A map is a hash table. The
    // keys are strings, and the corresponding values are the count of the
    // number of times the string appears.
    //
    // The map is created initially empty. If a string w is not in the map,
    // then freq[w] returns 0, i.e. the zero-value for the type int. This
    // quite convenient in this situation. Many other languages deal with
    // values not in a map by raising an error.
    //
    freq := map[string]int{}
    for _, w := range words {
        if len(w) > 0 {
            freq[w] += 1
        }
    }

    //
    // Create a key-value struct for sorting the frequencies.
    //
    type kv struct {
        key string // a word
        val int    // number of times the word occurs
    }

    //
    // Copy the frequencies into a slice of key-value pairs.
    //
    var arr []kv
    for k, v := range freq {
        arr = append(arr, kv{k, v})
    }

    //
    // We want the result printed in order from most frequent to leat
    // frequent, and for words with the same frequency we want those sorted
    // alphabetically.
    //
    // So we sort twice using a stable sort.
    //
    // First sort alphabetically by word (the key).
    //
    // sort.SliceStable is a standard Go sorting function, and it takes as
    // input a slice (of any type) to sort and a comparison function for
    // comparing two elements in arr.
    cmp := func(i, j int) bool {
        return arr[i].key < arr[j].key
    }
    sort.SliceStable(arr, cmp)

    //
    // Then sort from most frequent to least frequent.
    //
    sort.SliceStable(arr, func(i, j int) bool {
        return arr[i].val > arr[j].val  // note > instead of <
    })

    //
    // Print the top N most frequently occurring words.
    //
    N := 100
    for i, pair := range arr[:N] {
        fmt.Printf("%v. %v (%v)\n", i + 1, pair.key, pair.val)
    }
} // main
