# Strings

A Ruby **string** is a sequence of bytes, usually representing text. Ruby
strings are *mutable*, i.e. you can modify their characters in-place.

Strings are different than symbols. Symbols are used as identifiers, and we
don't usually access the individual characters of a symbol.

Ruby has a number of ways to represent string literals. `""`-quotes and
`''`-quotes, similar to other languages, are the most common.

```ruby
>> "hello, world!"
=> "hello, world!"

>> 'Hello, world!'
=> "Hello, world!"
```

## String Interpolation

**String Interpolation** lets you evaluate arbitrary Ruby expressions inside a
string:

```ruby
>> "I have #{3 + 1} cookies."
=> "I have 4 cookies."

>> "Hello #{gets.chomp}, how are you?"
Egbert   # typed in by the user
=> "Hello Egbert, how are you?"
```

You can also use `''`-quoted strings, but `#{...}` notation is not supported:

```ruby
>> 'I have #{3 + 1} cookies.'
=> "I have \#{3 + 1} cookies."
```

Ruby strings can have *line breaks* in them:

```ruby
"> "Ruby strings can
"> have more
"> than one line
>> !"
=> "Ruby strings can\nhave more\nthan one line\n!"
```

The special `">` prompt comes from *irb* (the Ruby interpreter), and indicates
a multi-line string is being entered.

Ruby also supports **heredocs** for larger strings, and the alternate literal
notations `%Q(...)` and `%q(...)`. We won't go into detail about those
features here, but you can find out more about them on the web.


## Accessing String Characters

Similar to arrays, you use []-bracket notation to access individual characters
and slices:

```ruby
>> s = "anyone can cook!"
>> s[0]
=> "a"

>> s[1]
=> "n"

>> s[-1]
=> "!"

>> s[-2]
=> "k"

>> s[7,3]
=> "can"

>> s[7..9]
=> "can"

>> s[7...10]
=> "can"
```

Ruby strings come with many pre-made methods:

```ruby
>> s = "elephant  "
>> s.length
=> 10

>> s.capitalize
=> "Elephant  "

>> s.chop   # chop removes the last character of a string
=> "elephant "

>> s.chop.chop
=> "elephant"

>> s.split('e')
=> ["", "l", "phant  "]

>> s.split('')
=> ["e", "l", "e", "p", "h", "a", "n", "t", " ", " "]

>> s.upcase     # convert to uppercase
=> "ELEPHANT  "

>> s.count('e') # count how many times a substring occurs
=> 2

>> s.reverse
=> "  tnahpele"
>> s.each_char {|c| puts "'#{c}'" }  # each_char lets you apply
'e'                                  # a code block to each
'l'                                  # character in a string
'e'
'p'
'h'
'a'
'n'
't'
' '
=> "elephant  "
>> s.split('').each_with_index {|c,i| puts "s[#{i}] = '#{c}' "}
s[0] = 'e'
s[1] = 'l'
s[2] = 'e'
s[3] = 'p'
s[4] = 'h'
s[5] = 'a'
s[6] = 'n'
s[7] = 't'
s[8] = ' '

s[9] = ' '
=> ["e", "l", "e", "p", "h", "a", "n", "t", " ", " "]

>> t = "ha"
>> t + t   # + concatenates strings
=> "haha"

>> t + t + t
=> "hahaha"

>> t * 4   # same as t + t + t + t
=> "hahahaha"

>> t*20 + "!!"
=> "hahahahahahahahahahahahahahahahahahahaha!!"
```

See the [String class
documentation](https://ruby-doc.org/core-3.1.2/String.html) for all the string
methods.
