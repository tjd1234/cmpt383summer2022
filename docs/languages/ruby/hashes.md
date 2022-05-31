# Ruby Hashes

A Ruby **hash** stores (key, value) pairs in a way that allows for very
efficient retrieval/insertion give a key.

Hash literals uses `{}`-brackets. If the keys are symbols, as they are in this
example, then you can use the notation *key:value* for a pair:

```ruby
>> order = {cheese: 4.99, cookies: 2.45, juice: 0.99}
```

For keys that are *not* symbols, use this notation: `{key1 => value1, key2 =>
value2, ...}`. This `=>` notation is also how `irb` (the Ruby interpreter)
displays hashes. Also, key/value pairs in a hash are presented in the order
that they were created.

```ruby
>> order
=> {:cheese=>4.99, :cookies=>2.45, :juice=>0.99}
```

You can get all the keys or values like this:

```ruby
>> order.keys
=> [:cheese, :cookies, :juice]
>> order.values
=> [4.99, 2.45, 0.99]
>> order.values.sum
=> 8.43
```

[]-bracket notation gets the value associated with a key. By default, `nil` is
returned if there is no matching key:

```ruby
>> order[:juice]
=> 0.99
>> order[:water]
=> nil
>> order[:water] = 6.50
>> order[:water]
=> 6.5
>> order
=> {:cheese=>4.99, :cookies=>2.45, :juice=>0.99, :water=>6.5}
```

You change the value of an existing key by assigning it a new value:

```ruby
>> order[:water] = 3.25
>> order
=> {:cheese=>4.99, :cookies=>2.45, :juice=>0.99, :water=>3.25}
```

Sorting a hash gives you a list of lists of all the key/value pairs sorted in
order by key:

```ruby
>> order.sort
=> [[:cheese, 4.99], [:cookies, 2.45], [:juice, 0.99], [:water, 6]]
```
