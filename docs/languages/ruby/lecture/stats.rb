# stats.rb

#
# Read a text file of real numbers, one per line, and calculate their min,
# max, median, sum, average, and standard deviation (population version, not
# the sample version).
#

#
# Returns the standard deviation of an array of numbers.
#
# The expression nums.map {|x| (x - mean)**2} .sum works as follows:
#
# - nums.map {|x| (x - mean)**2} returns a new array created by applying (x -
#   mean)**2 to each element x of nums
# - .sum sums the numbers in the array created by nums.map
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
# sort! does the sorting in-place, i.e. it modifies the array being sorted
#
# In contrast, nums.sort doesn't change num and returns a new sorted copy.
#
nums.sort!

puts nums.to_s  # num.to_s returns a string
puts "        Min: #{nums[0]}"
puts "     Median: #{nums[nums.length / 2]}"
puts "        Max: #{nums[-1]}"
puts "        Sum: #{nums.sum}"
puts "       Mean: #{nums.sum / nums.length}"
puts "  Std. dev.: #{std_dev(nums)}"
