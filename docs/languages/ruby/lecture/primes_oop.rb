# primes_oop.rb

#
# To load this code into the Ruby interpreter:
#
#   $ irb -I . -r primes_oop.rb --simple-prompt
#

#
# is_prime? and primes_less_than are defined as methods in Integer, and so any
# integer can call them as a method.
#
class Integer
    #
    # Returns true if the integer n is prime, and false otherwise.
    #
    # def is_prime?
    #     if self < 2  # self refers to the value of the object
    #         return false
    #     elsif self == 2
    #         return true
    #     elsif even?  # even? is a method in Integer
    #         return false
    #     else
    #         candidate = 3
    #         while candidate * candidate <= self
    #             # return false if self % candidate == 0
    #             return false if remainder(candidate) == 0
    #             candidate += 2
    #         end
    #         return true
    #     end
    # end

    #
    # Alternative implementation that is a little shorter.
    #
    # Returns true if the integer n is prime, and false otherwise.
    #
    def is_prime?
        return false if self < 2    # self refers to the value of the object
        return true if self == 2
        return false if self.even?  # even? is a method in Integer

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
    # Returns the number of primes less than the integer n.
    #
    def primes_less_than
        (1..self-1).count {|i| i.is_prime?}
    end
end

30.times do |n| 
    puts "#{n}: #{n.is_prime?}"
end

max = 1000 # 1229 for 1000
puts "Number of primes less than #{max}: #{max.primes_less_than}"
