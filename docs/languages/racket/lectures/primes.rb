# primes.rb

#
# Returns true if n is a prime number, false otherwise. Uses trial division to
# find factors.
#
# Ruby functions that return a boolean value customarily end with ?.
#

# def is_prime?(n)
#     if n < 2
#         false
#     elsif n == 2
#         return true
#     elsif n.even?
#         return false
#     else
#         candidate = 3
#         while candidate * candidate <= n
#             return false if n % candidate == 0
#             candidate += 2
#         end
#         return true
#     end
# end

#
# An alternative implementation using if as a modifier.
#
def is_prime?(n)
    return false if n < 2
    return true if n == 2
    return false if n.even?

    candidate = 3
    while candidate * candidate <= n
        return false if n % candidate == 0
        candidate += 2
    end
    return true
end


#
# Returns the number of primes less than the integer n.
#
# (1..n-1) is the range of integers from 1 up to, and including, n-1.
#
# (1..n-1).count {|i| is_prime?(i)} returns the number of ints from 1 to n-1
# that satisfy is_prime?, i.e. the number of primes from 1 to n-1 inclusive.
#
def primes_less_than(n)
    return (1..n-1).count {|i| is_prime?(i)}
end

#
# Which of the numbers from 0 to 30 are prime?
#
# Prints numbers and indicates which ones are prime.
#
count = 0
30.times do |n| 
    if is_prime?(n)
        count += 1
        puts "#{n} <--- prime #{count}"
    else
        puts "#{n}"
    end
end

max = 10000 # 1229 for 1000
puts "Number of primes less than #{max}: #{primes_less_than(max)}"
