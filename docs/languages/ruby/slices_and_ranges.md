# Ruby: Notes on Slices and Ranges

## []-bracket Notation

If `arr` is a Ruby array or string, `arr[i]` evaluates to the element at index
location `i`. Index values are 0-based, i.e. `arr[0]` is the first element,
`arr[1]` is the second element, and so on, up to the last element
`arr[arr.length - 1]`. `nil` is returned if you access an element outside of
the legal range of the array.

Negative indexing is allowed: `arr[-1]` is the *last* element, `arr[-2]` is
the *second to last* element, `arr[-3]` is the *third to last* element, and so
on.

```ruby
>> arr = %w(a b c d e f)   # %w( ... ) is shorthand notation for creating arrays
>> arr                     #           of strings
=> ["a", "b", "c", "d", "e", "f"]

>> arr[0]
=> "a"

>> arr[1]
=> "b"

>> arr[5]
=> "f"

>> arr[6]
=> nil

>> arr[-1]   # same as arr[5]
=> "f"

>> arr[-2]   # same as arr[4]
=> "e"
```

## Comma Slices: arr[start, length]

A **comma-slice** has the form arr[start, length], where `start` is the
initial index and `length` is the number of elements from that start index
onward:

```ruby
>> arr = %w(a b c d e f)

>> arr
=> ["a", "b", "c", "d", "e", "f"]

>> arr[2, 2]
=> ["c", "d"]

>> arr[1, 3]
=> ["b", "c", "d"]

>> arr[6, 3]
=> []

>> arr[-3, 3]
=> ["d", "e", "f"]

>> arr[9, 5]
=> nil

>> arr[2, 500]
=> ["c", "d", "e", "f"]
```

## Slices with Both Endpoints: arr[begin..end]

A `..`-slice has the form `arr[begin..end]`, where `begin` is the initial
index, and `end` is the last index. All the items from `arr[begin]` up to, and
including, `arr[end]`, are in the slice.

```ruby
>> arr = %w(a b c d e f)

>> arr
=> ["a", "b", "c", "d", "e", "f"]

>> arr[2..4]
=> ["c", "d", "e"]

>> arr[1..5]
=> ["b", "c", "d", "e", "f"]

>> arr[..3]              # same as arr[0..3]
=> ["a", "b", "c", "d"]

>> arr[2..]              # same as arr[2..5]
=> ["c", "d", "e", "f"]

>> arr[-3..-1]           # same as arr[3..]
=> ["d", "e", "f"]

>> arr[-1..-3]
=> []

>> arr[10..20]
=> nil
```

## Slices with One Endpoint: arr[begin...end]

A `...`-slice has the form `arr[begin...end]`, where `begin` is the initial
index, and `end` is *one past* the last index. All the items from `arr[begin]`
up to, and including, `arr[end-1]`, are in the slice. Importantly, `arr[end]`
is *not* included in a `...` slice.

```ruby
>> arr = %w(a b c d e f)

>> arr
=> ["a", "b", "c", "d", "e", "f"]

>> arr[2...4]
=> ["c", "d"]

>> arr[1...5]
=> ["b", "c", "d", "e"]

>> arr[...3]
=> ["a", "b", "c"]

>> arr[2...]
=> ["c", "d", "e", "f"]

>> arr[-3...-1]
=> ["d", "e"]

>> arr[-1...-3]
=> []
```

## Ranges

In Ruby, a range is a sequence of values. For example, these are all ranges
use `..` notation to specify a range (`to_a` converts the range to an array):

```ruby
>> (0..5).to_a
=> [0, 1, 2, 3, 4, 5]

>> (-3..2).to_a
=> [-3, -2, -1, 0, 1, 2]

>> ('a'..'f').to_a
=> ["a", "b", "c", "d", "e", "f"]

>> ('hop'..'hot').to_a
=> ["hop", "hoq", "hor", "hos", "hot"]
```

You can also use `...` notation, which excludes the ending value:

```ruby
>> (0...5).to_a
=> [0, 1, 2, 3, 4]
>> (-3...2).to_a
=> [-3, -2, -1, 0, 1]
>> ('a'...'f').to_a
=> ["a", "b", "c", "d", "e"]
>> ('hop'...'hot').to_a
=> ["hop", "hoq", "hor", "hos"]
```

You can iterate directly on a range without converting it to an array:

```ruby
>> (3..7).each {|i| puts "#{i}^2 = #{i*i}"}
3^2 = 9
4^2 = 16
5^2 = 25
6^2 = 36
7^2 = 49
=> 3..7
```

The documentation for Ruby's [`Range`
class](https://ruby-doc.org/core-2.5.1/Range.html) is worth looking at. In
addition to a few `Range`-specific methods, `Range` also includes the
[`Enumerable` class](https://ruby-doc.org/core-2.5.1/Enumerable.html), which
provides and assortment of other helpful methods. For instance, the `.to_a`
(converts a range to an array) is defined in
[`Enumberable`](https://ruby-doc.org/core-2.5.1/Enumerable.html).
