# yield.rb

#
# To load this code into the Ruby interpreter:
#
#   $ irb -I . -r yield2.rb --simple-prompt
#

#
# Yields 3 different values.
#
# >> yield_stuff {|x| puts x }
# start
# 3
# cow
# 2.09
# stop
# => nil
#
def yield_stuff
    puts "start"
    yield 3
    yield 'cow'
    yield 2.09
    puts "stop"
end

#
# Iterates from 0 up to, and including, n-1:
#
# >> mytimes(5) {|n| puts n**2}
# 0
# 1
# 4
# 9
# 16
# => 0...5
#
def mytimes(n)
    for i in 0...n  # ... excludes n
        yield i
    end
end

#
# mytimes implemented as a method of Integer:
#
# >> 5.mytimes {|n| puts n**2}
# 0
# 1
# 4
# 9
# 16
# => 0...5
#
class Integer
    def mytimes
        for i in 0...self  # ... excludes self
            yield i
        end
    end
end


#############################################################################

#
# Iterates through the digits of the number, as integers e.g.:
# 
# >> 4589.each_digit {|d| puts d}
# 4
# 5
# 8
# 9
# => "4589"
#
class Integer
    #
    # Generates each digit of the number, as an integer.
    #
    # Only works with non-negative numbers.
    #
    def each_digit
        s = self.to_s
        s.each_char do |c|
            yield c.to_i
        end
    end

    #
    # Returns true if the digit d occurs in this number, and
    # false otherwise.
    #
    def has_digit?(d)
        each_digit do |a|
            return true if d == a
        end
        return false
    end
end # Integer


#############################################################################

#
# Our own implementations of the standard Array methods each and
# each_with_index.
#
# >> %w(a b c).myeach {|s| puts s}
# a
# b
# c
# => 0...3
#
# %w(a b c) is shorthand for ["a", "b", "c"]
#
# >> %w(a b c).myeach_with_index {|i,s| puts "#{i+1}. #{s}"}
# 1. a
# 2. b
# 3. c
# => 0...3
#
class Array
    def myeach
        for i in (0...self.size)
            yield self[i]
        end
    end

    def myeach_with_index
        for i in (0...self.size)
            yield i, self[i]
        end
    end
end

#############################################################################

class String
    #
    # >> "apple".my_each_char {|c| puts c}
    # a
    # p
    # p
    # l
    # e
    # => 5
    #
    def my_each_char
        self.size.times do |i|
            yield self[i]
        end
    end

    #
    # >> "apple".just_vowels {|c| puts c}
    # a
    # e
    # => 5
    #
    def just_vowels
        my_each_char do |c|
            yield c if "aeiouAEIOU".include?(c)
        end
    end

    #
    # >> "apple".just_chars("abcde") {|c| puts c}
    # a
    # e
    # => 5
    #
    def just_chars(goodChars)
        my_each_char do |c|
            yield c if goodChars.include?(c)
        end
    end

    #
    # /[a-zA-Z]+/ matches strings consisting of 1, or more, letters in a row.
    # e.g.
    #
    # >> "one 2 three!".just_words {|w| puts w}
    # one
    # three
    # => ["one", "three"]
    #
    # String.scan(regex) returns an array of all substrings that match regex.
    #
    def just_words
        scan(/[a-zA-Z]+/).each {|w| yield w}
    end

    #
    # Same as just_words, but repeated words are excluded.
    #
    # >> "yes or no or yes or no".just_unique_words {|w| puts w}
    # yes
    # or
    # no
    # => ["yes", "or", "no", "or", "yes", "or", "no"]
    #
    def just_unique_words
        # seenIt stores words already seen
        seenit = Hash.new
        just_words do |w|
            if not seenit.include?(w) then
                seenit[w] = true
                yield w
            end
        end
    end

    #
    # Checks if word w occurs in the string as a complete word. Returns false
    # if w only occurs as a substring of another word.
    #
    # >> "this is a test".has_word?("test")
    # => true
    # >> "this is a test".has_word?("his")
    # => false
    #
    def has_word?(w)
        just_unique_words do |a|
            return true if w == a
        end
        return false
    end

end # String

#############################################################################

#
# This example is based on this posting:
# https://scoutapm.com/blog/ruby-yield-blocks
#
# You can use it to estimate the time it takes for a block to be executed.
#
def measure_seconds
    start = Time.now
    yield
    elapsed = Time.now - start
    puts "Elapsed seconds: #{elapsed}"
    return elapsed
end

# measure_seconds do
#     arr = (1..1000000).to_a
#     arr.shuffle!
#     arr.sort!
# end

#############################################################################

class Integer 
    #
    # Returns true if the integer n is prime, and false otherwise.
    #
    # >> 32883.is_prime?
    # => false
    # >> 32887.is_prime?
    # => true
    #
    def is_prime?
        return false if self < 2    # self refers to the value of the object
        return true if self == 2
        return false if even?       # even? is a method in Integer

        # self > 2, and odd
        candidate = 3
        while candidate * candidate <= self
            # return false if self % candidate == 0
            return false if remainder(candidate) == 0
            candidate += 2
        end
        return true
    end

    #
    # Iterates through all the primes less than this integer.
    #
    # >> 10.primes_less_than {|p| puts p}
    # 2
    # 3
    # 5
    # 7
    # => 2...10
    #
    def primes_less_than
        for i in (2...self)  # ... excludes self
            yield i if i.is_prime?
        end
    end

    #
    # Iterates through all the composites less than this integer.
    #
    # >> 10.composites_less_than {|p| puts p}
    # 1
    # 4
    # 6
    # 8
    # 9
    # => 1...10
    #
    def composites_less_than
         for i in (1...self)  # 1 is first composite; ... excludes self
            yield i if not i.is_prime?
        end       
    end
end # Integer

#
# Returns an infinite stream of prime numbers.
#
# Ruby's loop do construct loops forever.
#
def primes_forever
    yield 2
    n = 3
    loop do
        yield n if n.is_prime?
        n += 2
    end
end

#
# Returns the number of primes less than n.
#
def num_primes_less_than(n)
    count = 0
    primes_forever do |p|
        return count if p >= n
        count += 1
    end
end

def get_primes_less_than(n)
    result = []
    primes_forever do |p|
        return result if p >= n
        result.append(p)
    end  
end

def get_first_n_primes(n)
    result = []
    primes_forever do |p|
        return result if result.size >= n
        result.append(p)
    end  
end

#############################################################################

#
# Yields the first n Fibonacci numbers.
#
# >> fib(5) {|f| puts f}
# 1
# 1
# 2
# 3
# 5
# => 5
#
def fib(n)
    case n  # case is similar to a switch statement
    when 1
        yield 1
    when 2
        yield 1
        yield 1
    else # n > 2
        a, b = 1, 1
        n.times do |i|
            yield a
            a, b = b, a + b
        end
    end
end

#
# Returns an infinite stream of Fibonacci numbers.
#
# Ruby's loop do construct loops forever.
#
def fib_forever
    a, b = 1, 1
    loop do
        yield a
        a, b = b, a + b
    end
end

#
# Prints the Fibonacci numbers less than max.
#
def fib_less_than(max)
    fib_forever do |f|
        return if f >= max
        puts f
    end
end

#
# Prints the first n Fibonacci numbers.
#
def fibn(n)
    fib_forever do |f|
        return if n <= 0
        puts f
        n -= 1
    end
end
