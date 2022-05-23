# stats.rb

#
# Read a text file of real numbers, one per line, and calculate their min,
# max, median, sum, average, and standard deviation (population version, not
# the sample version).
#

#
# Returns the standard deviation of an array of numbers.
#
# The expression nums.each {|x| (x - mean)**2} .sum / n works as follows:
#
# - (x - mean)**2 squares x - mean
# - nums.map {|x| (x - mean)**2} returns a new array created by applying
#   (x - mean)**2 to each element x of nums
# - .sum returns the sum of the numbers in the array created by nums.each
# - / n divides that sum by n, the size of the array
#
def std_dev(nums)
    n = nums.length
    mean = nums.sum / n
    diffs = nums.map {|x| (x - mean)**2}
    return Math.sqrt(diffs.sum / n)
end

#
# map applies a block of code to each given value in a container 
#
# s.to_f converts string s to a float.
#
nums = File.open("numbers.txt").readlines.map {|s| s.to_f}

#
# sort! modifies in-place the object being sorted
#
# nums.sort would returne a sorted copy
#
nums.sort!

puts nums.to_s
puts "        Min: #{nums[0]}"
puts "     Median: #{nums[nums.length / 2]}"
puts "        Max: #{nums[-1]}"
puts "        Sum: #{nums.sum}"
puts "       Mean: #{nums.sum / nums.length}"
puts "  Std. dev.: #{std_dev(nums)}"
