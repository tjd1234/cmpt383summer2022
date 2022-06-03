# Ruby Regular Expressions

A [regular expression](https://en.wikipedia.org/wiki/Regular_expression), or
**regex** for short, is a sequence of characters that specifies a set of
strings. They are often used for pattern-matching in text.

For example, if you ask the user to type a phone number in a web form, they
could type it in many different ways: "(778) 782-3111", "778-782-3111",
"778.782.3111", "7787823111", .... All are correct ways to write a phone
number, and it's possible to write *one* regular expression that matches all
of them.

Most languages that provide support for regular expressions do so in a library
that is imported. Ruby is a bit different: regular expressions are built into
the language itself.


# String Matching: Matching a Digit

To understand Ruby regular expressions, lets look at some concrete examples.

Suppose you want to determine if a string *contains* the digit 5 somewhere
within it. For example, "Year: 1156" has a 5, but "Year: 1647" and "two or
three" don't.

In Ruby you can check for this using regular expressions:

```ruby

>> "Year: 1156" =~ /5/    # returns index of first occurrence of 5
=> 8

>> "5 and 5 and 5" =~ /5/ # =~ matches the first 5 only
=> 0

>> "Year: 1647" =~ /5/    # nil if no match
=> nil
```

`/5/` is an example of a Ruby regular expression. When used with the `=~`
operator, it matches the *first* occurrence of a "5" in a string, and nothing
else. Ruby regular expressions start with `/` and end with `/`. The string
that comes between those describes a set of strings.

Now suppose we want to determine if the *entire* string is "5", not just if a
5
occurs somewhere in it. We can do it like this:

```ruby
>> "5" =~ /^5$/       # ^ matches the start of the string, $ the end
=> 0
>> "5 or 5" =~ /^5$/
nil
```

`^` and `$` are special regular expression symbols. Instead of matching
characters, they match *positions* in a string. `^` matches the *start* of a
string, and `$` matches the *end* of a string. So the regular expression
`/^5$/`
matches *just* the string "5", i.e. the string where the character "5" is
immediately after the start, and immediately before the end.

Now suppose we want to determine if a string *contains* a 5 *or* a 6, or both.
In a regular expression the symbol `|` means "or", and the regular expression
`/5|6/` will match a 5 or a 6:

```ruby
>> "V9U 6M2" =~ /5|6/    # matches the 6
=> 4

>> "Is 5 = 6?" =~ /5|6/  # matches the 5
=> 3

>> "V9U 7M2" =~ /5|6/    # nil is returned if there's no 5 or 6
=> nil
```

Suppose instead of determining if a string *occurs* somewhere in a string, you
want to check if the *entire* string is "5" or the entire string is "6". `^`
(start of string) and `$` (end of string) lets us do that:

```ruby
>> "6" =~ /^(5|6)$/   # ^ matches the start of the string, $ matches the end
=> 0

>> "5" =~ /^(5|6)$/
=> 0

>> "7" =~ /^(5|6)$/
=> nil

>> "Is 5 = 6?" =~ /^(5|6)$/  # only matches "5" or "6"
nil
```

Importantly, you must put the expression you want to match inside
`()`-brackets to avoid ambiguity.

If you want to match, say, *any* digit, you can use `|` multiple times. The
regular expression `/0|1|2|3|4|5|6|7|8|9/` matches any single digit:

```ruby
>> "Score: 5" =~ /0|1|2|3|4|5|6|7|8|9/     # matches the 5
=> 7
>> "1 or 2 or 3" =~ /0|1|2|3|4|5|6|7|8|9/  # matches the 1
=> 0
>> "apple" =~ /0|1|2|3|4|5|6|7|8|9/        # nil if no match
=> nil
```

To match the entire string:

```ruby
>> "4" =~ /^(0|1|2|3|4|5|6|7|8|9)$/     # "4" is a digit
=> 0
>> "45" =~ /^(0|1|2|3|4|5|6|7|8|9)$/    # "45" is not a digit, no match
=> nil
>> "a 3?" =~ /^(0|1|2|3|4|5|6|7|8|9)$/  # "a 3?" is not a digit, no match
=> nil
```

You can store regular expressions in variables:

```ruby
>> digit_regex = /0|1|2|3|4|5|6|7|8|9/
>> digit_regex
=> /0|1|2|3|4|5|6|7|8|9/
>> "1920" =~ digit_regex                 # matches the 1
=> 0
>> "call me at 555-5555" =~ digit_regex  # matches the first 5
=> 11

>> exact_digit_regex = /^(0|1|2|3|4|5|6|7|8|9)$/
>> exact_digit_regex
=> /^(0|1|2|3|4|5|6|7|8|9)$/
>> "1920" =~ exact_digit_regex
=> nil
>> "8" =~ exact_digit_regex
=> 0
```

Matching digits is so common that there's a special shorthand for
`/0|1|2|3|4|5|6|7|8|9/`. You can use write `/\d/`:

```ruby
>> "Year: 1156" =~ /\d/  # matches first digit
=> 6
>> "-2.7" =~ /\d/        # 
=> 1
>> "apple" =~ /\d/       # nil if no match
=> nil

>> "-2.7" =~ /^\d$/      # "-2.7" is not a digit, no match
=> nil
>> "2" =~ /^\d$/         # match: "2" is a digit
=> 0
>> " 2" =~ /^\d$/        # " 2" is not a digit, no match
=> nil
```

In general, if `s` is a string, then `s =~ /\d/` returns the index of the
first digit in `s`, or `nil` if there are no digits. `s =~ /^\d$/` matches one
of the ten strings `"0"`, `"1"`, `"2"`, ..., `"9"`.


## Matching Multiple Digits

Suppose you want to find if a string contains a sequence of two digits in a
row. For example, "It's 1965!" and "88 keys" both have sequences of two
digits, while "1 or 2" and "3.1" do not. The regular expression `/\d\d/` will match 2 digits:

```ruby
>> "It's 1965!" =~ /\d\d/  # matches 19
=> 5
>> "88 keys" =~ /\d\d/     # matches 88
=> 0
>> "1 or 2" =~ /\d\d/      # no match
=> nil
>> "3.1" =~ /\d\d/         # no match
=> nil

>> "88 keys" =~ /^(\d\d)$/ # "88 keys" is not a 2-digit string, no match
=> nil
>> "88" =~ /^(\d\d)$/      # matched: "88" is a 2-digit string 
=> 0
>> "88 " =~ /^(\d\d)$/     # "88 " is not a 2-digit string, no match
=> nil
```

By combining multiple `\d`s together you can match any *fixed* number of
digits in a row. For example, `/\d\d\d\d/` matches a sequence of 4 digits.

But what if you want to match a sequence of *one or more* digits? The regular
expression operator `+` matches the regular expression *before* it 1 or more
times:

```ruby
>> "There are 365 days in a year" =~ /\d+/ # matches "365"
=> 10
>> "(605)555-5555" =~ /\d+/                # matches "605"
=> 1
>> "cat" =~ /\d+/                          # no match
=> nil

>> "898" =~ /^(\d+)$/    # "898" is a string of 1 or more digits
=> 0
>> "-898" =~ /^(\d+)$/   # "-898" is not a string of digits, no match
=> nil
>> "" =~ /^(\d+)$/       # "" is not a string of 1 or more digits, no match
=> nil
```

In general, `s =~ /d+/` returns the first index of the first sequence of 1 or
more digits in `s` (or `nil` if it contains on digits). `s =~ /^d+$/` matches
only strings that consist entirely of 1, or more, digit characters.

## Optional Matches

Suppose we want to match *integer strings*, i.e. strings that look like
integers, such as "347", "0", or "-458". We could describe such strings in
English like this:

	Integer strings consist of 1 or more digits, and, optionally, may start
	with a "-" character.

In the language of Ruby regular expressions, the `?` operator makes the
expression *before* it optional. So we can match integer strings like this:

```ruby
>> "It's 25" =~ /-?\d+/    # matches "25"
=> 5
>> "It's -25" =~ /-?\d+/   # matches "-25"
=> 5

>> "-43" =~ /^(-?\d+)$/    # matches entire string
=> 0
>> "700912" =~ /^(-?\d+)$/ # matches entire string
=> 0
=> nil
>> "2-3" =~ /^(-?\d+)$/    # no match: the "-" must be at the start
=> nil
>> "-" =~ /^(-?\d+)$/      # no match: there must be 1 or more digits after
=> nil                     #           the "-"
```

## Improved Integer String Matching

Above we created these regular expressions that match integer strings:

```ruby
>> int_str_regex = /-?\d+/
>> exact_int_str_regex = /^(-?\d+)$/
```

A possible problem with them is that they match extra leading 0s at the start:

```ruby
>> "0" =~ exact_int_str_regex        # match: "0" is an integer
=> 0
>> "02" =~ exact_int_str_regex       # match: Do we want to count this as an 
=> 0                                 #        integer?
>> "-000002" =~ exact_int_str_regex  # match: Do we want to count this as
=> 0                                 #        an integer? 
```

Whether or not we count "02" or "-000002" as integer strings depends upon the
application we have in mind.

For the sake of this example, lets suppose we *don't* want any extra leading
0s, i.e. strings like "02" or "-000002" *don't* count as integer strings.

How can we modify `int_str_regex` and `exact_int_str_regex` to match only
integer strings *without* extra leading 0s? It helps to describe what we want
in
English:

	An integer string without extra leading 0s consists of 1 or more digits in
	sequence, optionally starting with a "-". The first digit can't be 0.

`\d` matches the digits 0 to 9, but how could we match just digits 1 to 9
(without matching 0)? One expression that works is `1|2|3|4|5|6|7|8|9`. That's
a lot of typing, so regular expressions also provide this shorthand notation:
`[1-9]`.

This suggests an expression like this might work:

```ruby
exact_wrong = /^(-?[1-9]\d+)$/   # close, but has some problems
```

As the name suggests, this expression is not completely correct. It handles
some strings correctly:

```ruby
>> "28" =~ exact_wrong    # match: "28" is an integer string
=> 0
>> "-28" =~ exact_wrong   # match: "-28" is an integer string
=> 0
>> "028" =~ exact_wrong   # no match: "028" has a leading 0
=> nil
>> "-028" =~ exact_wrong  # no match: "-028" has a leading 0
=> nil
```

But it *doesn't* work for strings like these:

```ruby
>> "5" =~ exact_wrong    # no match: but "5" is an integer string
=> nil
>> "-5" =~ exact_wrong   # no match: but "-5" is an integer string
=> nil
>> "0" =~ exact_wrong    # no match: but "0" is an integer string
=> nil
```

The problem with `/^(-?[1-9]\d+)$/` is that `\d+` matches *one* or more
strings. But here we want to match *zero* or more strings. Fortunately,
there's a regular expression operator just does that: `*`. The regular
expression `a*` matches *zero* or more occurrences of "a", namely these
strings: "", "a", "aa", "aaa", "aaaa", "aaaaa", .... Changing the `+` to a `*`
improves things:

```ruby
exact_still_wrong = /^(-?[1-9]\d*)$/   # better, but still not right
```

It matches more strings correctly, but still not all:

```ruby
>> "5" =~ exact_still_wrong     # match: "5" is an integer
=> 0
>> "005" =~ exact_still_wrong   # no match: "005" has leading 0s
=> nil
>> "-5" =~ exact_still_wrong    # match: "-5" is an integer
=> 0
>> "-005" =~ exact_still_wrong  # match: "-005" has leading 0s
=> nil
>> "0" =~ exact_still_wrong     # no match: but "0" is an integer string
=> nil
```

So `exact_still_wrong` *doesn't* match "0", which is a mistake. How can we get
that to work? The simplest way is to use `|` (the or operator) and treat "0"
as a special case:

```ruby
exact_int_no_leading_0s = /^(0|(-?[1-9]\d*))$/   # good!
```

Notice a couple of things:

- We added an extra pair of `()`-brackets around `-?[1-9]\d*` to make it clear
  what is on the right side of `|`.
- The `0|` is *before* the `-?`. If we write the `-?` first, then we'd match
  "-0", which is not usual:

  ```ruby
  >> "-0" =~ /^(-?(0|[1-9]\d*))$/
  => 0
  ```

It's can be tricky to get regular expressions *exactly* right. When testing
them, you need to check both the strings that *should* match, and the strings
that *shouldn't*. In practice, many programmers thus see regular expressions
as a mixed blessing: they provide a compact and efficient way to solve
string-matching problems, but they can be hard to read and difficult to test.

Regular expressions can do much more, but we'll stop here. You can find more
examples and tutorials on the web.


## Summary

Here are some examples that are useful to remember when working with regular
expressions:

| **Regular Expression** |        **Strings Matched**        |
|:----------------------:|:---------------------------------:|
| /ab/                   | "ab"                              |
| /a?b/                  | "b", "ab"                         |
| /a?b?/                 | "", "a", "b", "ab"                |
| /a+/                   | "a", "aa", "aaa", "aaaa", ...     |
| /a*/                   | "", "a", "aa", "aaa", "aaaa", ... |
| /(ab)+/                | "ab", "abab", "ababab", ...       |

Notes:

- Use `()`-brackets to disambiguate expressions, similar to how they are
  used in arithmetic. Use `\(` and `\)` if you want to match bracket
  characters:

     ```ruby
     >> "(aa)" =~ /\(a*\)/
     => 0
     ```

- `^` and `$` are special characters that don't match *characters*, but
  instead match *positions* in a string. `^` matches the position at the start
  of a string, and `$` matches the position at the very right end of a string.

## Practice Questions

Write a Ruby regular expression that, using `=~`, matches exactly strings:

1. consisting of zero or more "a" characters followed by zero or more "b"
   characters. For example: "", "a", "aa", "abb", "aaaaabbb", "bbb", ....
2. consisting of 0 or more "a" and "b" characters, in any order: "", "ab",
   "ba", "abaaa", "aaaa", "babababb", ....
3. consisting of an *even* number of "a" characters: "", "aa", "aaaa",
   "aaaaaa", ....
4. consisting of one or more *even* digit characters: "2", "48", "00022",
   "846620022866", ....
5. "yes", "yeah", "yep", and "uhuh".

## Practice Questions Solutions

1. `/^(a*b*)$/`
2. `/^((a|b)*)$/`
3. `/^((aa)*)$/`
4. `/^((0|2|4|6|8)*)$/`
5. `/^(yes|yeah|yep|uhuh)$/`
