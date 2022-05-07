# Ruby: Notes on Slices

## []-bracket Notation

If `arr` is a Ruby array or string, `arr[i]` evaluates to the element at index
location `i`. Index values are 0-based, i.e. `arr[0]` is the first element,
and arr[arr.length - 1] is the last element.

Negative indexing is allowed: `arr[-1]` is the last element, `arr[-2]` is the
second to last element, `arr[-3]` is the third to last element, and so on.

```ruby
>> arr = %w(a b c d e f)
>> arr
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
initial index and `length` is the number of elements.

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

A `..`-slice has the form `arr[begin..end]`, `begin` is the initial index, and
`end` is the last index. All the items from `arr[begin]` up to, and including,
`arr[end]`, are in the slice.

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

A `...`-slice has the form `arr[begin...end]`, `begin` is the initial index,
and `end` is one past the last index. All the items from `arr[begin]` up to,
and including, `arr[end-1]`, are in the slice. Importantly, `arr[end]` is
*not* included in a `...` slice.

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
