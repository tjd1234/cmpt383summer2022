# Ruby: each and map

Suppose `arr` is a Ruby array. Then the expression `arr.map {|x| f(x)}`
creates a new array that is the same as `arr` except `f` has been applied to
every element. For example, `[a, b, c].map {|x| f(x)}` returns a new array
`[f(a), f(b), f(c)]`.

```ruby
>> [1,2,3].map {|n| n+1}
=> [2, 3, 4]

>> [1,2,3].map {|n| n.to_s + " banana"}
=> ["1 banana", "2 banana", "3 banana"]

>> ["one", "two", "three"].map {|s| s.size}
=> [3, 3, 5]

>> ["one", "two", "three"].map {|s| s[0] + s[-1]}
=> ["oe", "to", "te"]

>> ["cat", "dogs", "mice"].map {|s| if   s[-1] == "s" 
	                                  then s 
	                                  else s + "s" end}
=> ["cats", "dogs", "mices"]
```

`each` is similar to `map`, except it does not make a new array, and instead
runs code block on each item of the original array. In other words, it's the
*side-effects* of the function that we care about. It is typically written in
do-style:

```ruby
arr.each do |x|
	f(x)
end
```

For instance, printing a string on the screen is a side-effect of `puts`, and
so this prints every element of an array:

```ruby
[1,2,3].each do |n|
  puts n
end
1
2
3
=> [1, 2, 3]
```

The last line is the value return by the expression, the original array. We
usually don't care about the return value of a  `.each` block.

A `.each` block is essentially equivalent to "for each" loops that appear in
other languages.

Since there is only a `puts` statement in the block, it is also pretty
readable to write it in {}-notation:

```ruby
>> [1,2,3].each {|s| puts s}
1
2
3
=> [1, 2, 3]
```
