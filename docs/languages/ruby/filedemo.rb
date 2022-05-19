# filedemo.rb

#
# Prints a table of counts of all the file name extensions in the current
# directory.
#

#
# `ls` runs the ls command in the shell and returns the results as a string.
# split converts the string to a list individual file names.
#
files = `ls`.split

#
# This creates a new empty hash table. The 0 means that if a key is not in the
# table then 0 will be returned (otherwise nil is returned).
#
h = Hash.new(0)

#
# Loop through each file name and extract its extension and convert it to a
# symbol. Using the symbol as the key in hash table h, increment the count by
# 1 for that symbol. The result will be a hash table of file name extensions
# and their counts.
#
# For example: {:md=>5, :txt=>3, :rb=>18, :pptx=>1}
#

#
# Returns the extension of a file name as a symbol, e.g. "README.md" returns
# :md. If s has no extension, then :none is returned.
#
def get_ext(s)
    # - get the extension of the file name using File.extname
    # - skip the initial '.' using [1..]
    # - convert it to a symbol using to_sym
    ext = File.extname(s)[1..].to_sym
    return ext unless ext == nil
    :none
end

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
fcount.each do |ext,count|
    puts "#{count.to_s.rjust(3)}: #{ext}"
end
