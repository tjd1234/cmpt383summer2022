# Ruby Object-oriented Programming

Ruby has good support for object-oriented programming, and this note we'll
discuss some of its major features.

Like many other languages, Ruby has **classes** that contain values and
methods. Using a class, you can create an **object** of the type of that
class. The `.class` method returns the class of an object:

```ruby
>> 4.class
=> Integer

>> 4.0.class
=> Float

>> "4".class
=> String

>> :flag.class
Symbol

>> [4,4].class
=> Array

>> {a: 1, b:2, c:3}.class
=> Hash

>> (1..5).class
=> Range

>> true.class
=> TrueClass

>> false.class
=> FalseClass

>> 4.class.class  # a class an object of type Class
=> Class

>> nil.class
=> NilClass
```

In Ruby, a class can inherit from one other class (inheriting from more than
one class is not allowed). The class a class inherits from is called its
**superclass**:

```ruby
>> 4.class
=> Integer
>> 4.class.superclass
=> Numeric
>> 4.class.superclass.superclass
=> Object
>> 4.class.superclass.superclass.superclass
=> BasicObject
>> 4.class.superclass.superclass.superclass.superclass
=> nil
```

This tells us that `4` is an object of type `Integer`, and also that:

- `Integer` inherits from the class `Numeric`. All Ruby number classes
  inherits from [`Numeric`](https://ruby-doc.org/core-2.5.0/Numeric.html).

- `Numeric` inherits from the class `Object`. All Ruby classes inherit from
  [`Object`](https://ruby-doc.org/core-3.1.2/Object.html). When you create a
  new Ruby class, if the class doesn't explicitly inherit from another class
  that it inherits from
  [`Object`](https://ruby-doc.org/core-3.1.2/Object.html) by default.

- `BasicObject` *doesn't* inherit from any class. The purpose of this class is
  if you want to create your own object hierarchy different from the default
  one rooted at [`Object`](https://ruby-doc.org/core-3.1.2/Object.html).
  Creating an alternate hierarchy of classes would be a pretty rare and
  unusual thing to do in Ruby. But the option is there if you want it.

## Creating Your Own Class

Here is an example of class for representing (x, y) points:

```ruby
class Point1
    def initialize(x, y) # construct with Point1.new(x, y)
        @x = x
        @y = y
    end

    def get_x     # getter
        @x
    end

    def set_x(x)  # setter
        @x = x
    end

    def get_y     # getter
        @y
    end

    def get_y(y)  # setter
        @y = y
    end

    def to_s  # convert to a string
        "(#{@x}, #{@y})"
    end
end # Point1
```

The `@` character in front of a variable indicates that its an **instance
variable**, e.g. `@x` an `@y` are instance variables of the `Point1` class.
You can also refer to instance variables (and methods) using `self`] e.g.
`self.x` is the same as `@x`.

Recall that, by default, Ruby returns the value of the last line of a function
or method, so we don't bother writing `return` in any of the methods.

By default, `Point1` inherits the `Object` class, and so it inherits all the
methods defined in `Object`. One of the methods defined in `Object` is `to_s`,
which returns a string representation of an object. The default `to_s` returns
the name of the class and id of the object, which usually isn't very helpful.
So `Point1` over-rides the default `to_s` with its own custom version that
prints a point in a standard way.

You can create a `Point1` like this:

```ruby
p = Point1.new(2, -5)  # class Point1.initialize
puts p       # calls to_s
# puts p.x   # error: cannot access instance variable directly
puts p.get_x
puts p.get_y

p.set_x(0)
p.set_y(0)
puts p
```

## Simplifying Getters and Setters

A common complaint about object-oriented programming is that getters and
setters are both tedious to write, and awkward to use. For example, most
programmers would prefer to write `p.x = 0` instead of `p.set_x(0)`.

Ruby provides a solution to that problem with `attr_accessor`:

```ruby
class Point2
    attr_accessor :x, :y

    def initialize(x, y)
        @x = x
        @y = y
    end

    def to_s
        "(#{@x}, #{@y})"
    end
end # Point2
```

`attr_accessor` creates default getters and setters for `x` and `y` that work
more conveniently:

```ruby
p = Point2.new(2, -5)
puts p
puts p.x
puts p.y

p.x = 0
p.y = 0
puts p
```

## Inheritance

When you create a new Ruby class, you can have it inherit from another class
if you like. If you don't explicitly inherit from a class, then Ruby
implicitly makes it inherit from the standard `Object` class.

For example, we can make a class representing a named point by inheriting from
`Point2`:

```ruby
class NamedPoint < Point2
    attr_accessor :name

    def initialize(name, x, y)
        super(x, y)
        @name = name
    end

    def to_s
        @name + super.to_s
    end
end # NamedPoint
```

Note the following:

- `<` indicates inheritance: `Point2` is the **superclass** of `NamedPoint`
- `super(x, y)` in `initialize` calls `Point2.initialize` to properly
  initialize `x` and `y`
- `to_s` over-rides the `to_s` in `Point2`, but also calls it using
  `super.to_s`


## Modules and Mix-ins

Ruby only allows single-inheritance, i.e. a class an inherit from only one
other class at a time. While it is possible to allow a class to inherit from
more than one class (**multiple inheritance**), Ruby does *not* permit that
since it introduces too many complexities. For example, if Ruby was allowed to
inherit from a class `A` and another class `B`, and both classes had their own
public `to_s` method, which implementation of `to_s` should the class inherit?

Instead, Ruby allows a class to *include* one or more **modules**. A module is
a collection of variables and values, and when a class includes a module it
can use those variables and values as it they had been defined in the class.
Including a module into a class is referred to as a **mix-in**.

Here's an example of a module (from the Ruby chapter of the book [Seven
Languages in Seven
Weeks](https://pragprog.com/titles/btlang/seven-languages-in-seven-weeks/))
that writes an object to a file:

```ruby
module ToFile
    def filename
        "object_#{self.object_id}.txt"
    end

    def to_f
        File.open(filename, 'w') {|f| f.write(to_s)}
    end
end
```

Notice that `to_s` is called inside the `to_f` method, but `to_s` is *not*
defined anywhere yet. `to_s` will end up calling the `to_s` method in the
class it's included in.

You include a module in a class like this:

```ruby
class NamedPoint2 < Point2
    include ToFile

    attr_accessor :name

    def initialize(name, x, y)
        super(x, y)
        @name = name
    end

    def to_s
        @name + super.to_s
    end
end # NamedPoint2
```

Now we can write code like this:

```ruby
p = NamedPoint2.new("p", 2, -5)
puts p
puts p.name
puts p.x
puts p.y

p.name = "q"
p.x = 0
p.y = 0
puts p

puts "Writing #{p} to #{p.filename} ..."
p.to_f
```

As an aside, mix-ins can have name collisions that can be the source of
confusion. For example, an answer in this [Stack Overflow question illustrates
the
problem](https://stackoverflow.com/questions/1282864/ruby-inheritance-vs-mixins):

```ruby
module A
  FRUIT = "apple"
  def sayname
    puts FRUIT
  end
end

module B
  FRUIT = "orange"
  def sayname
    puts FRUIT
  end
end

class C
  include A
  include B
end

c = C.new
c.sayname    # What does this print?
```

## The Comparable and Enumerable Modules

Ruby has a number of standard modules that you can, if you choose, include in
your own classes.

One of the most useful is
[Comparable](https://docs.ruby-lang.org/en/2.5.0/Comparable.html). It provides
implementation of standard relational operators such as `<`, `<=`, `==`, and
so on. To use
[Comparable](https://docs.ruby-lang.org/en/2.5.0/Comparable.html) your class
must both include it, and implement the `<=>` operator.

Similarly, the [Enumerable](https://ruby-doc.org/core-2.6.3/Enumerable.html)
module provides a large number of methods that work on array-like classes. To
use it, your class must both include
[Enumerable](https://ruby-doc.org/core-2.6.3/Enumerable.html) and implement an
`each` method that yields each element of the class.

Here's an example of to use both
[Comparable](https://docs.ruby-lang.org/en/2.5.0/Comparable.html) and
[Enumerable](https://ruby-doc.org/core-2.6.3/Enumerable.html):

```ruby
class NamedPoint3 < Point2
    include ToFile
    include Comparable  # requires <=> operator
    include Enumerable  # requires each method

    attr_accessor :name

    def initialize(name, x, y)
        super(x, y)
        @name = name
    end

    def to_s
        "#{@name}(#{@x}, #{@y})"
        # @name + super.to_s
    end

    #
    # <=> is the "spaceship" operator, and a <=> b returns the following:
    # -  0 if a and b are the same
    # - -1 if a comes strictly before b
    # -  1 if a comes strictly after b
    #
    # For example:
    #
    # >> 3 <=> 3
    # => 0
    # >> 3 <=> 4
    # => -1
    # >> 3 <=> 2
    # => 1
    #
    # If a class implements <=>, then it can include the Comparable module and
    # get all the methods defined there:
    # https://docs.ruby-lang.org/en/2.5.0/Comparable.html
    #
    def <=>(b)
        [@x, @y] <=> [b.x, b.y]
        #
        # An alternative implementation:
        # return -1 if @x < b.x
        # return 1 if @x > b.x
        #
        # # at this point @x == b.x
        # return 0 if @y == b.y
        # return -1 if @y < b.y
        # return 1 if @y > b.y
    end

    #
    # By providing an implementation of each, all the methods defined in in
    # the Enumerable module work with NamedPoint3. It's as if a NamedPoint3
    # object is an array of 2 elements, x and y.
    #
    def each
        yield @x
        yield @y
    end
end # NamedPoint3
```

For now, don't worry about the details of the `each` method. The idea is that
`each` iterates through all the values in the class, which in the case of a
point is just its two coordinates, `x` and `y`. `yield` is similar to
`return`, except instead of ending the function `yield` gives a value and then
"pauses" the function so that it can be called again.


## A Note on Ruby's Philosophy of Object-oriented Programming

One of Ruby's goal is to make programming more *productive*, i.e. to decrease
the time it takes for programmers to write programs that are useful,
efficient, and correct.

Thus, Ruby provides many powerful features within the language that, when you
know about them, make your life as a programmer easier. For example, if you
know about `attr_accessor` it becomes fast and easy to create getters and
setters for your class. If you know how to include `Comparable` and
`Enumerable`, then you can implement many methods "for free" just by providing
a few key methods.

The result of all this can be that you write classes that pack in a large
number of features, and yet have very little code and appear quite simple. For
many programmers, this is very appealing, and makes them more productive.

A downside of this approach is that Ruby has a lot of features that are not
explicit, and you must learn a about how to best use these features. Reading
sophisticated Ruby code can be a challenge due to all the defaults and
built-in behaviour. In addition, all these hidden features also tend to make a
Ruby an inefficient language, in both time and memory.

There is no one answer about whether Ruby is a good or bad language. It
depends on your application, and how much you enjoy using Ruby features.
