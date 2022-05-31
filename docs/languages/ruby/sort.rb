# sort.rb


#
# %w is a shorthand notation for creating an array of strings. It's the same
# as this:
#
#    files = ["hello.go", "hello.rb", "bits.rb", "bits.pl", "slice.go"]
#
files = %w(hello.go hello.rb bits.rb bits.pl slice.go)

#
# Another trick to create an array of strings is to call the ls command in the
# terminal using Ruby's backquote notation:
#
#    files = `ls`.split
#
# Of course, you need files in the current directory for this to return a
# useful array.
#

#
# Ruby's built-in sort method is the easiest way to sort an array.
#
print files, " original\n"
print files.sort, " sorted\n"
print files.sort.reverse, " reverse sorted\n"

#
# You can pass a block to sort to change how it compares elements. The value
# being compared must work with Ruby's "spaceship" operator a <=> b. The
# value of a <=> b is:
#
# - -1 if a < b
# - 0 if a == b
# - 1 if a > b
#
# For example:
#
# >> 5 <=> 6
# => -1
# >> 5 <=> 5
# => 0
# >> 5 <=> 4
# => 1
#
# All the standard types work with <=>, and you can implement your own for
# your own classes.
#
print files.sort { |a,b| b <=> a }, " reverse sorted\n"

#
# Randomly shuffles an array by returning -1, 0, or 1 at random.
#
print files.sort { |a,b| rand(-1..1) }, " randomly shuffled\n"


#
# Ruby's built-in sort_by method lets you sort an array using a key value
# specified by a function.
#
puts
print files, " original\n"
print files.sort_by { |i| i.length }, " smallest to biggest\n"
print files.sort_by { |i| i[-1] }, " last character\n"
print files.sort_by { |i| File.extname(i) }, " file extension\n"

#
# sort returns new sorted array, while sort! sorts the current array in-place
# without making a copy.
#
puts
print files, " before sort!\n"
files.sort!
print files, " after sort!\n"
files.reverse!
print files, " after reverse!\n"
