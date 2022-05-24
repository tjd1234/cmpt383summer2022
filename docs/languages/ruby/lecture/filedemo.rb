# filedemo.rb

#
# Prints a table of counts of all the file name extensions in the current
# directory.
#

#
# `ls` runs the ls command in the shell and returns the results as a string:
#
#   >> `ls`
#   => "austenPandP.txt\nbits.rb\ncount_down.rb\ncount_up.rb\nfiledemo.rb\n"
#
# split converts the string to a list of individual file names:
#
#   >> `ls`.split
#   => ["austenPandP.txt", "bits.rb", "count_down.rb", "count_up.rb", 
#       "filedemo.rb"]
#
files = `ls`.split

#
# Hash.new(0) creates a new empty hash table. The 0 means that if you ask for
# a key not in the table then 0 will be returned (otherwise nil would have
# been returned).
#
h = Hash.new(0)

#
# A helper function that returns the extension of a file name as a symbol,
# e.g. "README.md" returns :md. If s has no extension, then :none is returned.
#
# Ruby symbols are similar to strings, but with symbols we don't usually care
# about accessing the individual characters. A symbol is as an identifier,
# while a string is a sequence of characters.
#
# Ruby symbols always begin with a :, e.g. :one, :if, and :flag are all
# symbols. These are all different Ruby values:
#
# - return   a keyword
# - "return" a string
# = :return
#
def get_ext(s)
    # - get the extension of the file name using File.extname
    # - skip the initial '.' using [1..]
    # - convert it to a symbol using to_sym
    ext = File.extname(s)[1..].to_sym
    return ext unless ext == nil
    :none # last line of a function is its return value
end

#
# Loop through each file name and extract its extension and convert it to a
# symbol. Using the symbol as the key in hash table h, increment the count by
# 1 for that symbol. The result will be a hash table of file name extensions
# and their counts, such as:
#
#   {:md=>5, :txt=>3, :rb=>18, :pptx=>1}
#
files.each do |f|
    ext = get_ext(f)
    h[ext] += 1
end

#
# Converts the hash to a list of list pairs, e.g.:
#
# >> h = {:md=>5, :txt=>3, :rb=>18, :pptx=>1}
# >> h.to_a
# => [[:md, 5], [:txt, 3], [:rb, 18], [:pptx, 1]]
#
fcount = h.to_a

#
# Sort the list in-place from highest count to lowest.
#
fcount.sort! {|a,b| b[1] <=> a[1]}

#
# Print the counts and extensions in a nicely formatted table.
#
# For example:
#
#   18: rb
#    5: md
#    3: txt
#    1: pptx
#

puts 'Frequencies of extensions of files in this folder:'
fcount.each do |ext,count|
    puts "#{count.to_s.rjust(3)}: .#{ext}"
end
