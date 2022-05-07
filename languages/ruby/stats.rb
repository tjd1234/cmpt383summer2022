# stats.rb

# Read a text file of real numbers, one per line, and calculate their min,
# max, median, sum, average, and standard deviation (population version, not
# the sample version).

def std_dev(nums)
	n = nums.length
	mean = nums.sum / n
	return Math.sqrt(nums.each {|x| (x - mean)**2} .sum / n)
end

# map applies a block to each given value in a container
# to_f converts all the strings to floats
nums = File.open("numbers.txt").readlines.map {|s| s.to_f}

# sort! modifies in-place the object being sorted
nums.sort!

puts nums.to_s
puts "        Min: #{nums[0]}"
puts "     Median: #{nums[nums.length / 2]}"
puts "        Max: #{nums[-1]}"
puts "        Sum: #{nums.sum}"
puts "       Mean: #{nums.sum / nums.length}"
puts "  Std. dev.: #{std_dev(nums)}"
