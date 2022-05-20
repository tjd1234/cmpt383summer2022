# Ruby Notes

## Ubuntu Installation

```bash
sudo apt install ruby
```

## Basic Usage

Run a Ruby program:

```bash
$ ruby prog.rb
```

Interactive interpreter:

```bash
$ irb --simple-prompt
```

Interactive interpreter with a Ruby program loaded:

```
$ irb -I . -r prog.rb
```

## Ruby Lectures

### Lecture 1,2 Ruby: Basics

- [hello_world.rb](hello_world.rb)
- [hello_name.rb](hello_name.rb)
- [count_up.go](count_up.rb)
- [count_down.rb](count_down.rb)
- [numbered_list.rb](numbered_list.rb)
- [primes.rb](primes.rb)
- [stats.rb](stats.rb)
- [filedemo.rb](filedemo.rb)

### Lecture 3 Ruby: Arrays, Slices, and Hashes

- [slices.md](slices.md)
- [bits.rb](bits.rb)
- [sort.rb](sort.rb)
- [hashes.md](hashes.md) and [symbols.md](symbols.md)
- [wordcount.rb](wordcount.rb)

### Lecture 4 Ruby: Strings and Regular Expressions

- [strings.md](strings.md)
- [regex.md](regex.md)

### Lecture 5,6 Ruby: Classes and Objects

- [shapes1.rb](shapes1.rb)
- [shapes2.rb](shapes2.rb)
- [shapes3.rb](shapes3.rb)
- [primes_oop.rb](primes_oop.rb)

### Lecture 7 Ruby: Blocks and Yield

- [yield.rb](yield.rb)


## Some Shortcuts

`%w` specifies a string array literal:

```ruby
>> %w(once upon a time)
=> ["once", "upon", "a", "time"]

>> %w(1 2 3 4)
=> ["1", "2", "3", "4"]
```

Putting a terminal command in backquotes runs that command and returns the
results as a string. For example, `` `ls` `` runs the `ls` command in the
current directory:

```ruby
>> `ls`
=> "README.md\ncount_down.rb\ncount_up.rb\nhello_name.rb\nhello_world.rb\n"

>> `ls`.split
=> ["README.md", "count_down.rb", "count_up.rb", "hello_name.rb", 
	"hello_world.rb"]
```

## Interpreter Notes

The `methods` method returns a list of an objects methods. Sorting the list
makes it easier to read:

```ruby
>>  "cat".methods.sort
=> [:!, :!=, :!~, :%, :*, :+, :+@, :-@, :<, :<<, :<=, :<=>, :==, :===, :=~, :>, :>=, :[], :[]=, :__id__, :__send__, :ascii_only?, :b, :between?, :bytes, :bytesize, :byteslice, :capitalize, :capitalize!, :casecmp, :casecmp?, :center, :chars, :chomp, :chomp!, :chop, :chop!, :chr, :clamp, :class, :clear, :clone, :codepoints, :concat, :count, :crypt, :define_singleton_method, :delete, :delete!, :delete_prefix, :delete_prefix!, :delete_suffix, :delete_suffix!, :display, :downcase, :downcase!, :dump, :dup, :each_byte, :each_char, :each_codepoint, :each_grapheme_cluster, :each_line, :empty?, :encode, :encode!, :encoding, :end_with?, :enum_for, :eql?, :equal?, :extend, :force_encoding, :freeze, :frozen?, :getbyte, :grapheme_clusters, :gsub, :gsub!, :hash, :hex, :include?, :index, :insert, :inspect, :instance_eval, :instance_exec, :instance_of?, :instance_variable_defined?, :instance_variable_get, :instance_variable_set, :instance_variables, :intern, :is_a?, :itself, :kind_of?, :length, :lines, :ljust, :lstrip, :lstrip!, :match, :match?, :method, :methods, :next, :next!, :nil?, :object_id, :oct, :ord, :partition, :prepend, :private_methods, :protected_methods, :public_method, :public_methods, :public_send, :remove_instance_variable, :replace, :respond_to?, :reverse, :reverse!, :rindex, :rjust, :rpartition, :rstrip, :rstrip!, :scan, :scrub, :scrub!, :send, :setbyte, :singleton_class, :singleton_method, :singleton_methods, :size, :slice, :slice!, :split, :squeeze, :squeeze!, :start_with?, :strip, :strip!, :sub, :sub!, :succ, :succ!, :sum, :swapcase, :swapcase!, :taint, :tainted?, :tap, :then, :to_c, :to_enum, :to_f, :to_i, :to_r, :to_s, :to_str, :to_sym, :tr, :tr!, :tr_s, :tr_s!, :trust, :undump, :unicode_normalize, :unicode_normalize!, :unicode_normalized?, :unpack, :unpack1, :untaint, :untrust, :untrusted?, :upcase, :upcase!, :upto, :valid_encoding?, :yield_self]
```

Just the string methods:

```ruby
>> (String.instance_methods - Object.instance_methods).sort
=> [:%, :*, :+, :+@, :-@, :<, :<<, :<=, :>, :>=, :[], :[]=, :ascii_only?, :b, :between?, :bytes, :bytesize, :byteslice, :capitalize, :capitalize!, :casecmp, :casecmp?, :center, :chars, :chomp, :chomp!, :chop, :chop!, :chr, :clamp, :clear, :codepoints, :concat, :count, :crypt, :delete, :delete!, :delete_prefix, :delete_prefix!, :delete_suffix, :delete_suffix!, :downcase, :downcase!, :dump, :each_byte, :each_char, :each_codepoint, :each_grapheme_cluster, :each_line, :empty?, :encode, :encode!, :encoding, :end_with?, :force_encoding, :getbyte, :grapheme_clusters, :gsub, :gsub!, :hex, :include?, :index, :insert, :intern, :length, :lines, :ljust, :lstrip, :lstrip!, :match, :match?, :next, :next!, :oct, :ord, :partition, :prepend, :replace, :reverse, :reverse!, :rindex, :rjust, :rpartition, :rstrip, :rstrip!, :scan, :scrub, :scrub!, :setbyte, :size, :slice, :slice!, :split, :squeeze, :squeeze!, :start_with?, :strip, :strip!, :sub, :sub!, :succ, :succ!, :sum, :swapcase, :swapcase!, :to_c, :to_f, :to_i, :to_r, :to_str, :to_sym, :tr, :tr!, :tr_s, :tr_s!, :undump, :unicode_normalize, :unicode_normalize!, :unicode_normalized?, :unpack, :unpack1, :upcase, :upcase!, :upto, :valid_encoding?]
```

You can search for specific names using `grep /regex/`:

```ruby
>> "cat".methods.grep /du/
=> [:undump, :dump, :dup]

>> ("cat".methods.grep /du/).sort
=> [:dump, :dup, :undump]
```

You can find the arity (number of inputs) of a method like this:

```ruby
>> "cat".method(:insert).arity
=> 2

>> "cat".insert(1, "h")
=> "chat"

>> "cat".method(:sum).arity
=> -1    # sum has variable number of arguments

>> "cat".sum
=> 312   # sum of the ASCII values of "cat"
```
