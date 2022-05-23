# CMPT 383, Summer 2022 ... github version!

# Useful Links

- [Assignments](assignments/assignments.md).
- [Installing the languages](install.md) on Ubuntu Linux.
- Language notes: [Go](languages/go/go_notes.md),
  [Ruby](languages/ruby/ruby_notes.md),
  [Racket](languages/racket/racket_notes.md),
  [Haskell](languages/haskell/haskell_notes.md),
  [Prolog](languages/prolog/prolog_notes.md)
- [Grades, announcements, discussions
  (Canvas)](https://canvas.sfu.ca/courses/70067).

You're welcome to clone/download this repository. It will be updated quite
frequently, so be sure to check for changes.


# Weekly Schedule

The weekly schedule of topics is below. No changes are planned, but it's
possible that changes could be made as the course progresses.

## Week 1 Go

- [Go notes](go/go_notes.md) 

## Week 2 Go

- [Go notes](go/go_notes.md) 

## Week 3 Go, Ruby

- [Go notes](go/go_notes.md) 
- [Ruby notes](ruby/ruby_notes.md)

## Week 4 Ruby
- [Ruby notes](ruby/ruby_notes.md)

## Week 5 Ruby, Racket
- [Ruby notes](ruby/ruby_notes.md)
- [Racket notes](racket/racket_notes.md)

## Week 6 Racket
- [Racket notes](racket/racket_notes.md)

## Week 7 Racket
- [Racket notes](racket/racket_notes.md)

## Week 8 Haskell
- [Haskell notes](haskell/haskell_notes.md)

## Week 9 Haskell
- [Haskell notes](haskell/haskell_notes.md)

## Week 10 Haskell, Prolog
- [Haskell notes](haskell/haskell_notes.md)
- [Prolog notes](prolog/prolog_notes.md)

## Week 11 Prolog
- [Prolog notes](prolog/prolog_notes.md)

## Week 12 Prolog
- [Prolog notes](prolog/prolog_notes.md)

## Week 13 Wrap-up


## Terminology

- **token** In a programming language, a token is a string that represents
  something in a language. For example, in Go, `for`, `i`, `:=`, `{`, and `}`
  are all examples of tokens. Tokens can usually be separate by 1 or more
  whitespace characters, and in some cases tokens don't need any whitespace
  separation. For example, `var i int` consists of three tokens, and there
  must be at least one space after `var` and one after `i` (otherwise you
  would get `variint`). However, `i:=0` also consists of three tokens (`i`,
  `:=`, and `0`), and no whitespace is needed to separate them (although some
  spacing would help readability).

- **tokenization** The process of splitting a string into its constituent
  tokens. For example, given the Go source code `i := 3`, after tokenization
  it would be split into something like `[("i", identifier), (":=",
  shortvardecl), ("3", int)]`. Tokenization typically removes all whitespace
  and associates a token type with each token. This makes it much easier to
  process later. Also know as **lexing**.

- **whitespace characters** A character such as space, newline `\n`, tab `\t`,
  or return `\r`. On white paper, they are not printed and so white is all you
  see. Tokens in a programming language are often separated by one or more
  whitespace characters.
