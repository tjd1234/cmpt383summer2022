# Ruby Symbols

Ruby **symbols** are similar to strings, but with symbols we don't usually
care about accessing the individual characters. A symbol is an identifier,
while a string is a sequence of characters.

Ruby symbols always begin with a :, e.g. `:one`, `:return`, and `:flag` are
all symbols. Practically speaking, this makes symbols a little more convenient
to type than strings. These are all different Ruby values:

- `return`, a keyword
- `"return"`, a string
- `:return`, a symbol

In Ruby, strings are *mutable* by default, i.e. you can modify the characters
in a string:

```ruby
>> s = 'store'
>> s[-1] = 'm' # s[-1] refers to the last character of s
>> s
=> "storm"
```

But Ruby symbols are *immutable*, i.e. once you create a symbol it can never
change. This makes symbols useful as hash table keys. In a hash table, the
value associated with a key depends upon the keys hash value, and so if you
use a mutable key (such as a string), you run the risk of accidentally
modifying the key and thus changing its hash value. You could end up losing
track of data in your hash.

In contrast, if you use symbols as keys, you can never change the symbol and
thus you can never accidentally ruin the hash table.

Finally, one other virtue of symbols over strings is that they can be more
memory efficient. This examples shows that every time we write the string
`"flag"` a new string object is created:

```ruby
>> "flag".object_id   # each string is a brand new string
=> 220
>> "flag".object_id
=> 240
>> "flag".object_id
=> 260
```

But every time we write the symbol `:flag` we are referring to the *same*
object:

```ruby
>> :flag.object_id   # the same symbol each time
=> 544668
>> :flag.object_id
=> 544668
>> :flag.object_id
=> 544668
```
