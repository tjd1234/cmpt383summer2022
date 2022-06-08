# bits.rb

#
# Print all bit strings of length n, for any integer n >= 0. There are an
# exponential number of bit strings and so it's okay if your program takes a
# long time to calculate large values of n.
#
# The strategy used to calculate all n-bit strings is to first recursively
# make two copies of all (n-1)-bit strings. To one copy '0' is appended to the
# start of each bit strings, and to the other '1' is appended. Then the two
# lists are appended together to get the final result.
#
def nbits(n)
    # non-recursive base cases
    return [] if n < 0
    return ['0','1'] if n == 1

    # recursive case
    n1bits = nbits(n-1)

    # map returns a new array
    zero = n1bits.map {|s| '0' + s}
    one = n1bits.map {|s| '1' + s}
    
    return zero + one
end

#
# Example
#
results = nbits(5)
results.each_with_index do |b,i|
    puts "#{b} #{i}"
end
