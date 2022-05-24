// tokenizer2.go

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
    "unicode"  // isDigit is here
)

//
// Helper function that returns s in quotes, e.g. quote("yes!") returns
// "\"yes!\"".
//
func quote(s string) string {
    return "\"" + s + "\""
}

//
// tokenType is a brand new type that has the same underlying implementation
// as an int. But int and tokenType are *not* synonyms, they are different
// types. This helps us avoid confusing ints with tokenTypes.
//
type tokenType int

//
// This creates 4 read-only constant values of type tokenType.
//
// iota assigns each constant a different tokenType, starting at 0 and then
// incrementing by 1.
//
const (
    open_brace tokenType = iota
    close_brace
    comma
    integer
)

//
// Converts a tokenType value into a human-readable string. A method with this
// signature implements the Stringer interface, so this function will be
// called whenever a standard print function needs a string representation of
// a value.
//
func (tt tokenType) String() string {
    switch tt {
    case open_brace  : return "open_brace"
    case close_brace : return "close_brace"
    case comma       : return "comma"
    case integer     : return "integer"
    default          : return "unknown"
    }
}

type Token struct {
    token string    // the token as a string
    kind  tokenType // the type of the token
    start int       // index in the string where the token starts
}

func makeOpenBrace(start int) *Token {
    return &Token{"{", open_brace, start}
}

func makeCloseBrace(start int) Token {
    return Token{"}", close_brace, start}
}

func makeComma(start int) Token {
    return Token{",", comma, start}
}

//
// Print a token in a human-readable format. 
//
// A method with this signature implements the Stringer interface, so this
// function will be called whenever a standard print function needs a string
// representation of a value.
//
func (t Token) String() string {
    return fmt.Sprintf("Token{%v, %v, %v}", quote(t.token), t.kind, t.start)
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
    //
    // sample stings for testing
    //
    s := "{34, 0, 992}   "
    // s := " {    34     ,0,   992    }   "
    // s := "},, { 349"

    fmt.Printf("s = %v\n", quote(s))

    //
    // This loop is the tokenizer. It processes one character at a time.
    //
    tokens := []Token{}
    for i := 0; i < len(s);  {
        switch s[i] {
        case ' ', '\n', '\t', '\r': // ignore whitespace
            i++
        case '{':
            tok := makeOpenBrace(i)
            tokens = append(tokens, tok)
            i++
        case '}':
            tok := makeCloseBrace(i)
            tokens = append(tokens, tok)
            i++
        case ',':
            tok := makeComma(i)
            tokens = append(tokens, tok)
            i++
        case '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
            begin := i
            end := firstNonDigit(s, i+1)
            tok := Token{s[begin:end], integer, begin}
            tokens = append(tokens, tok)
            i = end
        default:
            fmt.Printf("unknown character: '%c' (%v)\n", s[i], s[i])
            i++
        } // switch
    } // for

    //
    // print the tokens
    //
    for i, t := range tokens {
        fmt.Printf("%v. %v\n", i+1, t)
    }
} // main
