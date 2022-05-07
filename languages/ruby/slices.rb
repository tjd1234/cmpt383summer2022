# slices.rb

#
# Demonstrates different ways to slice arrays and strings in Ruby.
#

#
# Sample array. The %w notation is a convenient way to create an array of
# strings.
#
arr = %w(a b c d e f)
puts "arr = #{arr}"
puts

#
# []-bracket notation accesses individual elements,
# Index values start at 0
#
puts arr[0]              # first element
puts arr[1]
puts arr[2]
puts arr[3]
puts arr[4]
puts arr[5]              # last element
puts arr[arr.length - 1] # last element
puts arr[-1]             # last element
puts arr[-2]             # second to last element

#
# Out of range index values return nil
#
puts "arr[10] evaluates to nil" if arr[10] == nil
puts "arr[10] = #{arr[10]}"

#
# arr[start, length]
#
# A comma-slice takes a starting index and the number of elements you want.
#
#          0 1 2 3 4 5
# arr = %w(a b c d e f)
#
puts "#{arr[2, 2]}"
puts "#{arr[1, 3]}"
puts "#{arr[6, 3]}"
puts "#{arr[-3, 3]}"

#
# Out of range slices return nil.
#
puts "arr[9, 5] == nil" if arr[9, 5] == nil

#
# arr[start..stop]
#
# A ".."-slice takes a starting index and an index, and returns the slice that
# starts and stops, there including both end points.
#
#          0 1 2 3 4 5
# arr = %w(a b c d e f)
#
puts "#{arr[2..4]}"
puts "#{arr[..3]}"    # same as arr[0..3]
puts "#{arr[2..]}"    # same as arr[2..5]
puts "#{arr[-3..-1]}"
puts "#{arr[-1..-3]}"

