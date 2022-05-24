# numbered_list.rb

#
# pets is an array
#
pets = ["cat", "dog", "bird", "hamster"]

#
# each_with_index returns the index and corresponding value. It is similar to
# range in Go.
#
pets.each_with_index {|s,i| puts "#{i+1}. #{s}"}

puts "-" * 25

# do/begin style
pets.each_with_index do |s,i| 
	puts "#{i+1}. #{s}"
end
