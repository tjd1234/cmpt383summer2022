The weekly schedule of topics is below. Although no changes are planned, it is
possible that changes are made as the course progresses.

[Assignments are here](../assignments/assignments.md).

## Week 1 Go

- [Notes on Go](go/go_notes.md) 

## Week 2 Go

- [Notes on Go](go/go_notes.md) 

## Week 3 Go, Ruby

- [Notes on Go](go/go_notes.md) 
- [Notes on Ruby](ruby/ruby_notes.md)

## Week 4 Ruby
- [Notes on Ruby](ruby/ruby_notes.md)

## Week 5 Ruby, Racket
- [Notes on Ruby](ruby/ruby_notes.md)
- [Notes on Racket](racket/racket_notes.md)

## Week 6 Racket
- [Notes on Racket](racket/racket_notes.md)

## Week 7 Racket
- [Notes on Racket](racket/racket_notes.md)

## Week 8 Haskell
- [Notes on Haskell](haskell/haskell_notes.md)

## Week 9 Haskell
- [Notes on Haskell](haskell/haskell_notes.md)

## Week 10 Haskell, Prolog
- [Notes on Haskell](haskell/haskell_notes.md)
- [Notes on Prolog](prolog/prolog_notes.md)

## Week 11 Prolog
- [Notes on Prolog](prolog/prolog_notes.md)

## Week 12 Prolog
- [Notes on Prolog](prolog/prolog_notes.md)

## Week 13 Wrap-up


## Terminology

**token**: In a programming language, a token is a string that represents
something in a language. For example, in Go, `for`, `i`, `:=`, `{`, and `}`
are all examples of tokens. Tokens can usually be separate by 1 or more
whitespace characters, and in some cases tokens don't need any whitespace
separation. For example, `var i int` consists of three tokens, and there must
be at least one space after `var` and one after `i` (otherwise you would get
`variint`). However, `i:=0` also consists of three tokens (`i`, `:=`, and
`0`), and no whitespace is needed to separate them (although some spacing
would help readability).

**tokenization**: The process of splitting a string into its constituent
tokens. For example, given the Go source code `i := 3`, after tokenization it
would be split into something like `[("i", identifier), (":=", shortvardecl),
("3", int)]`. Tokenization typically removes all whitespace and associates a
token type with each token. This makes it much easier to process later. Also
know as **lexing**.

**whitespace characters**: A character such as space, newline `\n`, tab `\t`,
or return `\r`. On white paper, they are not printed and so white is all you
see. Tokens in a programming language can often be separated by multiple
whitespace characters.
