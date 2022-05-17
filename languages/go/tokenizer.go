// tokenizer.go

//
// Write a tokenizer for a list of integers like "{9, 343, 0}". The are four
// kinds of tokens: open brace, close braces, commas, and integers.
//
// The tokenizer returns a slice of all the tokens, in the order they occur.
// It does *not* check if the tokens are in a sensible order, e.g. the
// tokenizer will convert non-sensical strings like "},, { 349" into a list of
// tokens without comnplaint.
//

package main

import (
    "fmt"
    "unicode"
)

//
// This creates 4 read-only constant values. It's like an enumerated type.
//
// iota assigns each constant an integer, starting at 0 and then incrementing
// by 1. So open_brace is 0, close_brace is 1, comma is 2, and integer is 3.
//
const (
    open_brace = iota
    close_brace
    comma
    integer
)

type Token struct {
    token string  // the token as a string
    kind int      // the type of the token
}

//
// We want to print tokens in a nice human-readable format, so we implement a
// String method for Token.
//
func (t Token) String() string {
    return fmt.Sprintf("Token{%v, %v}", 
                       quote(t.token), kindToStr(t.kind))
}

func kindToStr(k int) string {
    switch k {
    case open_brace  : return "open_brace"
    case close_brace : return "close_brace"
    case comma       : return "comma"
    case integer     : return "integer"
    default          : return "unknown"
    }
}

//
// Returns s in quotes, e.g. quote("yes!") returns "\"yes!\""
//
func quote(s string) string {
    return "\"" + s + "\""
}

//
// Starting at i, returns the index of the first non-digit character in s.
//
func firstNonDigit(s string, i int) int {
    for i < len(s) && unicode.IsDigit(rune(s[i])) {
        i++
    }
    return i
}

func main() {
    s := "{34, 0, 992}   "
    // s := " {    34     ,0,   992    }   "
    // s := "},, { 349"

    fmt.Printf("s = %v\n", quote(s))

    // process s one character at a time
    tokens := []Token{}
    for i := 0; i < len(s);  {
        switch s[i] {
        case ' ', '\n', '\t', '\r': // ignore whitespace
            i++
        case '{':
            tok := Token{"{", open_brace}
            tokens = append(tokens, tok)
            i++
        case '}':
            tok := Token{"}", close_brace}
            tokens = append(tokens, tok)
            i++
        case ',':
            tok := Token{",", comma}
            tokens = append(tokens, tok)
            i++
        case '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
            begin := i
            end := firstNonDigit(s, i+1)
            tok := Token{s[begin:end], integer}
            tokens = append(tokens, tok)
            i = end
        default:
            fmt.Printf("unknown character: '%c' (%v)\n", s[i], s[i])
            i++
        } // switch
    } // for

    // print the tokens
    for i, t := range tokens {
        fmt.Printf("%v. %v\n", i+1, t)
    }
} // main
